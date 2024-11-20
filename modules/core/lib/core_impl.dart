part of 'core.dart';

class _CoreImpl implements Core {
  _CoreImpl();

  @override
  void init() {
     appConfig.init();
  }
}
