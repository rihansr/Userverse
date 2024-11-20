import 'package:core/router/routes.dart';
import 'package:core/service/navigation_service.dart';
import 'package:core/utils/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/widgets.dart';
import 'package:core/styles/styles.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings/data/models/language_model.dart';
import 'package:settings/settings.dart';
import 'package:shared/data/data_sources/local/shared_prefs.dart';
import 'package:shared/di/service_locator.dart';

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
      children: LanguageModel.values
          .map(
            (language) => RadioListTile<LanguageModel>(
              key: ValueKey(language.name),
              title: Text(
                language.displayName,
                style: theme.textTheme.titleSmall,
              ),
              value: language,
              groupValue: sl<Settings>().language,
              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              activeColor: theme.colorScheme.primary,
              onChanged: (_) => sl<Settings>().language = language,
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
              groupValue: sl<Settings>().theme,
              contentPadding: const EdgeInsets.symmetric(horizontal: 4),
              activeColor: theme.colorScheme.primary,
              onChanged: (_) => sl<Settings>().theme = mode,
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
                  sl<SharedPrefs>().token = null;
                  Navigator.pop(context);
                  context.router.pushReplacementNamed(Routes.login);
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
