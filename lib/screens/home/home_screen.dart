import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tim_phong_tro/features/authenticate/presentation/bloc/authentication_bloc.dart';
import 'package:tim_phong_tro/features/user_post/presentation/screens/general_screen/general.dart';
import 'package:tim_phong_tro/features/user_post/presentation/screens/save_screen/save.dart';
import '../../components/custom_appbar.dart';
import '../../constants.dart';
import '../user/user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> listWidgets = [
    General(),
    SaveScreen(),
    Scaffold(
      body: Center(
        child: Text("Message"),
      ),
    ),
    UserScreen()
  ];
  List<BarItem> listBarItems = [
    BarItem(
        text: "General", iconData: FontAwesomeIcons.city, color: kPrimaryColor),
    BarItem(
        text: "Save", iconData: FontAwesomeIcons.heart, color: kPrimaryColor),
    BarItem(
        text: "Inbox",
        iconData: FontAwesomeIcons.commentDots,
        color: kPrimaryColor),
    BarItem(text: "User", iconData: FontAwesomeIcons.user, color: kPrimaryColor)
  ];
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(CurrentUser());
    return Scaffold(
        body: IndexedStack(index: selectedIndex, children: listWidgets),
        bottomNavigationBar: CustomBottomAppBar(
            barItems: listBarItems,
            onBarTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            }));
  }

  Widget getBody(index) {
    return listWidgets[index];
  }
}
