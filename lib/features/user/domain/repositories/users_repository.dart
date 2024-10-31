import 'package:dartz/dartz.dart';
import '../../../../core/network/error/failures.dart';
import '../models/user_model.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<UserModel>>> users();
}
