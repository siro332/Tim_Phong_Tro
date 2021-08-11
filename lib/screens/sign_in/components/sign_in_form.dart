import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../services/auth_services.dart';
import '../../../size_config.dart';
import '../../forgot_password/forgot_password_screen.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final AuthServices _auth = new AuthServices();
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firebaseError = "";
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
                      if (_formKey.currentState!.validate() &&
                          errors.length <= 0) {
                        _formKey.currentState!.save();
                        setState(() {
                          isLoading = true;
                        });
                        dynamic result = await _auth.signInWithEmailPassword(
                            email, password);
                        if (result != kSignedIn) {
                          setState(() {
                            firebaseError = result;
                            errors.add(firebaseError);
                            isLoading = false;
                          });
                        } else {
                          Navigator.pop(context);
                        }
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
