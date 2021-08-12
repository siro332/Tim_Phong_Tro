import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tim_phong_tro/features/authenticate/presentation/bloc/authentication_bloc.dart';
import 'package:tim_phong_tro/features/user_info/presentation/bloc/user_info_bloc.dart';
import 'package:tim_phong_tro/size_config.dart';

import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is LoggedIn) {
          BlocProvider.of<UserInfoBloc>(context).add(
              GetUserInfoEvent(uid: FirebaseAuth.instance.currentUser!.uid));
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Body(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
