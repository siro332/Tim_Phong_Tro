import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tim_phong_tro/constants.dart';
import 'package:tim_phong_tro/size_config.dart';

class DefaultOutlinedButton extends StatelessWidget {
  const DefaultOutlinedButton({
    Key? key,
    this.text = "",
    this.press,
  }) : super(key: key);
  final String text;
  final void Function()? press;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: kPrimaryColor),
            )),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: press,
          child: text == "Loading"
              ? SpinKitDoubleBounce(
                  color: kPrimaryColor,
                  size: 30,
                )
              : Text(
                  text,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: kPrimaryColor),
                )),
    );
  }
}
