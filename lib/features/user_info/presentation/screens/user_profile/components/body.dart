import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tim_phong_tro/features/user_info/data/models/arguments/user_info_arguments.dart';
import 'package:tim_phong_tro/features/user_info/presentation/screens/edit_user_profile/edit_user_profile_screen.dart';

import '../../../../../../components/error_alert.dart';
import '../../../../../../components/profile_pic.dart';
import '../../../../../../constants.dart';
import '../../../../../../size_config.dart';
import '../../../../domain/entities/user_info.dart';
import '../../../bloc/user_info_bloc.dart';

class Body extends StatefulWidget {
  const Body({required this.uid, Key? key}) : super(key: key);
  final String uid;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        return AnimatedSwitcher(
            duration: Duration(milliseconds: 500), child: _body(state));
      },
    );
  }

  Widget _body(UserInfoState state) {
    if (state is InfoLoading) {
      return Container(
        child: Center(
          child: SpinKitDoubleBounce(
            color: kPrimaryColor,
          ),
        ),
      );
    } else if (state is HaveData) {
      return BuildBody(info: state.info, uid: widget.uid);
    } else {
      return ErrorAlert(
          buttonText: "Go back",
          alert: "Error loading this page, please go back.",
          press: () {
            Navigator.pop(context);
          });
    }
  }
}

class BuildBody extends StatelessWidget {
  const BuildBody({Key? key, required this.info, required this.uid})
      : super(key: key);

  final AppUserInfo info;
  final String uid;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            fit: StackFit.loose,
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
              ),
              Container(
                width: double.infinity,
                height: SizeConfig.screenHeight * 0.3,
                decoration: BoxDecoration(gradient: kPrimaryGradientColor),
              ),
              InfoCard(info: info, uid: uid),
              uid.contains(FirebaseAuth.instance.currentUser!.uid)
                  ? Positioned(
                      top: SizeConfig.screenHeight * 0.175,
                      right: SizeConfig.screenWidth * 0.05,
                      child: TextButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, EditUserProfile.routeName,
                                arguments: new UserInfoArguments(uid, info));
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.cog,
                            color: kPrimaryColor,
                          ),
                          label: Text("")),
                    )
                  : Container(),
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
    required this.uid,
    Key? key,
  }) : super(key: key);
  final AppUserInfo info;
  final String uid;
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
        child: Column(
          children: [
            Container(
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
                      ProfilePic(
                          image: widget.info.image,
                          isEdit: false,
                          uid: widget.uid),
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
                                widget.info.firstName +
                                    " " +
                                    widget.info.lastName,
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
                                widget.info.phoneNumber,
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
                    widget.info.description +
                        " AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" +
                        "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" +
                        "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" +
                        "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
                    overflow: isShowAll
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  )
                ]),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenWidth(20)),
                child: Container(
                  width: SizeConfig.screenWidth * 0.85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Posted Room",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                "https://www.hancorp.com.vn/wp-content/uploads/2020/08/phong-tro-2.jpg",
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
