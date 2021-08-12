part of 'user_info_bloc.dart';

abstract class UserInfoEvent extends Equatable {
  const UserInfoEvent();

  @override
  List<Object> get props => [];
}

class GetUserInfoEvent extends UserInfoEvent {
  final String uid;
  GetUserInfoEvent({required this.uid});
}

class SetUserInfoEvent extends UserInfoEvent {
  final AppUserInfo userInfo;
  SetUserInfoEvent({required this.userInfo});
}
