final serverEnv = _ServerEnv.value;

class _ServerEnv {
  static _ServerEnv get value => _ServerEnv._();
  _ServerEnv._();

  // Auth endpoints
  final login = "api/login";

  // User Endpoints
  final users = "users";
}