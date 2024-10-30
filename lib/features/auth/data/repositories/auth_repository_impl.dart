import 'package:dartz/dartz.dart';
import '../../../../core/network/error/exceptions.dart';
import '../../../../core/network/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/remote/auth_impl_api.dart';

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