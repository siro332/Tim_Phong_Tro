import 'package:equatable/equatable.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/distric.dart';

class Ward extends Equatable {
  final int id;
  final String name;
  final String image;
  final int code;
  final Distric distric;
  Ward(
      {required this.id,
      required this.name,
      required this.image,
      required this.code,
      required this.distric});
  @override
  List<Object?> get props => [id, name, code, image, distric];
}
