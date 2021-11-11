import 'package:flutter/material.dart';
import 'package:tim_phong_tro/components/default_button.dart';
import 'package:tim_phong_tro/components/default_outlined_button.dart';
import 'package:tim_phong_tro/constants.dart';

class CapacityFilter extends StatefulWidget {
  @override
  _CapacityFilterState createState() => _CapacityFilterState();
}

class _CapacityFilterState extends State<CapacityFilter> {
  int capacity = 0;

  List<FilterItem> items = [
    new FilterItem(name: "1", value: 1, isSeleted: false),
    new FilterItem(name: "2", value: 2, isSeleted: false),
    new FilterItem(name: "3", value: 3, isSeleted: false),
    new FilterItem(name: "4+", value: 4, isSeleted: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 24, left: 24, top: 32, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Select",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "room type",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i in items)
                GestureDetector(
                    onTap: () {
                      setState(() {
                        for (var i in items) {
                          i.isSeleted = false;
                        }
                        i.isSeleted = !i.isSeleted;
                      });
                    },
                    child: buildOption(i.name, i.isSeleted)),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150.0,
                height: 50.0,
                child: DefaultOutlinedButton(
                  text: "Cancel",
                  press: () => Navigator.pop(context),
                ),
              ),
              SizedBox(
                width: 150.0,
                height: 50.0,
                child: DefaultButton(
                  text: "OK",
                  press: () {
                    for (var i in items) {
                      if (i.isSeleted) capacity = i.value;
                    }
                    Navigator.pop(context, capacity);
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildOption(String text, bool selected) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
      child: Container(
        height: 55,
        width: 65,
        decoration: BoxDecoration(
            color: selected ? kPrimaryColor : Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            border: Border.all(
              width: selected ? 0 : 1,
              color: Colors.grey,
            )),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class FilterItem {
  String name;
  int value;
  bool isSeleted;
  FilterItem(
      {required this.name, required this.value, required this.isSeleted});
}
