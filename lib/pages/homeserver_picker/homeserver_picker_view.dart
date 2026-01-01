import 'package:flutter/material.dart';

import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:fluffychat/l10n/l10n.dart';
import 'package:fluffychat/widgets/layouts/login_scaffold.dart';
import 'package:fluffychat/widgets/matrix.dart';

import 'homeserver_picker.dart';
import 'roadmap_view.dart';
import 'support_project_view.dart';
import 'privacy_view.dart';


class HomeserverPickerView extends StatelessWidget {
  final HomeserverPickerController controller;

  const HomeserverPickerView(this.controller, {super.key});

  static const String _roadmapMenuValue = 'roadmap';
  static const String _supportMenuValue = 'support_project';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LoginScaffold(
      enforceMobileMode: Matrix.of(context)
          .widget
          .clients
          .any((client) => client.isLogged()),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          controller.widget.addMultiAccount
              ? L10n.of(context).addAccount
              : L10n.of(context).login,
        ),
        actions: [
          PopupMenuButton<Object>(
            useRootNavigator: true,
            onSelected: (value) {
              if (value == _roadmapMenuValue) {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (_) => const RoadmapView(),
                  ),
                );
                return;
              }

              if (value == _supportMenuValue) {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (_) => const SupportProjectView(),
                  ),
                );
                return;
              }

              if (value == MoreLoginActions.privacy) {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(builder: (_) => const PrivacyView()),
                );
                return;
              }


              if (value is MoreLoginActions) {
                controller.onMoreAction(value);
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem<Object>(
                value: _roadmapMenuValue,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.map_outlined),
                    SizedBox(width: 12),
                    Text('Карта развития приложения'),
                  ],
                ),
              ),
              const PopupMenuItem<Object>(
                value: _supportMenuValue,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.volunteer_activism_outlined),
                    SizedBox(width: 12),
                    Text('Поддержите проект'),
                  ],
                ),
              ),
              PopupMenuItem<Object>(
                value: MoreLoginActions.privacy,
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    const Icon(Icons.privacy_tip_outlined),
                    const SizedBox(width: 12),
                    Text(L10n.of(context).privacy),
                  ],
                ),
              ),
              PopupMenuItem<Object>(
                value: MoreLoginActions.about,
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    const Icon(Icons.info_outlined),
                    const SizedBox(width: 12),
                    Text(L10n.of(context).about),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Hero(
                        tag: 'info-logo',
                        child: Image.asset(
                          './assets/banner_transparent.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: SelectableLinkify(
                        text: L10n.of(context).appIntroduction,
                        textScaleFactor:
                        MediaQuery.textScalerOf(context).scale(1),
                        textAlign: TextAlign.center,
                        linkStyle: TextStyle(
                          color: theme.colorScheme.secondary,
                          decorationColor: theme.colorScheme.secondary,
                        ),
                        onOpen: (link) => launchUrlString(link.url),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisSize: .min,
                        crossAxisAlignment: .stretch,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                            ),
                            onPressed: controller.isLoading
                                ? null
                                : controller.checkHomeserverAction,
                            child: controller.isLoading
                                ? const LinearProgressIndicator()
                                : Text(L10n.of(context).continueText),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
