import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tim_phong_tro/components/no_account_text.dart';
import 'package:tim_phong_tro/components/social_card.dart';
import 'package:tim_phong_tro/constants.dart';
import 'package:tim_phong_tro/screens/sign_in/components/sign_in_form.dart';
import 'package:tim_phong_tro/services/auth_services.dart';
import 'package:tim_phong_tro/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              Text(
                "Welcome Back",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Sign in with your email and password \nor continue with social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.08,
              ),
              SignInForm(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {
                        AuthServices().googleLogin();
                      }),
                  SocialCard(icon: "assets/icons/facebook-2.svg", press: () {}),
                  SocialCard(icon: "assets/icons/twitter.svg", press: () {}),
                ],
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.08,
              ),
              NoAccountText()
            ],
          ),
        ),
      ),
    ));
  }
}
