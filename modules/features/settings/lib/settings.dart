library settings;

import 'package:flutter/material.dart' show ThemeMode, ValueNotifier;
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/local/shared_prefs.dart';
import 'package:shared/di/service_locator.dart';
import 'data/models/language_model.dart';
import 'data/models/settings_model.dart';
part 'settings_impl.dart';

@InjectableInit.microPackage(
  preferRelativeImports: true,
  throwOnMissingDependencies: false,
)
void settings() {}
