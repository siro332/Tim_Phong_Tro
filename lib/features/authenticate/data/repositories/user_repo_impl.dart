import 'package:dartz/dartz.dart';
import 'package:tim_phong_tro/features/authenticate/data/models/user_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repo.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';

class UserRepositoryImplementation implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImplementation(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  Future<Either<Failure, AppUser>> _getUser(
      Future<AppUserModel> Function() getUser) async {
    if (await networkInfo.isConneted) {
      try {
        final user = await getUser();
        localDataSource.cacheUser(user);
        return Right(user);
      } on AuthException catch (e) {
        return Left(AuthFailure(message: e.message));
      }
    } else {
      return Left((CachedFailure()));
    }
  }

  @override
  Either<Failure, AppUser> getCurrentUser() {
    try {
      final user = remoteDataSource.getCurrentUser();
      //localDataSource.cacheUser(user);
      return Right(user);
    } on AuthException {
      return Left(AuthFailure(message: ""));
    }
  }

  @override
  Future<Either<Failure, String>> getUserToken() async {
    return Right(await remoteDataSource.getCurrentUserToken());
  }

  @override
  Future<Either<Failure, AppUser>> register(
      {required String email, required String password}) async {
    return await _getUser(() {
      return remoteDataSource.register(email: email, password: password);
    });
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    if (await networkInfo.isConneted) {
      try {
        final result = await remoteDataSource.resetPassword(email: email);
        return Right(result);
      } on AuthException catch (e) {
        return Left(AuthFailure(message: e.message));
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AppUser>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return await _getUser(() {
      return remoteDataSource.signInWithEmailAndPassword(
          email: email, password: password);
    });
  }

  @override
  Future<Either<Failure, AppUser>> signInWithFacebook() async {
    return await _getUser(() {
      return remoteDataSource.signInWithFacebook();
    });
  }

  @override
  Future<Either<Failure, AppUser>> signInWithGoogle() async {
    return await _getUser(() {
      return remoteDataSource.signInWithGoogle();
    });
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    return Right(await remoteDataSource.signOut());
  }
}
