import 'package:flutter/material.dart';

import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:fluffychat/l10n/l10n.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  static const String _privacyFullTextUrl =
      'https://github.com/Arslan-kzn/bolgar-messenger/blob/main/PRIVACY.md';

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
                'BOLGAR Messenger — Matrix-клиент. Сообщения и медиа хранятся на выбранном вами Matrix-сервере (homeserver). '
                    'Владелец сервера и его правила хранения данных определяют, как именно обрабатываются данные на стороне сервера.',
                style: TextStyle(height: 1.35),
              ),
              const SizedBox(height: 16),

              const Text(
                'Что мы обрабатываем в приложении',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                '• Учётная запись Matrix (ID пользователя), выбранный сервер.\n'
                    '• Технические данные для работы приложения (настройки, состояние сессии).\n'
                    '• Уведомления: приложение может получать push-сообщения о новых событиях (без раскрытия содержимого переписки).\n'
                    '• Логи: при отладке могут появляться технические логи на устройстве.',
                style: TextStyle(height: 1.35),
              ),
              const SizedBox(height: 16),

              const Text(
                'Про шифрование',
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
