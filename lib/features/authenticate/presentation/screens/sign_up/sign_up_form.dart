import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tim_phong_tro/components/custom_suffix_icon.dart';
import 'package:tim_phong_tro/components/default_button.dart';
import 'package:tim_phong_tro/components/form_error.dart';
import 'package:tim_phong_tro/features/authenticate/presentation/bloc/authentication_bloc.dart';
import 'package:tim_phong_tro/features/user_info/presentation/screens/complete_user_info/complete_user_info_screen.dart';

import '../../../../../constants.dart';
import '../../../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firebaseError = "";
  bool isShowPass = false;
  String email = "";
  String password = "";
  String confirmPassword = "";
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Error) {
          setState(() {
            errors.add(firebaseError = state.message);
          });
        } else if (state is LoggedIn) {
          Navigator.popAndPushNamed(context, CompleteUserInfoScreen.routeName);
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildEmailFormField(state),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    buildPasswordFormField(state),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    buildConfirmPasswordFormField(state),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    FormError(errors: errors),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    (state is Loading)
                        ? DefaultButton(
                            text: "Loading",
                            press: () {},
                          )
                        : DefaultButton(
                            text: "Sign Up",
                            press: () async {
                              if (_formKey.currentState!.validate() &&
                                  errors.length <= 0) {
                                _formKey.currentState!.save();
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(SignUpEvent(email, password));
                              }
                            }),
                  ],
                ),
              ));
        },
      ),
    );
  }

  TextFormField buildPasswordFormField(AuthenticationState state) {
    return TextFormField(
      readOnly: (state is Loading),
      obscureText: !this.isShowPass,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (errors.contains(firebaseError)) {
          setState(() {
            errors.remove(firebaseError);
          });
        }
        if (errors.contains(kNetworkError)) {
          setState(() {
            errors.remove(kNetworkError);
          });
        }
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.length >= 8 &&
            errors.contains(kShortPassError) &&
            value != "") {
          setState(() {
            errors.remove(kShortPassError);
          });

          return null;
        }
        setState(() {
          password = value;
        });
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });

          return null;
        } else if (value.length < 8 &&
            !errors.contains(kShortPassError) &&
            value != "") {
          setState(() {
            errors.add(kShortPassError);
          });
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter Your Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isShowPass = !isShowPass;
            });
          },
          child: isShowPass
              ? CustomSuffixIcon(
                  icon: FontAwesomeIcons.eyeSlash,
                )
              : CustomSuffixIcon(
                  icon: FontAwesomeIcons.eye,
                ),
        ),
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField(AuthenticationState state) {
    return TextFormField(
      readOnly: (state is Loading),
      obscureText: !this.isShowPass,
      onSaved: (newValue) => confirmPassword = newValue!,
      onChanged: (value) {
        if (errors.contains(firebaseError)) {
          setState(() {
            errors.remove(firebaseError);
          });
        }
        if (errors.contains(kMatchPassError)) {
          setState(() {
            errors.remove(kMatchPassError);
          });
        }
        if (errors.contains(kNetworkError)) {
          setState(() {
            errors.remove(kNetworkError);
          });
        }
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        }
        setState(() {
          confirmPassword = value;
        });
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });

          return null;
        }
        if (value != password && !errors.contains(kMatchPassError)) {
          setState(() {
            errors.add(kMatchPassError);
          });

          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re Enter Your Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isShowPass = !isShowPass;
            });
          },
          child: isShowPass
              ? CustomSuffixIcon(
                  icon: FontAwesomeIcons.eyeSlash,
                )
              : CustomSuffixIcon(
                  icon: FontAwesomeIcons.eye,
                ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField(AuthenticationState state) {
    return TextFormField(
      readOnly: (state is Loading),
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (errors.contains(firebaseError)) {
          setState(() {
            errors.remove(firebaseError);
          });
        }
        if (errors.contains(kNetworkError)) {
          setState(() {
            errors.remove(kNetworkError);
          });
        }
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });

          return null;
        }
        setState(() {
          email = value;
        });
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });

          return null;
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError) &&
            value != "") {
          setState(() {
            errors.add(kInvalidEmailError);
          });
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter Your Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          icon: FontAwesomeIcons.envelope,
        ),
      ),
    );
  }
}
