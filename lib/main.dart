import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_vodozemac/flutter_vodozemac.dart' as vod;
import 'package:matrix/matrix.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/utils/client_manager.dart';
import 'package:fluffychat/utils/platform_infos.dart';
import 'config/setting_keys.dart';
import 'utils/background_push.dart';
import 'widgets/fluffy_chat_app.dart';
import 'package:fluffychat/utils/notification_background_handler.dart';


ReceivePort? mainIsolateReceivePort;

final FlutterLocalNotificationsPlugin _localNotifications =
FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel _androidChannel = AndroidNotificationChannel(
  'matrix_messages',
  'Сообщения',
  description: 'Уведомления о новых сообщениях в Matrix',
  importance: Importance.high,
);

Future<void> _initLocalNotifications() async {
  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

  const initSettings = InitializationSettings(
    android: androidInit,
  );

  await _localNotifications.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      // MVP: ничего не делаем. При открытии приложение синхронизируется само.
    },
  );

  final androidPlugin = _localNotifications
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();

  if (androidPlugin != null) {
    await androidPlugin.createNotificationChannel(_androidChannel);
  }
}

Future<void> _showMvpNotificationFromData(Map<String, dynamic> data) async {
  final roomId = data['room_id']?.toString();
  final unread = data['unread']?.toString();

  const title = 'BOLGAR Messenger';
  var body = 'Новое сообщение';

  if (roomId != null && roomId.isNotEmpty) {
    body += ' (комната: $roomId)';
  }
  if (unread != null && unread.isNotEmpty) {
    body += ' • непрочитано: $unread';
  }

  final details = NotificationDetails(
    android: AndroidNotificationDetails(
      _androidChannel.id,
      _androidChannel.name,
      channelDescription: _androidChannel.description,
      importance: Importance.high,
      priority: Priority.high,
    ),
  );

  await _localNotifications.show(
    DateTime.now().millisecondsSinceEpoch ~/ 1000,
    title,
    body,
    details,
    payload: jsonEncode(data),
  );
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();

  // В фоне нужен registrant, чтобы плагины (в т.ч. local_notifications) работали.
  // В большинстве актуальных Flutter это доступно через dart:ui.
  DartPluginRegistrant.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (_) {
    // Уже инициализировано — ок.
  }

  await _initLocalNotifications();

  // Sygnal шлёт data-only (event_id_only), поэтому берём message.data
  final data = Map<String, dynamic>.from(message.data);
  await _showMvpNotificationFromData(data);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ВАЖНО: иначе вы ловите "No Firebase App '[DEFAULT]'..."
  await Firebase.initializeApp();

  // ВАЖНО: иначе и будет ваш лог "no onBackgroundMessage handler..."
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await _initLocalNotifications();

  if (PlatformInfos.isAndroid) {
    final port = mainIsolateReceivePort = ReceivePort();
    IsolateNameServer.removePortNameMapping(AppConfig.mainIsolatePortName);
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      AppConfig.mainIsolatePortName,
    );
    await waitForPushIsolateDone();
  }

  final store = await AppSettings.init();
  Logs().i('Welcome to ${AppSettings.applicationName.value} <3');

  await vod.init(wasmPath: './assets/assets/vodozemac/');

  Logs().nativeColors = !PlatformInfos.isIOS;
  final clients = await ClientManager.getClients(store: store);

  if (PlatformInfos.isAndroid &&
      AppLifecycleState.detached == WidgetsBinding.instance.lifecycleState) {
    for (final client in clients) {
      client.backgroundSync = false;
      client.syncPresence = PresenceType.offline;
    }

    BackgroundPush.clientOnly(clients.first);
    WidgetsBinding.instance.addObserver(AppStarter(clients, store));
    Logs().i(
      '${AppSettings.applicationName.value} started in background-fetch mode. No GUI will be created unless the app is no longer detached.',
    );
    return;
  }

  Logs().i(
    '${AppSettings.applicationName.value} started in foreground mode. Rendering GUI...',
  );
  await startGui(clients, store);
}

Future<void> startGui(List<Client> clients, SharedPreferences store) async {
  String? pin;
  if (PlatformInfos.isMobile) {
    try {
      pin = await const FlutterSecureStorage().read(
        key: 'chat.fluffy.app_lock',
      );
    } catch (e, s) {
      Logs().d('Unable to read PIN from Secure storage', e, s);
    }
  }

  final firstClient = clients.firstOrNull;
  await firstClient?.roomsLoading;
  await firstClient?.accountDataLoading;

  runApp(FluffyChatApp(clients: clients, pincode: pin, store: store));
}

class AppStarter with WidgetsBindingObserver {
  final List<Client> clients;
  final SharedPreferences store;
  bool guiStarted = false;

  AppStarter(this.clients, this.store);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (guiStarted) return;
    if (state == AppLifecycleState.detached) return;

    Logs().i(
      '${AppSettings.applicationName.value} switches from the detached background-fetch mode to ${state.name} mode. Rendering GUI...',
    );
    for (final client in clients) {
      client.backgroundSync = true;
      client.syncPresence = PresenceType.online;
    }
    startGui(clients, store);
    guiStarted = true;
  }
}
