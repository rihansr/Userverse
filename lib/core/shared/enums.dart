import 'dart:ui';

enum AlertType { success, error, info }

enum Language {
  english,
  spanish;

  String get displayName {
    switch (this) {
      case Language.spanish:
        return 'Español';
      default:
        return 'English';
    }
  }

  Locale get locale {
    switch (this) {
      case Language.spanish:
        return const Locale('es', 'ES');
      default:
        return const Locale('en', 'US');
    }
  }
}
