import '../models/const.dart';
import '../models/user_info_model.dart';
import '../../../../models/my_shared_preferences.dart';

abstract class UserInfoLocalDataSource {
  Future<AppUserInfoModel> getCurrentUserInfo();
  Future<void> cacheInfo(AppUserInfoModel infoToCache);
}

class UserInfoLocalDataSourceImpl implements UserInfoLocalDataSource {
  final sharedPref = MysharedPreferences.instance;
  @override
  Future<void> cacheInfo(AppUserInfoModel info) async {
    await sharedPref.setStringValue(jFirstName, info.firstName);
    await sharedPref.setStringValue(jLastName, info.lastName);
    await sharedPref.setStringValue(jDescription, info.description);
    await sharedPref.setStringValue(jImage, info.image);
    await sharedPref.setStringValue(jPhoneNumber, info.phoneNumber);

    await sharedPref.setBooleanValue('userInfoSaved', true);
  }

  @override
  Future<AppUserInfoModel> getCurrentUserInfo() async {
    return AppUserInfoModel(
        firstName: await sharedPref.getStringValue(jFirstName),
        lastName: await sharedPref.getStringValue(jLastName),
        phoneNumber: await sharedPref.getStringValue(jPhoneNumber),
        image: await sharedPref.getStringValue(jImage),
        description: await sharedPref.getStringValue(jDescription));
  }
}
