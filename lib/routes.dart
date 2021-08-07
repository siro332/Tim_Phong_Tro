import 'package:flutter/widgets.dart';
import 'package:tim_phong_tro/screens/forgot_password/forgot_password_screen.dart';
import 'package:tim_phong_tro/screens/home/home_screen.dart';
import 'package:tim_phong_tro/screens/sign_in/sign_in_screen.dart';
import 'package:tim_phong_tro/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
};
