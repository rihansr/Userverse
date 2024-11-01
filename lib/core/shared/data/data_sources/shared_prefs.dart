import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/settings_model.dart';

class SharedPrefs {
  final SharedPreferences _sharedPrefs;

  SharedPrefs(this._sharedPrefs);

  static const String _settingsKey = "settings_sp_key";
  static const String _authTokenKey = "auth_token_sp_key";

  // Settings
  set settings(Settings settings) =>
      _sharedPrefs.setString(_settingsKey, settings.toJson());

  Settings get settings {
    final settings = _sharedPrefs.getString(_settingsKey);
    return settings == null ? const Settings() : Settings.fromJson(settings);
  }

  // Auth
  bool get isLoggedIn => token != null;

  set token(String? token) => token == null
      ? _sharedPrefs.remove(_authTokenKey)
      : _sharedPrefs.setString(_authTokenKey, token);

  String? get token => _sharedPrefs.getString(_authTokenKey);
}
