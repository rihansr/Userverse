import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/network.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/remote/auth_impl_api.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthImplApi authApi;

  AuthRepositoryImpl(
    this.authApi,
  );

  @override
  Future<Either<Failure, String?>> login(Map<String, dynamic> body) async {
    try {
      final result = await authApi.login(body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on CancelTokenException catch (e) {
      return Left(CancelTokenFailure(e.message, e.statusCode));
    }
  }
}