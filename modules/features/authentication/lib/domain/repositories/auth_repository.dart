
import 'package:core/utils/utils.dart';
import 'package:shared/data/data_sources/remote/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, String?>> login(Map<String, dynamic> body);
}