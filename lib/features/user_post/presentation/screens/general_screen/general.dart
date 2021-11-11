import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tim_phong_tro/features/user_post/presentation/screens/search_screen/search.dart';

import '../../../../../constants.dart';
import 'body.dart';

class General extends StatefulWidget {
  const General({Key? key}) : super(key: key);

  @override
  _GeneralState createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75.0,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, SearchScreen.routeName),
            child: Container(
              height: 60.0,
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.search,
                      color: kPrimaryColor,
                    ),
                    hintText: 'Find a good home',
                    hintStyle: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(child: Body()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        child: FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ),
    );
  }
}
