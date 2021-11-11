import 'package:equatable/equatable.dart';

class RoomType extends Equatable {
  final int id;
  final String name;
  RoomType({required this.id, required this.name});
  @override
  List<Object?> get props => [id, name];
}
