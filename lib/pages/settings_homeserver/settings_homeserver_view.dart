import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:fluffychat/l10n/l10n.dart';
import '../../widgets/matrix.dart';
import 'settings_homeserver.dart';

class SettingsHomeserverView extends StatelessWidget {
  final SettingsHomeserverController controller;

  const SettingsHomeserverView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final client = Matrix.of(context).client;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          L10n.of(context).aboutHomeserver(client.userID?.domain ?? 'bolgarlar.ru'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'О нашем сервере',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          const Text(
            'Наш сервер bolgarlar.ru расположен в Москве. Он был создан и поддерживается магистрантом Болгарской исламской академии (БИА) специально для обеспечения безопасного и удобного общения мусульман и всех желающих.',
            style: TextStyle(fontSize: 16, height: 1.6),
          ),
          const SizedBox(height: 16),
          const Text(
            'Мы стремимся создать чистое цифровое пространство для обмена знаниями, поддержки добрых инициатив и простого человеческого общения в рамках нашей уммы.',
            style: TextStyle(fontSize: 16, height: 1.6),
          ),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),
          Text(
            'Техническая информация',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 8),
          Text('Домен: ${client.userID?.domain}', style: const TextStyle(fontSize: 14)),
          Text('Адрес сервера: ${client.homeserver}', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
