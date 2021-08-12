import 'package:equatable/equatable.dart';

class AppUserInfo extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String image;
  final String description;
  AppUserInfo({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.image,
    required this.description,
  });

  @override
  List<Object> get props =>
      [firstName, lastName, phoneNumber, image, description];
}
