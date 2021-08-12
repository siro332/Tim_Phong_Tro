import 'package:tim_phong_tro/features/authenticate/data/models/user_model.dart';
import 'package:tim_phong_tro/models/my_shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<AppUserModel> getUser();
  Future<void> cacheUser(AppUserModel userToCache);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  @override
  Future<void> cacheUser(AppUserModel userToCache) async {
    await MysharedPreferences.instance.setStringValue('uid', userToCache.uid);
  }

  @override
  Future<AppUserModel> getUser() async {
    return AppUserModel(
        uid: await MysharedPreferences.instance.getStringValue('uid'));
  }
}
