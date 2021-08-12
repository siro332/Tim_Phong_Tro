import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../entities/user.dart';
import '../../repositories/user_repo.dart';

class Register implements UseCase<AppUser, Params> {
  final UserRepository repository;

  Register(this.repository);

  @override
  Future<Either<Failure, AppUser>> call(Params params) async {
    return await repository.register(
        email: params.email, password: params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;
  Params({required this.email, required this.password});

  @override
  List<Object?> get props => [this.email, this.password];
}
