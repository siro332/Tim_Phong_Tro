import 'package:equatable/equatable.dart';
import 'package:tim_phong_tro/features/user_post/domain/entities/ward.dart';

class StreetAddress extends Equatable {
  final int id;
  final String streetName;
  final String houseNumber;
  final Ward ward;
  StreetAddress(
      {required this.id,
      required this.streetName,
      required this.houseNumber,
      required this.ward});
  @override
  List<Object?> get props => [id, streetName, houseNumber];
}
