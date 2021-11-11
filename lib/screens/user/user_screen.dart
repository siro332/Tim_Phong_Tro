import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tim_phong_tro/features/authenticate/presentation/bloc/authentication_bloc.dart';
import 'package:tim_phong_tro/features/user_info/presentation/bloc/user_info_bloc.dart';

import '../../components/error_alert.dart';
import '../../constants.dart';
import '../../features/authenticate/presentation/screens/sign_in/sign_in_screen.dart';
import '../../size_config.dart';
import 'components/body.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: _buildBody(state, context));
    });
  }

  Widget _buildBody(AuthenticationState state, BuildContext context) {
    if (state is Loading) {
      return Container(
          child: Center(
        child: SpinKitDoubleBounce(
          color: kPrimaryColor,
        ),
      ));
    } else if (state is LoggedIn) {
      BlocProvider.of<UserInfoBloc>(context)
          .add(GetUserInfoEvent(uid: FirebaseAuth.instance.currentUser!.uid));
      return Body();
    }
    return ErrorAlert(
        buttonText: "Login",
        alert: "You need to login to see this page",
        press: () {
          Navigator.pushNamed(context, SignInScreen.routeName);
        });
  }
}
