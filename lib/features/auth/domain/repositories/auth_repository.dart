import 'package:dartz/dartz.dart';
import '../../../../core/network/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, String?>> login(Map<String, dynamic> body);
}