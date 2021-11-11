import 'package:tim_phong_tro/features/user_post/data/model/distric_model.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/ward.dart';

class WardModel extends Ward {
  WardModel(
      {required id,
      required name,
      required image,
      required code,
      required distric})
      : super(id: id, name: name, image: image, code: code, distric: distric);

  factory WardModel.fromJson(Map<String, dynamic> json) {
    return WardModel(
        id: json["id"] == null ? 0 : json["id"],
        name: json["name"] == null ? "" : json["name"],
        image: json["image"] == null ? "" : json["image"],
        code: json["code"] == null ? 0 : json["code"],
        distric: new DistricModel.fromJson(json["district"]));
  }
}
