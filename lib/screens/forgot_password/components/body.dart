import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tim_phong_tro/components/custom_suffix_icon.dart';
import 'package:tim_phong_tro/components/default_button.dart';
import 'package:tim_phong_tro/components/form_error.dart';
import 'package:tim_phong_tro/components/no_account_text.dart';
import 'package:tim_phong_tro/services/auth_services.dart';
import 'package:tim_phong_tro/size_config.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Forgot Password",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(28),
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Please enter your email and we will send \nyou a link to return to your account",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.1,
            ),
            ForgotPassForm()
          ],
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({Key? key}) : super(key: key);

  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firebaseError = "";
  String email = "";
  bool isSent = false;
  bool isLoad = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.04,
            ),
            TextFormField(
              readOnly: isLoad,
              onSaved: (newValue) => email = newValue!,
              onChanged: (value) {
                if (errors.contains(firebaseError)) {
                  setState(() {
                    errors.remove(firebaseError);
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
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            FormError(errors: errors),
            isSent
                ? Text(
                    "An email has been sent to your email address, please check your mail box for a password reset link.",
                  )
                : Container(),
            SizedBox(
              height: SizeConfig.screenHeight * 0.1,
            ),
            DefaultButton(
                text: isLoad
                    ? "Loading"
                    : isSent
                        ? "Go back"
                        : "Continue",
                press: isLoad
                    ? () {}
                    : isSent
                        ? () {
                            Navigator.pop(context);
                          }
                        : () async {
                            setState(() {
                              isLoad = !isLoad;
                            });
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              try {
                                await AuthServices()
                                    .sendPassWordResetEmail(email);
                                setState(() {
                                  isLoad = !isLoad;
                                  isSent = true;
                                });
                              } catch (e) {
                                setState(() {
                                  firebaseError = e.toString().split("] ")[1];
                                  errors.add(firebaseError);
                                  isLoad = !isLoad;
                                });
                              }
                            }
                          }),
            SizedBox(
              height: SizeConfig.screenHeight * 0.1,
            ),
            NoAccountText(),
          ],
        ),
      ),
    );
  }
}
