part of 'settings.dart';

@Singleton()
class Settings {
  ValueNotifier<SettingsModel> settings = ValueNotifier((() {
    final settings = sl<SharedPrefs>().settings;
    return settings == null
        ? const SettingsModel()
        : SettingsModel.fromJson(settings);
  }()));

  set _settings(SettingsModel settings) {
    this.settings.value = settings;
    sl<SharedPrefs>().settings = settings.toJson();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    this.settings.notifyListeners();
  }

  // Theme
  set theme(ThemeMode mode) =>
      _settings = settings.value.copyWith(themeMode: mode);

  ThemeMode get theme => settings.value.themeMode;

  // Locale
  set language(LanguageModel language) =>
      _settings = settings.value.copyWith(language: language);

  LanguageModel get language => settings.value.language;
}
