import 'package:equatable/equatable.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/city.dart';

class Distric extends Equatable {
  final int id;
  final String name;
  final String image;
  final int code;
  final City city;
  Distric(
      {required this.id,
      required this.name,
      required this.image,
      required this.code,
      required this.city});
  @override
  List<Object?> get props => [id, name, code, image, city];
}
