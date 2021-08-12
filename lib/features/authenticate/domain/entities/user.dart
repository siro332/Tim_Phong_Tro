import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String uid;
  AppUser({required this.uid});

  @override
  List<Object> get props => [uid];
}
