import 'package:flutter/material.dart';
import 'package:tim_phong_tro/components/class/my_shared_preferences.dart';
import 'package:tim_phong_tro/constants.dart';
import 'package:tim_phong_tro/routes.dart';
import 'package:tim_phong_tro/screens/sign_in/sign_in_screen.dart';
import 'package:tim_phong_tro/screens/splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  bool isFirstTimeOpen = false;
  MyAppState() {
    MysharedPreferences.instance
        .getBooleanValue("firstTimeOpen")
        .then((value) => setState(() {
              isFirstTimeOpen = value;
            }));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.green,
          fontFamily: "Muli",
          textTheme: TextTheme(
              bodyText1: TextStyle(color: kTextColor),
              bodyText2: TextStyle(color: kTextColor))),
      initialRoute:
          isFirstTimeOpen ? SignInScreen.routeName : SplashScreen.routeName,
      routes: routes,
    );
  }
}
