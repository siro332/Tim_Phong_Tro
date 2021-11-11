import 'package:tim_phong_tro/features/user_info/domain/entities/user_info.dart';

class UserInfoArguments {
  final String uid;
  final AppUserInfo userInfo;

  UserInfoArguments(this.uid, this.userInfo);
}
