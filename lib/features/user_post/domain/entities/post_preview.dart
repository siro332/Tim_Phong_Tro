import 'package:equatable/equatable.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/room_info_preview.dart';

class UserPostPreview extends Equatable {
  final int id;
  final String name;
  final String phoneNumber;
  final DateTime postingDate;
  final String thumbnailImage;
  final RoomInfoPreview roomInfo;
  final String description;
  final bool isVerifired;
  UserPostPreview(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.thumbnailImage,
      required this.roomInfo,
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
        description,
        isVerifired,
        postingDate
      ];
}
