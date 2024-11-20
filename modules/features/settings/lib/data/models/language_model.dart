import 'dart:ui';

enum LanguageModel {
  english,
  spanish;

  String get displayName {
    switch (this) {
      case LanguageModel.spanish:
        return 'Español';
      default:
        return 'English';
    }
  }

  Locale get locale {
    switch (this) {
      case LanguageModel.spanish:
        return const Locale('es', 'ES');
      default:
        return const Locale('en', 'US');
    }
  }
}
