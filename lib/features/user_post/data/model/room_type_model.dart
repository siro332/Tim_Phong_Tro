import '../../domain/entities/room_type.dart';

class RoomTypeModel extends RoomType {
  RoomTypeModel({required id, required name}) : super(id: id, name: name);

  factory RoomTypeModel.fromJson(Map<String, dynamic> json) {
    return RoomTypeModel(id: json["id"], name: json["name"]);
  }
}
