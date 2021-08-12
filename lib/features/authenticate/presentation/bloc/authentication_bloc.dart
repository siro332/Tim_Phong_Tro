import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tim_phong_tro/features/authenticate/domain/entities/user.dart';
import 'package:tim_phong_tro/features/authenticate/domain/usecases/register/register.dart';
import 'package:tim_phong_tro/features/authenticate/domain/usecases/reset_password/reset_password.dart';
import 'package:tim_phong_tro/features/authenticate/domain/usecases/sign_in/sign_in_with_emaill_and_password.dart';
import 'package:tim_phong_tro/features/authenticate/domain/usecases/sign_in/sign_in_with_facebook.dart';
import 'package:tim_phong_tro/features/authenticate/domain/usecases/sign_in/sign_in_with_google.dart';
import 'package:tim_phong_tro/features/authenticate/domain/usecases/sign_out/sign_out.dart';

import 'package:tim_phong_tro/features/authenticate/domain/usecases/get/get_current_user.dart';

import '../../../../../constants.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final SignInWithGoogle signInWithGoogle;
  final SignInWithFacebook signInWithFacebook;
  final Register register;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;
  final ResetPassword resetPassword;

  AuthenticationBloc({
    required this.signInWithEmailAndPassword,
    required this.signInWithGoogle,
    required this.signInWithFacebook,
    required this.register,
    required this.signOut,
    required this.getCurrentUser,
    required this.resetPassword,
  }) : super(NotLoggedIn());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is LoginWithEmailPasswordEvent) {
      final String email = event.email;
      final String password = event.password;
      yield Loading();
      final signInEither = await signInWithEmailAndPassword(
          EmailPasswordParams(email: email, password: password));
      yield* _eitherLoggedInOrError(signInEither);
    } else if (event is SignUpEvent) {
      final String email = event.email;
      final String password = event.password;
      yield Loading();
      final registerEither =
          await register(Params(email: email, password: password));
      yield* _eitherLoggedInOrError(registerEither);
    } else if (event is SigningOut) {
      yield Loading();
      await signOut(new NoParams());
      yield NotLoggedIn();
    } else if (event is CurrentUser) {
      yield Loading();
      final currentUser = await getCurrentUser(new NoParams());
      yield currentUser.fold(
          (failure) => NotLoggedIn(), (user) => LoggedIn(user: user));
    } else if (event is LoginWithGoogle) {
      yield Loading();
      final signInEither = await signInWithGoogle(new NoParams());
      yield* _eitherLoggedInOrError(signInEither);
    } else if (event is LoginWithFacebook) {
      yield Loading();
      final signInEither = await signInWithFacebook(new NoParams());
      yield* _eitherLoggedInOrError(signInEither);
    } else if (event is ResetPasswordEvent) {
      yield Loading();
      final result =
          await resetPassword(new ResetPassParams(email: event.email));
      yield result.fold(
          (failure) => ErrorSendEmail(message: _mapFailureToMessage(failure)),
          (right) => NotLoggedIn());
    }
  }

  Stream<AuthenticationState> _eitherLoggedInOrError(
      Either<Failure, AppUser> either) async* {
    yield either.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (user) => LoggedIn(user: user));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return kNetworkError;
      case AuthFailure:
        AuthFailure authFailure = failure as AuthFailure;
        return authFailure.message;
      default:
        return "Unexpected Error";
    }
  }
}
