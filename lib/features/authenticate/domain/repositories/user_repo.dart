import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, AppUser>> getCurrentUser();
  Future<Either<Failure, AppUser>> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<Either<Failure, AppUser>> signInWithGoogle();
  Future<Either<Failure, AppUser>> signInWithFacebook();
  Future<Either<Failure, AppUser>> register(
      {required String email, required String password});

  Future<Either<Failure, String>> getUserToken();

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, void>> resetPassword({required String email});
}
