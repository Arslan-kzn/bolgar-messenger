import 'package:flutter/material.dart';

import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:fluffychat/l10n/l10n.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  static const String _privacyFullTextUrl =
      'https://github.com/Arslan-kzn/bolgar-messenger/blob/bolgar-onboarding-menu/PRIVACY.md';

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.privacy),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Кратко',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                'BOLGAR Messenger — Matrix-клиент. Приложение подключается к Matrix-серверу bolgarlar.ru и отображает данные, которые этот сервер возвращает.',
                style: TextStyle(height: 1.35),
              ),
              const SizedBox(height: 16),

              const Text(
                'Какие данные обрабатывает приложение',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                '• Matrix-ID пользователя, сервер bolgarlar.ru, настройки приложения.\n'
                    '• Технические данные для работы сессии (например, токены/ключи, состояние синхронизации).\n'
                    '• Кэш данных, полученных от Matrix-сервера (для ускорения работы).\n'
                    '• При включённых уведомлениях — данные, необходимые для доставки push-уведомлений.',
                style: TextStyle(height: 1.35),
              ),
              const SizedBox(height: 16),

              const Text(
                'Шифрование',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                'Matrix поддерживает сквозное шифрование (E2EE) в поддерживаемых чатах. '
                    'При E2EE содержимое сообщений шифруется на устройствах участников и не должно быть доступно серверу в открытом виде.',
                style: TextStyle(height: 1.35),
              ),
              const SizedBox(height: 16),

              const Text(
                'Push-уведомления (Android)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                'Для доставки push-уведомлений на Android может использоваться Firebase Cloud Messaging (FCM). '
                    'Типичный подход для Matrix-push: уведомление может содержать технические данные (идентификаторы и счётчики), '
                    'но не обязано содержать текст сообщений.',
                style: TextStyle(height: 1.35),
              ),
              const SizedBox(height: 16),

              const Text(
                'Полный текст политики',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              SelectableLinkify(
                text:
                'Полная политика конфиденциальности опубликована в репозитории:\n$_privacyFullTextUrl',
                onOpen: (link) => launchUrlString(link.url),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
