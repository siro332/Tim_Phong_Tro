import 'package:equatable/equatable.dart';
import 'package:tim_phong_tro/features/user_info/domain/entities/user_info.dart';

class UserDetail extends Equatable {
  final String uid;
  final String email;
  final AppUserInfo info;
  UserDetail({required this.email, required this.info, required this.uid});

  @override
  List<Object> get props => [uid];
}
