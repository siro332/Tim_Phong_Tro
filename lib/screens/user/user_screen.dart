import 'package:flutter/material.dart';

import '../../components/error_alert.dart';
import '../../services/auth_services.dart';
import '../../size_config.dart';
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
          return AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: _getScreen(snapshot));
        });
  }

  Widget _getScreen(AsyncSnapshot<Object?> snapshot) {
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
      return ErrorAlert(
          buttonText: "Login",
          alert: "You need to login to see this page",
          press: () {});
  }
}
