import 'package:equatable/equatable.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/room_info.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/user_detail.dart';

class UserPost extends Equatable {
  final int id;
  final String name;
  final String phoneNumber;
  final DateTime postingDate;
  final String thumbnailImage;
  final RoomInfo roomInfo;
  final UserDetail user;
  final String description;
  final bool isVerifired;
  UserPost(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.thumbnailImage,
      required this.roomInfo,
      required this.user,
      required this.description,
      required this.isVerifired,
      required this.postingDate});
  @override
  List<Object?> get props => [
        id,
        name,
        phoneNumber,
        thumbnailImage,
        roomInfo,
        user,
        description,
        isVerifired,
        postingDate
      ];
}
