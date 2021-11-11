import 'package:flutter/material.dart';
import 'package:tim_phong_tro/components/default_button.dart';
import 'package:tim_phong_tro/components/default_outlined_button.dart';
import 'package:tim_phong_tro/constants.dart';

class RoomTypeFilter extends StatefulWidget {
  @override
  _RoomTypeFilterState createState() => _RoomTypeFilterState();
}

class _RoomTypeFilterState extends State<RoomTypeFilter> {
  String selectedType = "";

  List<FilterItem> items = [
    new FilterItem(name: "Dormitory", isSeleted: false),
    new FilterItem(name: "Room for rent", isSeleted: false),
    new FilterItem(name: "Room for share", isSeleted: false),
    new FilterItem(name: "House", isSeleted: false),
    new FilterItem(name: "Apartment", isSeleted: false),
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
                      for (var i in items) {
                        i.isSeleted = false;
                      }
                      setState(() {
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
                        selectedType = items[i].name;
                      }
                    }
                    Navigator.pop(context, selectedType);
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
  bool isSeleted;
  FilterItem({required this.name, required this.isSeleted});
}
