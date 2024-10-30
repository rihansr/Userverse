import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/injections.dart';

enum _AppMode { debug, production }

final appConfig = _AppConfig.value;

class _AppConfig {
  static _AppConfig get value => _AppConfig._();
  _AppConfig._();

  final appMode = kDebugMode ? _AppMode.debug : _AppMode.production;
  late Map<String, dynamic> config;

  init() async {
    WidgetsFlutterBinding.ensureInitialized();

    config = _configs[appMode.name] ?? {};

    await Future.wait([
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]),
      initInjections(),
    ]);
  }

  final _configs = {
    "debug": {
      "base_url": {
        "auth": "https://reqres.in",
        "content": "https://jsonplaceholder.typicode.com",
      },
    },
    "production": {
      "base_url": {
        "auth": "https://reqres.in",
        "content": "https://jsonplaceholder.typicode.com",
      },
    }
  };
}
