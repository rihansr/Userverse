import 'package:core/utils/utils.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../models/user_model.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<UserModel>>> users();
  Future<Either<Failure, UserModel>> singleUser(int id);
}
