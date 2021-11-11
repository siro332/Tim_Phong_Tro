import 'package:tim_phong_tro/features/user_post/domain/entities/post_preview.dart';

import 'room_info_preview_model.dart';

class UserPostPreviewModel extends UserPostPreview {
  UserPostPreviewModel(
      {required id,
      required name,
      required phoneNumber,
      required thumbnailImage,
      required roomInfo,
      required description,
      required isVerifired,
      required postingDate})
      : super(
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            thumbnailImage: thumbnailImage,
            roomInfo: roomInfo,
            description: description,
            isVerifired: isVerifired,
            postingDate: postingDate);

  factory UserPostPreviewModel.fromJson(Map<String, dynamic> json) {
    return UserPostPreviewModel(
        id: json["id"],
        name: json["name"] == null ? "" : json["name"],
        phoneNumber: json["phoneNumber"] == null ? "" : json["phoneNumber"],
        thumbnailImage:
            json["thumbnailImage"] == null ? "" : json["thumbnailImage"],
        roomInfo: new RoomInfoPreviewModel.fromJson(json["roomInfo"]),
        description: json["description"] == null ? "" : json["description"],
        isVerifired: json["isVerifired"] == null ? false : json["isVerifired"],
        postingDate: DateTime.parse(json["postingDate"]));
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "thumbnailImage": thumbnailImage,
      };
}
