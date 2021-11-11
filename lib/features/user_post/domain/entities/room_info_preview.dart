import 'package:equatable/equatable.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/room_type.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/room_utility.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/street_address.dart';

class RoomInfoPreview extends Equatable {
  final double area;
  final int gender;
  final String name;
  final int rentalPrice;
  final StreetAddress address;
  final RoomType roomType;
  final List<RoomUtilily> roomUtils;
  RoomInfoPreview(
      {required this.area,
      required this.gender,
      required this.name,
      required this.rentalPrice,
      required this.address,
      required this.roomType,
      required this.roomUtils});
  @override
  List<Object?> get props =>
      [area, gender, name, rentalPrice, address, roomType, roomUtils];
}
