import 'package:dartz/dartz.dart';
import '../../../../core/network/error/failures.dart';
import '../models/user_model.dart';
import '../repositories/users_repository.dart';

class SingleUserUseCase {
  final UsersRepository repository;

  SingleUserUseCase(this.repository);

  Future<Either<Failure, UserModel>> invoke(int id) async {
    final result = await repository.singleUser(id);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
