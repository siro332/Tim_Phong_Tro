import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]);
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CachedFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AuthFailure extends Failure {
  final String message;

  AuthFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  @override
  List<Object?> get props => throw UnimplementedError();
}
