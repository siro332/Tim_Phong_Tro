import '../../domain/entities/distric.dart';
import 'city_model.dart';

class DistricModel extends Distric {
  DistricModel(
      {required id,
      required name,
      required image,
      required code,
      required city})
      : super(id: id, name: name, image: image, code: code, city: city);

  factory DistricModel.fromJson(Map<String, dynamic> json) {
    return DistricModel(
        id: json["id"] == null ? 0 : json["id"],
        name: json["name"] == null ? "" : json["name"],
        image: json["image"] == null ? "" : json["image"],
        code: json["code"] == null ? 0 : json["code"],
        city: new CityModel.fromJson(json["city"]));
  }
}
