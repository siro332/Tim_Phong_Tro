import 'package:shared_preferences/shared_preferences.dart';

class MysharedPreferences {
  MysharedPreferences._privateConstructor();
  static final MysharedPreferences instance =
      MysharedPreferences._privateConstructor();

  setBooleanValue(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    await myPrefs.setBool(key, value);
    return value;
  }

  Future<bool> getBooleanValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool(key) ?? false;
  }

  setStringValue(String key, String value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    await myPrefs.setString(key, value);
    return value;
  }

  Future<String> getStringValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(key) ?? "";
  }

  removeStringValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    await myPrefs.remove(key);
  }

  clearData() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    await myPrefs.clear();
  }
}
