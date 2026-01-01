import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SupportProjectView extends StatelessWidget {
  const SupportProjectView({super.key});

  static const String supportUrl =
      'https://www.sberbank.ru/ru/choise_bank?requisiteNumber=79179041199&bankCode=100000000111';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поддержите проект'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Если приложение полезно, вы можете поддержать развитие проекта.',
                style: TextStyle(fontSize: 14, height: 1.35),
              ),
              const SizedBox(height: 12),
              const Text(
                'Ссылка откроется во внешнем браузере.',
                style: TextStyle(fontSize: 13, height: 1.35),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final ok = await launchUrlString(
                      supportUrl,
                      mode: LaunchMode.externalApplication,
                    );
                    if (!ok && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Не удалось открыть ссылку.'),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.volunteer_activism_outlined),
                  label: const Text('Перейти к поддержке в Сбербанке'),
                ),
              ),
              const SizedBox(height: 12),
              const SelectableText(
                supportUrl,
                style: TextStyle(fontSize: 12, height: 1.35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
