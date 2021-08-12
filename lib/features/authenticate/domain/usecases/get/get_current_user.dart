import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/user_repo.dart';

class GetCurrentUser implements UseCase<AppUser, NoParams> {
  final UserRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future<Either<Failure, AppUser>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
