library shared;

import 'package:injectable/injectable.dart';

@InjectableInit.microPackage(
  preferRelativeImports: true,
  usesNullSafety: true,
  throwOnMissingDependencies: true,
)
void shared() {}
