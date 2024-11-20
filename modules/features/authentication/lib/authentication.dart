library authentication;

import 'package:injectable/injectable.dart';

export '../presentation/screens/login_screen.dart';

@InjectableInit.microPackage(
  preferRelativeImports: true,
  throwOnMissingDependencies: false,
)
void authentication() {}