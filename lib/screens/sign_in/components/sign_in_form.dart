import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tim_phong_tro/components/custom_suffix_icon.dart';
import 'package:tim_phong_tro/components/default_button.dart';
import 'package:tim_phong_tro/components/form_error.dart';
import 'package:tim_phong_tro/constants.dart';
import 'package:tim_phong_tro/screens/forgot_password/forgot_password_screen.dart';
import 'package:tim_phong_tro/screens/home/home_screen.dart';
import 'package:tim_phong_tro/services/auth_services.dart';
import 'package:tim_phong_tro/size_config.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  bool isLoading = false;
  bool isShowPass = false;
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            buildEmailFormField(),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            buildPasswordFormField(),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Row(
              children: [
                Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, ForgotPasswordScreen.routeName),
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            FormError(errors: errors),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            isLoading
                ? DefaultButton(
                    text: "Loading",
                    press: () {},
                  )
                : DefaultButton(
                    text: "Sign In",
                    press: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if (_formKey.currentState!.validate() &&
                          errors.length <= 0) {
                        _formKey.currentState!.save();
                        String response = await AuthServices.signIn(
                            this.email, this.password);
                        if (response == kAccessToken) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, HomeScreen.routeName, (route) => false);
                        } else if (response == kWrongEmailPassword &&
                            !errors.contains(kWrongEmailPassword)) {
                          setState(() {
                            errors.add(kWrongEmailPassword);
                          });
                        } else if (response == kNetworkError &&
                            !errors.contains(kNetworkError)) {
                          setState(() {
                            errors.add(kNetworkError);
                          });
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }),
          ],
        ));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      readOnly: this.isLoading,
      obscureText: !this.isShowPass,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (errors.contains(kWrongEmailPassword)) {
          setState(() {
            errors.remove(kWrongEmailPassword);
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
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      readOnly: this.isLoading,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (errors.contains(kWrongEmailPassword)) {
          setState(() {
            errors.remove(kWrongEmailPassword);
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
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
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
