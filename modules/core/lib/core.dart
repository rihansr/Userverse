export 'exports.dart';
import 'package:core/configs/app_config.dart';
part 'core_impl.dart';

abstract class Core {
  static final Core _instance = _CoreImpl();
  static Core get instance => _instance;

  void init();
}
