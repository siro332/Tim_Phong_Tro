import 'package:tim_phong_tro/features/user_post/data/model/adress_model.dart';
import 'package:tim_phong_tro/features/user_post/data/model/room_utility_model.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/room_info_preview.dart';

import 'room_type_model.dart';

class RoomInfoPreviewModel extends RoomInfoPreview {
  RoomInfoPreviewModel(
      {required area,
      required gender,
      required name,
      required rentalPrice,
      required address,
      required roomType,
      required roomUtils})
      : super(
            area: area,
            gender: gender,
            name: name,
            rentalPrice: rentalPrice,
            address: address,
            roomType: roomType,
            roomUtils: roomUtils);

  factory RoomInfoPreviewModel.fromJson(Map<String, dynamic> json) {
    return RoomInfoPreviewModel(
        area: json["area"] == null ? 0.0 : json["area"],
        gender: json["gender"] == null ? 0 : json["gender"],
        name: json["name"] == null ? "" : json["name"],
        rentalPrice: json["rentalPrice"] == null ? 0 : json["rentalPrice"],
        address: new StreetAddressModel.fromJson((json["address"])),
        roomType: new RoomTypeModel.fromJson(json["roomType"]),
        roomUtils: (json["roomUtils"] as List)
            .map((i) => RoomUtilityModel.fromJson(i))
            .toList());
  }
}
