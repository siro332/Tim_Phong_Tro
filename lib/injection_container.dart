import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tim_phong_tro/core/network/network_info.dart';
import 'package:tim_phong_tro/features/authenticate/data/datasources/user_local_datasource.dart';
import 'package:tim_phong_tro/features/authenticate/data/datasources/user_remote_datasource.dart';
import 'package:tim_phong_tro/features/authenticate/data/repositories/user_repo_impl.dart';
import 'package:tim_phong_tro/features/authenticate/domain/repositories/user_repo.dart';
import 'package:tim_phong_tro/features/authenticate/domain/usecases/get/get_current_user.dart';
import 'package:tim_phong_tro/features/authenticate/domain/usecases/register/register.dart';
import 'package:tim_phong_tro/features/authenticate/domain/usecases/reset_password/reset_password.dart';
import 'package:tim_phong_tro/features/authenticate/domain/usecases/sign_in/sign_in_with_emaill_and_password.dart';
import 'package:tim_phong_tro/features/authenticate/domain/usecases/sign_in/sign_in_with_facebook.dart';
import 'package:tim_phong_tro/features/authenticate/domain/usecases/sign_in/sign_in_with_google.dart';
import 'package:tim_phong_tro/features/authenticate/domain/usecases/sign_out/sign_out.dart';
import 'package:tim_phong_tro/features/user_info/domain/usecases/get_user_info.dart';
import 'package:tim_phong_tro/features/user_info/domain/usecases/set_user_info.dart';
import 'package:tim_phong_tro/features/user_info/presentation/bloc/user_info_bloc.dart';
import 'package:tim_phong_tro/features/user_post/data/datasources/user_post_remote_datasource.dart';
import 'package:tim_phong_tro/features/user_post/data/repositories/user_post_repo_impl.dart';
import 'package:tim_phong_tro/features/user_post/domain/repositories/user_post_repository.dart';
import 'package:tim_phong_tro/features/user_post/domain/usecases/get_list_posts.dart';
import 'package:tim_phong_tro/features/user_post/domain/usecases/get_post_detail.dart';
import 'package:tim_phong_tro/features/user_post/domain/usecases/get_saved_post.dart';
import 'package:tim_phong_tro/features/user_post/domain/usecases/search_post.dart';
import 'package:tim_phong_tro/features/user_post/presentation/bloc/bloc/save_post_bloc.dart';
import 'package:tim_phong_tro/features/user_post/presentation/bloc/bloc/user_post_bloc.dart';

import 'features/authenticate/presentation/bloc/authentication_bloc.dart';
import 'features/user_info/data/datasources/user_info_local_datasource.dart';
import 'features/user_info/data/datasources/user_info_remote_datasource.dart';
import 'features/user_info/data/repositories/user_info_repo_impl.dart';
import 'features/user_info/domain/repositories/user_info_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Feature = Authentication
  //Bloc
  sl.registerFactory(() => AuthenticationBloc(
        register: sl(),
        signInWithEmailAndPassword: sl(),
        signInWithFacebook: sl(),
        signInWithGoogle: sl(),
        signOut: sl(),
        getCurrentUser: sl(),
        resetPassword: sl(),
      ));

  //Use cases
  sl.registerLazySingleton(() => SignInWithEmailAndPassword(sl()));
  sl.registerLazySingleton(() => SignInWithFacebook(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => Register(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => ResetPassword(sl()));

  //Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImplementation(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //Data Sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl());
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl());

  //!Feature = UserInfo
  //Bloc
  sl.registerFactory(() => UserInfoBloc(getUserInfo: sl(), setUserInfo: sl()));

  //Use cases
  sl.registerLazySingleton(() => GetUserInfo(sl()));
  sl.registerLazySingleton(() => SetUserInfo(sl()));

  //Repository
  sl.registerLazySingleton<UserInfoRepository>(() =>
      UserInfoRepositoryImplementation(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  //Data Sources
  sl.registerLazySingleton<UserInfoRemoteDataSource>(
      () => UserInfoRemoteDataSourceImpl());
  sl.registerLazySingleton<UserInfoLocalDataSource>(
      () => UserInfoLocalDataSourceImpl());

  //!Feature = UserPost
  //Bloc
  sl.registerFactory(() => UserPostBloc(
      getListPost: sl(), getPostDetail: sl(), searchUserPosts: sl()));
  sl.registerFactory(() => SavePostBloc(getSavedPosts: sl()));
  //Use cases
  sl.registerLazySingleton(() => GetListUserPosts(sl()));
  sl.registerLazySingleton(() => GetPostDetail(sl()));
  sl.registerLazySingleton(() => SearchUserPosts(sl()));
  sl.registerLazySingleton(() => GetSavedPosts(sl()));
  //Repository
  sl.registerLazySingleton<UserPostRepository>(() =>
      UserPostRepositoryImplementation(
          remoteDataSource: sl(), networkInfo: sl()));
  //DataSource
  sl.registerLazySingleton<UserPostRemoteDataSource>(
      () => UserPostRemoteDataSourceImpl());

  //!Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
}
