import 'package:flutter/material.dart';
import 'package:tim_phong_tro/components/error_alert.dart';
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
    return FutureBuilder<bool>(
        future: AuthServices.isLogedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else
              return snapshot.data!
                  ? Body()
                  : ErrorAlert(
                      buttonText: "Login",
                      alert: "You need to login to see this page",
                      press: () =>
                          Navigator.pushNamed(context, SignInScreen.routeName));
          }
        });
  }
}
