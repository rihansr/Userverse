library user;

import 'package:injectable/injectable.dart';
export '../presentation/screens/user_details_screen.dart';
export '../domain/usecases/users_usecase.dart';
export '../domain/models/user_model.dart';

@InjectableInit.microPackage(
  preferRelativeImports: true,
  throwOnMissingDependencies: false,
)
void user() {}
