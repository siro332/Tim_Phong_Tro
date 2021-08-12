part of 'user_info_bloc.dart';

abstract class UserInfoState extends Equatable {
  const UserInfoState([List props = const <dynamic>[]]);

  @override
  List<Object> get props => props;
}

class NoData extends UserInfoState {}

class Loading extends UserInfoState {}

class HaveData extends UserInfoState {
  final AppUserInfo info;
  HaveData({required this.info}) : super([info]);
}

class Error extends UserInfoState {
  final String message;

  Error({required this.message}) : super([message]);
}
