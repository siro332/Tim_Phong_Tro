import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/user_repo.dart';

class SignInWithGoogle implements UseCase<AppUser, NoParams> {
  final UserRepository repository;
  SignInWithGoogle(this.repository);

  @override
  Future<Either<Failure, AppUser>> call(NoParams params) {
    return repository.signInWithGoogle();
  }
}
