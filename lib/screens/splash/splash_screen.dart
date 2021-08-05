import 'package:flutter/material.dart';
import 'package:tim_phong_tro/screens/splash/components/body.dart';
import 'package:tim_phong_tro/size_config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
