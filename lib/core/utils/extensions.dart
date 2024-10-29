final extension = _Extension.function;

class _Extension {
  static _Extension get function => _Extension._();
  _Extension._();
}

extension StringExtension on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
  String get first => isEmpty ? '' : this[0];
}