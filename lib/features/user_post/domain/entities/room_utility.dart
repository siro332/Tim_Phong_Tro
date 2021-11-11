import 'package:equatable/equatable.dart';

class RoomUtilily extends Equatable {
  final int id;
  final String name;
  final String image;
  RoomUtilily({
    required this.id,
    required this.name,
    required this.image,
  });
  @override
  List<Object?> get props => [id, name, image];

  static fromJson(e) {}
}
