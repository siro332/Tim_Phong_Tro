import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tim_phong_tro/core/error/failure.dart';
import 'package:tim_phong_tro/features/user_info/domain/entities/user_info.dart';
import 'package:tim_phong_tro/features/user_info/domain/usecases/get_user_info.dart';
import 'package:tim_phong_tro/features/user_info/domain/usecases/set_user_info.dart';

import '../../../../constants.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final GetUserInfo getUserInfo;
  final SetUserInfo setUserInfo;

  UserInfoBloc({
    required this.getUserInfo,
    required this.setUserInfo,
  }) : super(NoData());
  @override
  Stream<UserInfoState> mapEventToState(
    UserInfoEvent event,
  ) async* {
    if (event is GetUserInfoEvent) {
      yield Loading();
      final getData = await getUserInfo(new GetUserInfoParams(uid: event.uid));
      yield getData.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (info) => HaveData(info: info));
    } else if (event is SetUserInfoEvent) {
      yield Loading();
      final setData =
          await setUserInfo(new SetUserInfoParams(info: event.userInfo));
      yield setData.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (info) => HaveData(info: info));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return kNetworkError;
      case AuthFailure:
        AuthFailure authFailure = failure as AuthFailure;
        return authFailure.message;
      default:
        return "Unexpected Error";
    }
  }
}
