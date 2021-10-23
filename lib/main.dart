// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:tim_phong_tro/models/my_shared_preferences.dart';
// import 'package:tim_phong_tro/constants.dart';
// import 'package:tim_phong_tro/routes.dart';
// import 'package:tim_phong_tro/screens/home/home_screen.dart';
// import 'package:tim_phong_tro/screens/splash/splash_screen.dart';
//
// import 'features/authenticate/presentation/bloc/authentication_bloc.dart';
// import 'features/user_info/presentation/bloc/user_info_bloc.dart';
// import 'injection_container.dart' as sl;
//
// bool isSecondTimeOpen = false;
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await sl.init();
//   bool secondTime =
//       await MysharedPreferences.instance.getBooleanValue("secondTimeOpen");
//   isSecondTimeOpen = secondTime;
//   await Firebase.initializeApp();
//   final appDocumentDirectory = await getApplicationDocumentsDirectory();
//   Hive.init(appDocumentDirectory.path);
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   // This widget is the root of your application.
//   @override
//   State<StatefulWidget> createState() {
//     return MyAppState();
//   }
// }
//
// class MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => sl.sl<AuthenticationBloc>(),
//         ),
//         BlocProvider(
//           create: (context) => sl.sl<UserInfoBloc>(),
//         )
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: theme(),
//         initialRoute:
//             isSecondTimeOpen ? HomeScreen.routeName : SplashScreen.routeName,
//         routes: routes,
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     Hive.close();
//     super.dispose();
//   }
// }
//
// ThemeData theme() {
//   return ThemeData(
//       appBarTheme: AppBarTheme(
//           elevation: 0,
//           color: Colors.white,
//           brightness: Brightness.light,
//           iconTheme: IconThemeData(color: Colors.black),
//           textTheme: TextTheme(
//               headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18))),
//       inputDecorationTheme: inputDecorationTheme(),
//       scaffoldBackgroundColor: Colors.white,
//       primarySwatch: Colors.lightBlue,
//       primaryColor: kPrimaryColor,
//       fontFamily: GoogleFonts.nunito().fontFamily,
//       textTheme: TextTheme(
//           bodyText1: TextStyle(color: kTextColor),
//           bodyText2: TextStyle(color: kTextColor)));
// }
//
// InputDecorationTheme inputDecorationTheme() {
//   var outlineInputBorder = OutlineInputBorder(
//       borderRadius: BorderRadius.circular(30),
//       borderSide: BorderSide(color: kTextColor),
//       gapPadding: 10);
//   return InputDecorationTheme(
//     contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
//     enabledBorder: outlineInputBorder,
//     focusedBorder: outlineInputBorder,
//     border: outlineInputBorder,
//   );
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tim_phong_tro/screens/huy_ui/search.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Search(),
    );
  }
}
