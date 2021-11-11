import 'package:tim_phong_tro/features/user_post/domain/entities/room_utility.dart';

class RoomUtilityModel extends RoomUtilily {
  RoomUtilityModel({required id, required name, required image})
      : super(id: id, name: name, image: image);

  factory RoomUtilityModel.fromJson(Map<String, dynamic> json) {
    return RoomUtilityModel(
        id: json["id"],
        name: json["name"],
        image: json["image"] == null ? "" : json["image"]);
  }
}
