part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState([List props = const <dynamic>[]]);

  @override
  List<Object> get props => props;
}

class NotLoggedIn extends AuthenticationState {}

class Loading extends AuthenticationState {}

class LoggedIn extends AuthenticationState {
  final AppUser user;

  LoggedIn({required this.user}) : super([user]);
}

class Error extends AuthenticationState {
  final String message;

  Error({required this.message}) : super([message]);
}

class ErrorSendEmail extends AuthenticationState {
  final String message;

  ErrorSendEmail({required this.message}) : super([message]);
}
