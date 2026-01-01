import 'package:flutter/material.dart';

import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:fluffychat/l10n/l10n.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  static const String _repoUrl = 'https://github.com/Arslan-kzn/bolgar-messenger';
  static const String _licenseUrl =
      'https://github.com/Arslan-kzn/bolgar-messenger/blob/main/LICENSE';

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.about),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'BOLGAR Messenger',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                'BOLGAR Messenger — Matrix-клиент для татарской и мусульманской общины. '
                    'Приложение предназначено для общения в комнатах и личных сообщениях на базе протокола Matrix.',
                style: TextStyle(height: 1.35),
              ),
              const SizedBox(height: 16),

              const Text(
                'Открытый исходный код',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              SelectableLinkify(
                text: 'Репозиторий проекта:\n$_repoUrl',
                onOpen: (link) => launchUrlString(link.url),
              ),
              const SizedBox(height: 16),

              const Text(
                'Лицензия',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                'Проект распространяется на условиях лицензии AGPL-3.0. '
                    'Если вы модифицируете приложение и предоставляете его пользователям по сети, '
                    'вы обязаны предоставить им исходный код этих модификаций согласно условиям лицензии.',
                style: TextStyle(height: 1.35),
              ),
              const SizedBox(height: 8),
              SelectableLinkify(
                text: 'Текст лицензии:\n$_licenseUrl',
                onOpen: (link) => launchUrlString(link.url),
              ),
              const SizedBox(height: 16),

              const Text(
                'Основано на',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                'Проект основан на open-source Matrix-клиенте FluffyChat и адаптирован под бренд BOLGAR.',
                style: TextStyle(height: 1.35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
