import '../../../domain/models/user_model.dart';

abstract class UsersApi {
  Future<List<UserModel>> users();
}
