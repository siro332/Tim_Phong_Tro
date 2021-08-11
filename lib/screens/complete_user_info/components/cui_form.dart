import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../models/dtos/user_info.dart';
import '../../../services/user_services.dart';
import '../../../size_config.dart';

class CompleteUserInfoForm extends StatefulWidget {
  const CompleteUserInfoForm({Key? key}) : super(key: key);

  @override
  _CompleteUserInfoFormState createState() => _CompleteUserInfoFormState();
}

class _CompleteUserInfoFormState extends State<CompleteUserInfoForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firebaseError = "";
  bool isLoading = false;
  bool isShowPass = false;

  String firstName = "";

  String lastName = "";

  String phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildFirstNameFormField(),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              buildLastNameFormField(),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              buildPhoneNumberFormField(),
              SizedBox(
                height: getProportionateScreenHeight(30),
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
                      text: "Update",
                      press: () async {
                        if (_formKey.currentState!.validate() &&
                            errors.length <= 0) {
                          _formKey.currentState!.save();
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            String result = await UserServices().saveUserInfo(
                                new AppUserInfo(
                                    firstName: firstName,
                                    lastName: lastName,
                                    phoneNumber: phoneNumber));
                            if (result == "Ok") {
                              Navigator.pop(context);
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      }),
            ],
          ),
        ));
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      readOnly: this.isLoading,
      onSaved: (newValue) => firstName = newValue!,
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
        if (value.isNotEmpty && errors.contains(kNamelNullError)) {
          setState(() {
            errors.remove(kNamelNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kNamelNullError)) {
          setState(() {
            errors.add(kNamelNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter Your First Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          icon: FontAwesomeIcons.user,
        ),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      readOnly: this.isLoading,
      onSaved: (newValue) => lastName = newValue!,
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
        if (value.isNotEmpty && errors.contains(kNamelNullError)) {
          setState(() {
            errors.remove(kNamelNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kNamelNullError)) {
          setState(() {
            errors.add(kNamelNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Fisrt Name",
        hintText: "Enter Your Last Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          icon: FontAwesomeIcons.user,
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      readOnly: this.isLoading,
      onSaved: (newValue) => phoneNumber = newValue!,
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
        if (value.isNotEmpty && errors.contains(kPhoneNumberNullError)) {
          setState(() {
            errors.remove(kPhoneNumberNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kPhoneNumberNullError)) {
          setState(() {
            errors.add(kPhoneNumberNullError);
          });
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter Your Phone Number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          icon: FontAwesomeIcons.phone,
        ),
      ),
    );
  }
}
