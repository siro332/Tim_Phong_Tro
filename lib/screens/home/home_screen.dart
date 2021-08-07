import 'package:flutter/material.dart';
import 'package:tim_phong_tro/screens/home/components/general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tim_phong_tro/screens/user/user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> listWidget = [General(), UserScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home), label: "General"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user), label: "User")
        ],
        onTap: (int index) {
          this.onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody(index) {
    return listWidget[index];
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
}
