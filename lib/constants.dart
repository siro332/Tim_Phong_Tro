import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF4fc3f7);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xff56CCF2), Color(0xff2F80ED)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kWrongEmailPassword = "Wrong Email or Password";
const String kNetworkError = "Network error";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

const String kAccessToken = "access_token";
const String kSignedIn = "SignedIn";
const String BASE_URL = "https://tim-phong-tro.herokuapp.com";

//const String BASE_URL = "http://192.168.1.9:8080";

//User
const String jFirstName = 'firstName';
const String jLastName = 'lastName';
const String jPhoneNumber = 'phoneNumber';
const String jImage = 'image';
const String jDescription = 'description';
