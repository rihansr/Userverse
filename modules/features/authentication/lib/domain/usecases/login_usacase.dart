import 'package:core/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
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