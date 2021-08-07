import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tim_phong_tro/constants.dart';
import 'package:tim_phong_tro/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
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
            )),
            backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          ),
          onPressed: press,
          child: text == "Loading"
              ? SpinKitDoubleBounce(
                  color: Colors.white,
                  size: 30,
                )
              : Text(
                  text,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.white),
                )),
    );
  }
}
