import 'adress_model.dart';
import 'room_utility_model.dart';
import '../../domain/entities/room_info.dart';

import 'room_type_model.dart';

class RoomInfoModel extends RoomInfo {
  RoomInfoModel(
      {required id,
      required area,
      required gender,
      required name,
      required rentalPrice,
      required address,
      required roomType,
      required roomUtils,
      required deposit,
      required electricityCost,
      required image,
      required internetCost,
      required otherExpensive,
      required parkingCost,
      required waterCost,
      required capacity})
      : super(
          id: id,
          area: area,
          gender: gender,
          name: name,
          rentalPrice: rentalPrice,
          address: address,
          roomType: roomType,
          roomUtils: roomUtils,
          deposit: deposit,
          electricityCost: electricityCost,
          image: image,
          internetCost: internetCost,
          otherExpensive: otherExpensive,
          parkingCost: parkingCost,
          waterCost: waterCost,
          capacity: capacity,
        );

  factory RoomInfoModel.fromJson(Map<String, dynamic> json) {
    return RoomInfoModel(
        area: json["area"] == null ? 0.0 : json["area"],
        gender: json["gender"] == null ? 0 : json["gender"],
        name: json["name"] == null ? "" : json["name"],
        rentalPrice: json["rentalPrice"] == null ? 0 : json["rentalPrice"],
        address: new StreetAddressModel.fromJson((json["address"])),
        roomType: new RoomTypeModel.fromJson(json["roomType"]),
        roomUtils: (json["roomUtils"] as List)
            .map((i) => RoomUtilityModel.fromJson(i))
            .toList(),
        capacity: json["capacity"],
        deposit: json["deposit"],
        electricityCost: json["electricityCost"],
        id: json["id"],
        image: json["image"].toString().split(";"),
        internetCost: json["internetCost"],
        otherExpensive: json["otherExpense"],
        parkingCost: json["parkingCost"],
        waterCost: json["waterCost"]);
  }
}
