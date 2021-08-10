import 'package:flutter/material.dart';
import 'package:tim_phong_tro/screens/complete_user_info/components/cui_form.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

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
            "Complete your details below \nto set up your profile",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
          CompleteUserInfoForm(),
        ],
      ),
    );
  }
}
