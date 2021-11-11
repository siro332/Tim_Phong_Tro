import 'package:equatable/equatable.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/room_type.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/room_utility.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/street_address.dart';

class RoomInfo extends Equatable {
  final int id;
  final double area;
  final int capacity;
  final int deposit;
  final int electricityCost;
  final int gender;
  final List<String> image;
  final int internetCost;
  final String name;
  final int otherExpensive;
  final int parkingCost;
  final int rentalPrice;
  final int waterCost;
  final StreetAddress address;
  final RoomType roomType;
  final List<RoomUtilily> roomUtils;
  RoomInfo(
      {required this.id,
      required this.area,
      required this.capacity,
      required this.deposit,
      required this.electricityCost,
      required this.gender,
      required this.image,
      required this.internetCost,
      required this.name,
      required this.otherExpensive,
      required this.parkingCost,
      required this.rentalPrice,
      required this.waterCost,
      required this.address,
      required this.roomType,
      required this.roomUtils});
  @override
  List<Object?> get props => [
        id,
        area,
        capacity,
        deposit,
        electricityCost,
        gender,
        image,
        internetCost,
        name,
        otherExpensive,
        parkingCost,
        rentalPrice,
        waterCost,
        address,
        roomType,
        roomUtils
      ];
}
