import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tim_phong_tro/components/custom_suffix_icon.dart';
import 'package:tim_phong_tro/components/default_button.dart';
import 'package:tim_phong_tro/components/form_error.dart';
import 'package:tim_phong_tro/components/profile_pic.dart';
import 'package:tim_phong_tro/features/user_info/data/models/arguments/user_info_arguments.dart';
import 'package:tim_phong_tro/features/user_info/domain/entities/user_info.dart';
import 'package:tim_phong_tro/features/user_info/presentation/bloc/user_info_bloc.dart';

import '../../../../../constants.dart';
import '../../../../../size_config.dart';

class EditUserProfile extends StatelessWidget {
  static String routeName = "/edit-user-profile";
  const EditUserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as UserInfoArguments;
    final uid = args.uid;
    final info = args.userInfo;
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          ProfilePic(image: info.image, isEdit: true, uid: uid),
        ],
      ),
    );
  }
}

class EditUserInfoForm extends StatefulWidget {
  const EditUserInfoForm({Key? key}) : super(key: key);

  @override
  _EditUserInfoFormState createState() => _EditUserInfoFormState();
}

class _EditUserInfoFormState extends State<EditUserInfoForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firebaseError = "";
  bool isShowPass = false;

  String firstName = "";

  String lastName = "";

  String phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserInfoBloc, UserInfoState>(
      listener: (context, state) {
        if (state is HaveData &&
            firstName != "" &&
            lastName != "" &&
            phoneNumber != "") {
          Navigator.pop(context);
        } else if (state is Error) {
          errors.add(firebaseError = state.message);
        }
      },
      child: BlocBuilder<UserInfoBloc, UserInfoState>(
        builder: (context, state) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildFirstNameFormField(state),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    buildLastNameFormField(state),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    buildPhoneNumberFormField(state),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    FormError(errors: errors),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    (state is InfoLoading)
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
                                BlocProvider.of<UserInfoBloc>(context).add(
                                    SetUserInfoEvent(
                                        userInfo: new AppUserInfo(
                                            description: "",
                                            firstName: firstName,
                                            lastName: lastName,
                                            image: "",
                                            phoneNumber: phoneNumber)));
                              }
                            }),
                  ],
                ),
              ));
        },
      ),
    );
  }

  TextFormField buildFirstNameFormField(UserInfoState state) {
    return TextFormField(
      readOnly: (state is InfoLoading),
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

  TextFormField buildLastNameFormField(UserInfoState state) {
    return TextFormField(
      readOnly: (state is InfoLoading),
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

  TextFormField buildPhoneNumberFormField(UserInfoState state) {
    return TextFormField(
      readOnly: (state is InfoLoading),
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
