import 'package:flutter/material.dart';

class General extends StatefulWidget {
  const General({Key? key}) : super(key: key);

  @override
  _GeneralState createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Text("Home"));
  }
}
