import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/network.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/users_repository.dart';
import '../data_sources/remote/users_impl_api.dart';

@LazySingleton(as: UsersRepository)
class UsersRepositoryImpl extends UsersRepository {
  final UsersImplApi usersApi;

  UsersRepositoryImpl(
    this.usersApi,
  );

  @override
  Future<Either<Failure, List<UserModel>>> users() async {
    try {
      final result = await usersApi.users();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, UserModel>> singleUser(int id) async {
    try {
      final result = await usersApi.singleUser(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}
