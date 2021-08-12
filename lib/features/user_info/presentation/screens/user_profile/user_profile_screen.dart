import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tim_phong_tro/size_config.dart';

import 'components/body.dart';

class UserProfileScreen extends StatelessWidget {
  static String routeName = "/user-profile";
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = ModalRoute.of(context)!.settings.arguments as String;
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.angleLeft, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Body(uid: uid),
      resizeToAvoidBottomInset: false,
    );
  }
}
