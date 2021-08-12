import 'package:flutter/widgets.dart';

import 'features/authenticate/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'features/authenticate/presentation/screens/sign_in/sign_in_screen.dart';
import 'features/authenticate/presentation/screens/sign_up/sign_up_screen.dart';
import 'features/user_info/presentation/screens/complete_user_info/complete_user_info_screen.dart';
import 'features/user_info/presentation/screens/user_profile/user_profile_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteUserInfoScreen.routeName: (context) => CompleteUserInfoScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  UserProfileScreen.routeName: (context) => UserProfileScreen(),
};
