import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../components/error_alert.dart';
import '../../../../constants.dart';
import '../../../authenticate/presentation/bloc/authentication_bloc.dart';
import '../../../authenticate/presentation/screens/sign_in/sign_in_screen.dart';
import '../../domain/entities/user_post.dart';
import '../bloc/bloc/user_post_bloc.dart';

class Detail extends StatelessWidget {
  final int id;

  Detail({required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is LoggedIn) {
        BlocProvider.of<UserPostBloc>(context).add(GetPostDetailEvent(id: id));
        return BlocBuilder<UserPostBloc, UserPostState>(
            builder: (context, state) {
          return Scaffold(
            body: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: _body(state, context)),
          );
        });
      } else {
        return Scaffold(
          body: ErrorAlert(
              buttonText: "Login",
              alert: "You need to login to see this page",
              press: () {
                Navigator.pushNamed(context, SignInScreen.routeName);
              }),
        );
      }
    });
  }

  Widget _body(UserPostState state, BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]},';
    if (state is NoData || state is PostDetailLoading) {
      return Container(
        child: Center(
          child: SpinKitDoubleBounce(
            color: kPrimaryColor,
          ),
        ),
      );
    } else if (state is HavePostDetailData) {
      if (state.userPost.id != id) {
        return Container(
          child: Center(
            child: SpinKitDoubleBounce(
              color: kPrimaryColor,
            ),
          ),
        );
      } else {
        Size size = MediaQuery.of(context).size;
        UserPost property = state.userPost;
        return CustomScrollView(slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      color: kPrimaryColor,
                      size: 24,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: FaIcon(
                      FontAwesomeIcons.solidHeart,
                      color: kPrimaryColor,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: property.thumbnailImage,
                child: Container(
                  height: size.height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(property.thumbnailImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(property.user.info.image),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                property.user.info.firstName +
                                    " " +
                                    property.user.info.lastName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                property.user.email,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                launch("tel://" + property.phoneNumber),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: kPrimaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.phone,
                                  color: kPrimaryColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.message,
                                color: kPrimaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                buildHeader("Address"),
                GestureDetector(
                  onTap: () async {
                    String query = Uri.encodeComponent(
                        property.roomInfo.address.houseNumber +
                            " " +
                            property.roomInfo.address.streetName +
                            ", " +
                            property.roomInfo.address.ward.name +
                            ", " +
                            property.roomInfo.address.ward.distric.name +
                            ", " +
                            property.roomInfo.address.ward.distric.city.name);
                    if (await canLaunch(
                        "https://www.google.com/maps/search/?api=1&query=" +
                            query)) {
                      await launch(
                          "https://www.google.com/maps/search/?api=1&query=" +
                              query);
                    }
                  },
                  child: buildTextWithIconContent(
                      FontAwesomeIcons.mapMarkedAlt,
                      property.roomInfo.address.houseNumber +
                          " " +
                          property.roomInfo.address.streetName +
                          ", " +
                          property.roomInfo.address.ward.name +
                          ", " +
                          property.roomInfo.address.ward.distric.name +
                          ", " +
                          property.roomInfo.address.ward.distric.city.name),
                ),
                buildHeader("Area"),
                buildTextWithIconContent(
                  FontAwesomeIcons.square,
                  property.roomInfo.area.toString() + " sq/m",
                ),
                buildHeader("Capacity"),
                buildTextWithIconContent(
                    FontAwesomeIcons.users,
                    property.roomInfo.capacity.toString() +
                        (property.roomInfo.capacity == 1
                            ? " people"
                            : " peoples")),
                buildHeader("Main Fees"),
                Padding(
                  padding: EdgeInsets.only(
                    right: 24,
                    left: 24,
                    bottom: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildRowItem(
                          FontAwesomeIcons.moneyBill,
                          30,
                          "Rental Price",
                          property.roomInfo.rentalPrice
                              .toString()
                              .replaceAllMapped(reg, mathFunc),
                          16),
                      SizedBox(
                        width: 20.0,
                      ),
                      buildRowItem(
                          FontAwesomeIcons.dollarSign,
                          30,
                          "Deposit",
                          property.roomInfo.deposit
                              .toString()
                              .replaceAllMapped(reg, mathFunc),
                          16),
                    ],
                  ),
                ),
                buildHeader("Other Fees"),
                Padding(
                  padding: EdgeInsets.only(
                    right: 24,
                    left: 24,
                    bottom: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildRowItem(
                          FontAwesomeIcons.lightbulb,
                          25,
                          "Electricity",
                          property.roomInfo.electricityCost
                              .toString()
                              .replaceAllMapped(reg, mathFunc),
                          14),
                      buildRowItem(
                          FontAwesomeIcons.water,
                          25,
                          "Water",
                          property.roomInfo.waterCost
                              .toString()
                              .replaceAllMapped(reg, mathFunc),
                          14),
                      buildRowItem(
                          FontAwesomeIcons.globe,
                          25,
                          "Internet",
                          property.roomInfo.internetCost
                              .toString()
                              .replaceAllMapped(reg, mathFunc),
                          14),
                      buildRowItem(
                          FontAwesomeIcons.motorcycle,
                          25,
                          "Parking",
                          property.roomInfo.parkingCost
                              .toString()
                              .replaceAllMapped(reg, mathFunc),
                          14),
                      buildRowItem(
                          FontAwesomeIcons.ellipsisH,
                          25,
                          "Other",
                          property.roomInfo.otherExpensive
                              .toString()
                              .replaceAllMapped(reg, mathFunc),
                          14),
                    ],
                  ),
                ),
                buildHeader("Description"),
                buildTextContent(property.description),
                buildHeader("Photos"),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 24,
                  ),
                  child: SizedBox(
                    height: 250.0,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: buildPhotos(property.roomInfo.image),
                    ),
                  ),
                ),
                buildHeader("Posting Date"),
                buildTextContent(DateFormat('yyyy-MM-dd – kk:mm')
                    .format(property.postingDate)),
              ],
            ),
          )
        ]);
      }
    } else {
      return ErrorAlert(
          buttonText: "Go back",
          alert: "Error loading this page, please go back.",
          press: () {
            Navigator.pop(context);
          });
    }
  }

  Widget buildHeader(String header) {
    return Padding(
      padding: EdgeInsets.only(
        right: 24,
        left: 24,
        bottom: 16,
      ),
      child: Text(
        header,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildTextWithIconContent(IconData faIcon, String text) {
    return Padding(
      padding: EdgeInsets.only(
        right: 24,
        left: 24,
        bottom: 24,
      ),
      child: Row(
        children: [
          FaIcon(
            faIcon,
            color: kPrimaryColor,
            size: 16,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 330.0,
            child: Text(
              text,
              overflow: TextOverflow.visible,
              maxLines: 2,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextContent(String text) {
    return Padding(
      padding: EdgeInsets.only(
        right: 24,
        left: 24,
        bottom: 24,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[500],
        ),
      ),
    );
  }

  Widget buildRowItem(IconData icon, double iconSize, String lable,
      String content, double fontSize) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      FaIcon(
        icon,
        color: kPrimaryColor,
        size: iconSize,
      ),
      SizedBox(
        width: 4,
      ),
      Text(
        lable,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.grey[500],
        ),
      ),
      Text(
        content,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.grey[500],
        ),
      ),
    ]);
  }

  Widget buildFeature(IconData iconData, String text) {
    return Column(
      children: [
        Icon(
          iconData,
          color: Colors.yellow[700],
          size: 28,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  List<Widget> buildPhotos(List<String> images) {
    List<Widget> list = [];
    list.add(SizedBox(
      width: 24,
    ));
    for (var i = 0; i < images.length; i++) {
      if (images[i] != "") {
        list.add(buildPhoto(images[i]));
      }
    }
    return list;
  }

  Widget buildPhoto(String url) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        margin: EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
