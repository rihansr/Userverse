import 'package:dartz/dartz.dart';
import '../../../../core/network/error/failures.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase{
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, String?>> invoke(Map<String, dynamic> body) async {
    final result = await repository.login(body);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}