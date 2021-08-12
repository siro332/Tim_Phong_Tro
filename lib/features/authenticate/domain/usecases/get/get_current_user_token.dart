import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/user_repo.dart';

class GetCurrentUser implements UseCase<String, NoParams> {
  final UserRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.getUserToken();
  }
}
