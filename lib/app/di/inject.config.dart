// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:authentication/authentication.module.dart' as _i839;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:settings/settings.module.dart' as _i82;
import 'package:shared/shared.module.dart' as _i17;
import 'package:user/user.module.dart' as _i325;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    await _i17.SharedPackageModule().init(gh);
    await _i839.AuthenticationPackageModule().init(gh);
    await _i325.UserPackageModule().init(gh);
    await _i82.SettingsPackageModule().init(gh);
    return this;
  }
}