import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tim_phong_tro/components/error_alert.dart';
import 'package:tim_phong_tro/features/authenticate/presentation/bloc/authentication_bloc.dart';
import 'package:tim_phong_tro/features/authenticate/presentation/screens/sign_in/sign_in_screen.dart';

import '../../../../../../constants.dart';
import 'body.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({Key? key}) : super(key: key);

  @override
  _SaveScreenState createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  @override
  Widget build(BuildContext context) {
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
