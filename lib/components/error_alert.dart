import 'package:flutter/material.dart';

import '../size_config.dart';
import 'default_button.dart';

class ErrorAlert extends StatelessWidget {
  const ErrorAlert({
    Key? key,
    required this.buttonText,
    required this.alert,
    required this.press,
  }) : super(key: key);
  final String alert, buttonText;
  final void Function() press;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(50)),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                alert,
                style: TextStyle(fontSize: getProportionateScreenWidth(15)),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              DefaultButton(
                text: this.buttonText,
                press: this.press,
              )
            ],
          ),
        ),
      ),
    );
  }
}
