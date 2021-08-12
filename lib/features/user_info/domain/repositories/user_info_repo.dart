import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_info.dart';

abstract class UserInfoRepository {
  Future<Either<Failure, AppUserInfo>> getUserInfo({required String uid});

  Future<Either<Failure, AppUserInfo>> setUserInfo({required AppUserInfo info});
}
