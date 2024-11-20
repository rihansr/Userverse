import 'dart:convert';
import 'package:flutter/material.dart';
import 'language_model.dart';

class SettingsModel {
  final ThemeMode themeMode;
  final LanguageModel language;

  const SettingsModel({
    this.themeMode = ThemeMode.system,
    this.language = LanguageModel.english,
  });

  SettingsModel copyWith({
    ThemeMode? themeMode,
    LanguageModel? language,
  }) {
    return SettingsModel(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
    );
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) => SettingsModel(
        themeMode: ThemeMode.values.byName(map["theme_mode"]),
        language: LanguageModel.values.byName(map["language"]),
      );

  Map<String, dynamic> toMap() => {
        "theme_mode": themeMode.name,
        "language": language.name,
      };

  String toJson() => jsonEncode(toMap());

  factory SettingsModel.fromJson(String source) =>
      SettingsModel.fromMap(jsonDecode(source));
}
