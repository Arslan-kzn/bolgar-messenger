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
          // Блок MVP и Бета-тестирования
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.rocket_launch_outlined, color: Colors.amber[800]),
                    const SizedBox(width: 8),
                    Text(
                      'Стадия MVP и бета-тестирование',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[900],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Это самая первая, ранняя версия нашего приложения. Мы используем подход MVP (Minimum Viable Product) — это создание минимально жизнеспособного продукта, который содержит только самые важные функции для связи. '
                  'Сейчас идет этап активного бета-тестирования. Это означает, что приложение находится в процессе доработки, поэтому в нем могут встречаться технические недочеты и ошибки. Мы искренне благодарим вас за терпение и помощь в поиске этих изъянов — вместе мы сделаем BOLGAR лучше.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          const Text(
            'bolgarlar.ru — наш общий дом в цифровом мире',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          const Text(
            'bolgarlar.ru — это наш собственный Matrix-сервер. Он надежно хранит учётные записи, обеспечивает быструю доставку сообщений и стабильную работу чатов, групп и комнат. BOLGAR Messenger — это ключ, через который вы подключаетесь к этому пространству.',
            style: TextStyle(fontSize: 16, height: 1.6),
          ),
          const SizedBox(height: 24),
          
          _buildHeader('Родной сервер — в родной стране'),
          const Text(
            'Сервер размещён в одном из лучших дата-центров Москвы. Это наш осознанный выбор ради стабильности, предсказуемой доступности и максимально комфортной связи для братьев и сестер из России и ближайших регионов.',
            style: TextStyle(fontSize: 16, height: 1.6),
          ),
          const SizedBox(height: 24),

          _buildHeader('Инициатива и созидание'),
          const Text(
            'Инфраструктура bolgarlar.ru поднята и администрируется магистрантом Болгарской Исламской Академии (БИА) как общественная инициатива. Наша цель проста: дать людям относительно безопасное, достойное и технологически современное пространство для переписки, важных объявлений и совместных добрых дел.',
            style: TextStyle(fontSize: 16, height: 1.6),
          ),
          const SizedBox(height: 24),

          _buildHeader('Наши ценности и приоритеты'),
          _buildBullet('надёжная коммуникация общины (личные и групповые чаты)'),
          _buildBullet('сохранение уважительного тона и культуры общения (адаб)'),
          _buildBullet('поддержка татарского языка и культурной идентичности'),
          _buildBullet('независимость от внешних платформ и чужих правил'),
          const SizedBox(height: 24),

          _buildHeader('Честность и приватность'),
          const Text(
            'Мы строим это пространство на фундаменте доверия. В отличие от других мессенджеров, BOLGAR Messenger:',
            style: TextStyle(fontSize: 16, height: 1.6),
          ),
          const SizedBox(height: 8),
          _buildBullet('Не требует номер телефона или e-mail для регистрации — ваша личность защищена от лишнего сбора данных.'),
          _buildBullet('Не запрашивает скрытых разрешений — доступ к камере или микрофону нужен только тогда, когда вы сами совершаете звонок или отправляете фото.'),
          _buildBullet('Не содержит рекламы и систем слежки — мы не продаем ваши предпочтения и не анализируем ваш профиль.'),
          const Text(
            'Для нас ваш аккаунт — это аманат. Мы используем только то, что необходимо для работы системы.',
            style: TextStyle(fontSize: 16, height: 1.6),
          ),
          const SizedBox(height: 24),

          _buildHeader('Безопасность и Аманат'),
          const Text(
            'Matrix поддерживает сквозное шифрование (E2EE). В зашифрованных чатах содержание ваших сообщений недоступно даже серверу — это ваш аманат. Дополнительно всё соединение защищено современным транспортным шифрованием (TLS).',
            style: TextStyle(fontSize: 16, height: 1.6),
          ),
          
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),
          Text(
            'ТЕХНИЧЕСКАЯ ИНФОРМАЦИЯ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary.withOpacity(0.7),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text('Домен: ${client.userID?.domain}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Text('Адрес сервера: ${client.homeserver}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const Text(
            'Версия приложения: 0.0.1',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
