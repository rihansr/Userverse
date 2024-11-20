import 'package:flutter/foundation.dart';

enum _AppMode { debug, production }

final appConfig = _AppConfig.value;

class _AppConfig {
  static _AppConfig get value => _AppConfig._();
  _AppConfig._();

  final appMode = kDebugMode ? _AppMode.debug : _AppMode.production;
  late Map<String, dynamic> config;

  init() {
    config = _configs[appMode.name] ?? {};
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
