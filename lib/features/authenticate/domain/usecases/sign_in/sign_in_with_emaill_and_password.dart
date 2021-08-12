import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/user_repo.dart';

class SignInWithEmailAndPassword
    implements UseCase<AppUser, EmailPasswordParams> {
  final UserRepository repository;

  SignInWithEmailAndPassword(this.repository);

  @override
  Future<Either<Failure, AppUser>> call(EmailPasswordParams params) async {
    return await repository.signInWithEmailAndPassword(
        email: params.email, password: params.password);
  }
}

class EmailPasswordParams extends Equatable {
  final String email;
  final String password;
  EmailPasswordParams({required this.email, required this.password});

  @override
  List<Object?> get props => [this.email, this.password];
}
