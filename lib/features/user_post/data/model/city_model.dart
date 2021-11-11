import 'package:tim_phong_tro/features/user_post/domain/entities/city.dart';

class CityModel extends City {
  CityModel({required id, required name, required image, required code})
      : super(id: id, name: name, image: image, code: code);

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
        id: json["id"] == null ? 0 : json["id"],
        name: json["name"] == null ? "" : json["name"],
        image: json["image"] == null ? "" : json["image"],
        code: json["code"] == null ? 0 : json["code"]);
  }
}
