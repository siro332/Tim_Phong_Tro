part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent([List props = const <dynamic>[]]);

  @override
  List<Object> get props => props;
}

class LoginWithEmailPasswordEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginWithEmailPasswordEvent(this.email, this.password)
      : super([email, password]);
}

class SignUpEvent extends AuthenticationEvent {
  final String email;
  final String password;

  SignUpEvent(this.email, this.password) : super([email, password]);
}

class SigningOut extends AuthenticationEvent {
  SigningOut() : super();
}

class CurrentUser extends AuthenticationEvent {
  CurrentUser() : super();
}

class LoginWithGoogle extends AuthenticationEvent {
  LoginWithGoogle() : super();
}

class LoginWithFacebook extends AuthenticationEvent {
  LoginWithFacebook() : super();
}

class ResetPasswordEvent extends AuthenticationEvent {
  final String email;
  ResetPasswordEvent({required this.email}) : super();
}
