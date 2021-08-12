import 'package:dartz/dartz.dart';
import 'package:tim_phong_tro/features/user_info/domain/entities/user_info.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_info_repo.dart';

class SetUserInfo implements UseCase<void, SetUserInfoParams> {
  final UserInfoRepository repository;

  SetUserInfo(this.repository);

  @override
  Future<Either<Failure, AppUserInfo>> call(SetUserInfoParams params) async {
    return await repository.setUserInfo(info: params.info);
  }
}

class SetUserInfoParams {
  AppUserInfo info;
  SetUserInfoParams({required this.info});
}
