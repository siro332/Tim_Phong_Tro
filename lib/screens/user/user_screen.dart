import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tim_phong_tro/components/error_alert.dart';
import 'package:tim_phong_tro/models/entities/user.dart';
import 'package:tim_phong_tro/screens/sign_in/sign_in_screen.dart';
import 'package:tim_phong_tro/services/auth_services.dart';
import 'package:tim_phong_tro/size_config.dart';

import 'components/body.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return StreamBuilder(
        stream: AuthServices().user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Container();
          else if (snapshot.hasError)
            return ErrorAlert(
                buttonText: "Login",
                alert: "You need to login to see this page",
                press: () {});
          else if (snapshot.hasData)
            return Body();
          else
            return SignInScreen();
        });
  }
}
