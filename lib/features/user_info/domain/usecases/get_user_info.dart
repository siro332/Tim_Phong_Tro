import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_info.dart';
import '../repositories/user_info_repo.dart';

class GetUserInfo implements UseCase<AppUserInfo, GetUserInfoParams> {
  final UserInfoRepository repository;

  GetUserInfo(this.repository);

  @override
  Future<Either<Failure, AppUserInfo>> call(GetUserInfoParams params) async {
    return await repository.getUserInfo(uid: params.uid);
  }
}

class GetUserInfoParams {
  String uid;
  GetUserInfoParams({required this.uid});
}
