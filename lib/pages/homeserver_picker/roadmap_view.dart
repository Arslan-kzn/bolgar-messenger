import 'package:flutter/material.dart';

class RoadmapView extends StatelessWidget {
  const RoadmapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карта развития приложения'),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: _RoadmapContent(),
        ),
      ),
    );
  }
}

class _RoadmapContent extends StatelessWidget {
  const _RoadmapContent();

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
    const sectionStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    const bodyStyle = TextStyle(fontSize: 14, height: 1.35);

    Widget gap([double h = 12]) => SizedBox(height: h);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('BOLGAR Messenger', style: titleStyle),
        gap(8),
        const Text(
          'Это Matrix-клиент для татарской и мусульманской общины. Ниже — публичная карта развития: что и в каком порядке мы планируем улучшать.',
          style: bodyStyle,
        ),
        gap(16),

        const Text('Ближайшие версии', style: sectionStyle),
        gap(8),
        const Text('• v0.1 (сейчас): брендинг, вход/регистрация, базовые чаты, пуши.', style: bodyStyle),
        const Text('• v0.2: меню онбординга, FAQ/поддержка, улучшение стабильности.', style: bodyStyle),
        const Text('• v0.3: приглашения/контакты, улучшение медиа, модерация/правила.', style: bodyStyle),
        const Text('• v1.0: стабильный релиз, безопасность, документация и качество.', style: bodyStyle),
        gap(16),

        const Text('Принципы развития', style: sectionStyle),
        gap(8),
        const Text('• Приватность и безопасность пользователя.', style: bodyStyle),
        const Text('• Прозрачность: открытый код и понятные правила.', style: bodyStyle),
        const Text('• Простота для новичков (минимум лишних шагов).', style: bodyStyle),
        const Text('• Польза общине: фокус на реальных сценариях общения.', style: bodyStyle),
        gap(16),

        const Text('Как помочь проекту', style: sectionStyle),
        gap(8),
        const Text('• Сообщайте о багах и предлагайте улучшения.', style: bodyStyle),
        const Text('• Участвуйте в тестировании новых версий.', style: bodyStyle),
        const Text('• Поддержите проект финансово (пункт меню появится рядом).', style: bodyStyle),
      ],
    );
  }
}
