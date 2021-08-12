import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/user_repo.dart';

class ResetPassword implements UseCase<void, ResetPassParams> {
  final UserRepository repository;

  ResetPassword(this.repository);

  @override
  Future<Either<Failure, void>> call(ResetPassParams params) async {
    return await repository.resetPassword(email: params.email);
  }
}

class ResetPassParams {
  final String email;
  ResetPassParams({required this.email});
}
