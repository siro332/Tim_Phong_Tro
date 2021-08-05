import 'package:shared_preferences/shared_preferences.dart';

class MysharedPreferences {
  MysharedPreferences._privateConstructor();
  static final MysharedPreferences instance =
      MysharedPreferences._privateConstructor();

  setBooleanValue(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    await myPrefs
        .setBool(key, value)
        .then((value) => print('Data saved: $value'));
  }

  Future<bool> getBooleanValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool(key) ?? false;
  }
}
