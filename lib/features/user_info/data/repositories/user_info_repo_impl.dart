import 'package:dartz/dartz.dart';
import 'package:tim_phong_tro/features/user_info/data/models/user_info_model.dart';
import 'package:tim_phong_tro/features/user_info/domain/entities/user_info.dart';
import 'package:tim_phong_tro/features/user_info/domain/repositories/user_info_repo.dart';
import 'package:tim_phong_tro/models/my_shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/user_info_local_datasource.dart';
import '../datasources/user_info_remote_datasource.dart';

class UserInfoRepositoryImplementation implements UserInfoRepository {
  final UserInfoRemoteDataSource remoteDataSource;
  final UserInfoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserInfoRepositoryImplementation(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, AppUserInfo>> getUserInfo(
      {required String uid}) async {
    if (await MysharedPreferences.instance.getBooleanValue('userInfoSaved') ==
            true &&
        await MysharedPreferences.instance.getStringValue('uid') == uid) {
      final info = await localDataSource.getCurrentUserInfo();
      return Right(info);
    } else if (await networkInfo.isConneted) {
      try {
        final info = await remoteDataSource.getUserInfo(
            uid: await MysharedPreferences.instance.getStringValue('uid'));
        await localDataSource.cacheInfo(info);
        return Right(info);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CachedFailure());
    }
  }

  @override
  Future<Either<Failure, AppUserInfo>> setUserInfo(
      {required AppUserInfo info}) async {
    if (await networkInfo.isConneted) {
      try {
        AppUserInfoModel infoModel = new AppUserInfoModel(
            firstName: info.firstName,
            lastName: info.lastName,
            phoneNumber: info.phoneNumber,
            image: info.image,
            description: info.description);
        await remoteDataSource.setUserInfo(info: infoModel);
        await localDataSource.cacheInfo(infoModel);
        return Right(info);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
