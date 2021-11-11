import 'package:flutter/material.dart';
import 'package:tim_phong_tro/components/default_button.dart';
import 'package:tim_phong_tro/components/default_outlined_button.dart';
import 'package:tim_phong_tro/constants.dart';

class SortByFilter extends StatefulWidget {
  @override
  _SortByFilterState createState() => _SortByFilterState();
}

class _SortByFilterState extends State<SortByFilter> {
  String selectedValue = "";

  List<FilterItem> items = [
    new FilterItem(name: "A to Z", value: "name;0", isSeleted: false),
    new FilterItem(
        name: "Newest Fisrt", value: "postingDate;1", isSeleted: false),
    new FilterItem(
        name: "Oldest Fisrt", value: "postingDate;0", isSeleted: false),
    new FilterItem(
        name: "Price Low to High",
        value: "roomInfo.rentalPrice;0",
        isSeleted: false),
    new FilterItem(
        name: "Price High to Low",
        value: "roomInfo.rentalPrice;1",
        isSeleted: false),
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
          Column(
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
                    for (int i = 0; i < items.length; i++) {
                      if (items[i].isSeleted == true) {
                        selectedValue = items[i].value;
                      }
                    }
                    Navigator.pop(context, selectedValue);
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
        height: 45,
        width: double.infinity,
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
  String value;
  bool isSeleted;
  FilterItem(
      {required this.name, required this.value, required this.isSeleted});
}
