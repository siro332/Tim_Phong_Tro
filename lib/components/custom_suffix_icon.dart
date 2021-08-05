import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tim_phong_tro/size_config.dart';

class CustomSuffixIcon extends StatelessWidget {
  const CustomSuffixIcon({
    Key? key,
    this.image = "",
  }) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, getProportionateScreenWidth(20),
            getProportionateScreenWidth(20), getProportionateScreenWidth(20)),
        child: SvgPicture.asset(
          image,
          height: getProportionateScreenWidth(18),
        ));
  }
}
