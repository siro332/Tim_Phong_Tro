import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tim_phong_tro/features/authenticate/presentation/bloc/authentication_bloc.dart';
import 'package:tim_phong_tro/features/user_info/presentation/bloc/user_info_bloc.dart';
import 'package:tim_phong_tro/features/user_info/presentation/screens/user_profile/user_profile_screen.dart';
import '../../../components/profile_pic.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          BlocBuilder<UserInfoBloc, UserInfoState>(builder: (context, state) {
            if (state is HaveData) {
              return ProfilePic(
                image: state.info.image,
                isEdit: false,
                uid: FirebaseAuth.instance.currentUser!.uid,
              );
            } else
              return ProfilePic(
                image: "",
                isEdit: false,
                uid: FirebaseAuth.instance.currentUser!.uid,
              );
          }),
          SizedBox(
            height: 30,
          ),
          UserMenuItem(
              text: "My Account",
              icon: FontAwesomeIcons.user,
              press: () async {
                String uid = FirebaseAuth.instance.currentUser!.uid;
                Navigator.pushNamed(context, UserProfileScreen.routeName,
                    arguments: uid);
              }),
          UserMenuItem(
              text: "Setting", icon: FontAwesomeIcons.cog, press: () {}),
          UserMenuItem(
              text: "About Us",
              icon: FontAwesomeIcons.questionCircle,
              press: () {}),
          UserMenuItem(
              text: "Log Out",
              icon: FontAwesomeIcons.signOutAlt,
              press: () {
                BlocProvider.of<AuthenticationBloc>(context).add(SigningOut());
              }),
          Spacer(),
        ],
      ),
    );
  }
}

class UserMenuItem extends StatelessWidget {
  const UserMenuItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final void Function()? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        onPressed: press,
        child: Row(
          children: [
            FaIcon(
              icon,
              size: 25,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            FaIcon(
              FontAwesomeIcons.angleRight,
              size: 25,
            )
          ],
        ),
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(20)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
            backgroundColor: MaterialStateProperty.all(Color(0xFFF5F6F9))),
      ),
    );
  }
}
