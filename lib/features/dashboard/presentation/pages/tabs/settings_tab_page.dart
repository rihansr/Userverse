import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/config/app_settings.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/service/navigation_service.dart';
import '../../../../../core/shared/data/data_sources/local_storage.dart';
import '../../../../../core/shared/domain/entities/enums.dart';
import '../../../../../core/shared/presentation/widgets/button_widget.dart';
import '../../../../../core/shared/presentation/widgets/modal_bottomsheet_widget.dart';
import '../../../../../core/styles/strings.dart';
import '../../../../../core/styles/styles.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/injections.dart';

class SettingsTabPage extends StatelessWidget {
  const SettingsTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: const [
        _LanguageSection(
          key: ValueKey('language_section'),
        ),
        _ThemeSection(
          key: ValueKey('theme_section'),
        ),
        _LogoutSection(
          key: ValueKey('logout_section'),
        ),
      ],
    );
  }
}

class _LanguageSection extends StatelessWidget {
  const _LanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoFormSection.insetGrouped(
      backgroundColor: Colors.transparent,
      decoration: style.defaultDecoration(context),
      header: Text(string.of(context).language),
      children: Language.values
          .map(
            (language) => RadioListTile(
              key: ValueKey(language.name),
              title: Text(
                language.displayName,
                style: theme.textTheme.titleSmall,
              ),
              value: language,
              groupValue: appSettings.language,
              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              activeColor: theme.colorScheme.primary,
              onChanged: (_) => appSettings.language = language,
            ),
          )
          .toList(),
    );
  }
}

class _ThemeSection extends StatelessWidget {
  const _ThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoFormSection.insetGrouped(
      backgroundColor: Colors.transparent,
      header: Text(string.of(context).thememode),
      decoration: style.defaultDecoration(context),
      children: ThemeMode.values
          .map(
            (mode) => RadioListTile(
              key: ValueKey(mode.name),
              title: Text(
                mode.name.capitalize,
                style: theme.textTheme.titleSmall,
              ),
              value: mode,
              groupValue: appSettings.theme,
              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              activeColor: theme.colorScheme.primary,
              onChanged: (_) => appSettings.theme = mode,
            ),
          )
          .toList(),
    );
  }
}

class _LogoutSection extends StatelessWidget {
  const _LogoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: TextButton(
        onPressed: logout,
        child: Text(
          string.of(context).logout,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.tertiary,
          ),
        ),
      ),
    );
  }

  logout() => ModalBottomSheet.show(
        navigator.context,
        (context) => ModalBottomSheet(
          title: Text(
            string.of(context).logout,
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            string.of(context).wantToLogout,
            textAlign: TextAlign.center,
          ),
          actions: [
            Button(
              label: string.of(context).logout,
              margin: const EdgeInsets.all(0),
              background: Theme.of(context).colorScheme.tertiary,
              onPressed: () {
                {
                  sl<LocalStorage>().token = null;
                  Navigator.pop(context);
                  context.pushReplacementNamed(Routes.login);
                }
              },
            ),
            Button(
              label: string.of(context).cancel,
              background: Colors.transparent,
              fontColor: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
}
