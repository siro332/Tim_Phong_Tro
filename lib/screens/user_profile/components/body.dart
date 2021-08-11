import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../components/error_alert.dart';
import '../../../components/profile_pic.dart';
import '../../../constants.dart';
import '../../../models/dtos/user_info.dart';
import '../../../services/auth_services.dart';
import '../../../services/user_services.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({required this.uid, Key? key}) : super(key: key);
  final String uid;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserInfo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return AnimatedSwitcher(
            duration: Duration(milliseconds: 500), child: _body(snapshot));
      },
    );
  }

  Widget _body(AsyncSnapshot<dynamic> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return Container(
          child: Center(
            child: SpinKitDoubleBounce(
              color: kPrimaryColor,
            ),
          ),
        );
      default:
        if (snapshot.data != null)
          return BuildBody(info: snapshot.data);
        else
          return ErrorAlert(
              buttonText: "Go back",
              alert: "Error loading this page, please go back.",
              press: () {
                Navigator.pop(context);
              });
    }
  }

  _getUserInfo() async {
    dynamic result = await UserServices().getUserInfo(
        await AuthServices().getCurrentUserToken(), this.widget.uid);
    if (result != "Error") {
      return result;
    }
  }
}

class BuildBody extends StatelessWidget {
  const BuildBody({
    Key? key,
    required this.info,
  }) : super(key: key);

  final AppUserInfo info;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: SizeConfig.screenHeight * 0.3,
                    decoration: BoxDecoration(gradient: kPrimaryGradientColor),
                  ),
                  Container(
                    height: SizeConfig.screenHeight * 0.3,
                  )
                ],
              ),
              InfoCard(info: info),
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 1,
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatefulWidget {
  const InfoCard({
    required this.info,
    Key? key,
  }) : super(key: key);
  final AppUserInfo info;
  @override
  _InfoCardState createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool isShowAll = false;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: SizeConfig.screenHeight * 0.175,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: double.infinity,
          ),
          width: SizeConfig.screenWidth * 0.85,
          decoration: BoxDecoration(
            color: Color(0xFFF5F6F9),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(25),
                vertical: getProportionateScreenWidth(20)),
            child: Column(children: [
              Row(
                children: [
                  ProfilePic(image: widget.info.image!, isEdit: false),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenWidth(30)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.info.firstName! +
                                " " +
                                widget.info.lastName!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: kPrimaryColor),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          SelectableText(
                            widget.info.phoneNumber!,
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              setState(() {
                                isShowAll = !isShowAll;
                              });
                            },
                            child: Text(
                              "Show full description",
                              style: TextStyle(color: kPrimaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.info.description! +
                    " AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" +
                    "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" +
                    "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" +
                    "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
                overflow:
                    isShowAll ? TextOverflow.visible : TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
