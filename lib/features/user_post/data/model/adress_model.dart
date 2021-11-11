import 'package:tim_phong_tro/features/user_post/data/model/ward_model.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/street_address.dart';

class StreetAddressModel extends StreetAddress {
  StreetAddressModel(
      {required id, required streetName, required houseNumber, required ward})
      : super(
            id: id,
            streetName: streetName,
            houseNumber: houseNumber,
            ward: ward);

  factory StreetAddressModel.fromJson(Map<String, dynamic> json) {
    return StreetAddressModel(
        id: json["id"] == null ? 0 : json["id"],
        streetName: json["streetName"] == null ? 0 : json["streetName"],
        houseNumber: json["houseNumber"] == null ? 0 : json["houseNumber"],
        ward: new WardModel.fromJson((json["ward"])));
  }
}
