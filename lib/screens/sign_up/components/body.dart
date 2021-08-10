import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tim_phong_tro/components/custom_suffix_icon.dart';
import 'package:tim_phong_tro/components/default_button.dart';
import 'package:tim_phong_tro/components/form_error.dart';
import 'package:tim_phong_tro/services/auth_services.dart';
import 'package:tim_phong_tro/size_config.dart';

import '../../../constants.dart';
import '../sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
          Text(
            "Register Account",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: getProportionateScreenWidth(28),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Complete your details below \nto sign up a new account",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
          SignUpForm(),
        ],
      ),
    );
  }
}
