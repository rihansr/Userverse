import 'package:dartz/dartz.dart';
import '../../../../core/network/error/failures.dart';
import '../../../user/domain/models/user_model.dart';
import '../../../user/domain/repositories/users_repository.dart';

class UsersUseCase {
  final UsersRepository repository;

  UsersUseCase(this.repository);

  Future<Either<Failure, List<UserModel>>> invoke() async {
    final result = await repository.users();
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}
