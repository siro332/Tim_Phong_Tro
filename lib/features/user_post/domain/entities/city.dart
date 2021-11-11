import 'package:equatable/equatable.dart';

class City extends Equatable {
  final int id;
  final String name;
  final String image;
  final int code;

  City(
      {required this.id,
      required this.name,
      required this.image,
      required this.code});
  @override
  List<Object?> get props => [id, name, code, image];
}
