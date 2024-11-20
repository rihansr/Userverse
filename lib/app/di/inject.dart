import 'package:authentication/authentication.module.dart';
import 'package:injectable/injectable.dart';
import 'package:settings/settings.module.dart';
import 'package:shared/di/service_locator.dart';
import 'package:shared/shared.module.dart';
import 'package:user/user.module.dart';
import 'inject.config.dart';

@InjectableInit(
  initializerName: 'init',
  throwOnMissingDependencies: true,
  externalPackageModulesBefore: [
    ExternalModule(SharedPackageModule),
    ExternalModule(AuthenticationPackageModule),
    ExternalModule(UserPackageModule),
    ExternalModule(SettingsPackageModule)
  ],
)
Future<void> configureDependencies() async => sl.init();