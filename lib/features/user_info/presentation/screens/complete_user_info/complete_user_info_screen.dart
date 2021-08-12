import 'package:flutter/material.dart';

import '../../../../../size_config.dart';
import 'components/body.dart';

class CompleteUserInfoScreen extends StatelessWidget {
  const CompleteUserInfoScreen({Key? key}) : super(key: key);
  static String routeName = "/complete_user_info";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Complete Information"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
