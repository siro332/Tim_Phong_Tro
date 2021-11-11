import 'package:flutter/material.dart';
import 'package:tim_phong_tro/components/default_button.dart';
import 'package:tim_phong_tro/components/default_outlined_button.dart';
import 'package:tim_phong_tro/constants.dart';

class PriceFilter extends StatefulWidget {
  @override
  _PriceFilterState createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  var selectedRange = RangeValues(500000, 10000000);
  String start = "VND 500k";
  String end = "VND 10M";
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
                "Price",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "range",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
          RangeSlider(
            values: selectedRange,
            onChanged: (RangeValues newRange) {
              setState(() {
                if (selectedRange.start < 1000000) {
                  start =
                      r"VND " + (selectedRange.start ~/ 1000).toString() + "k";
                } else {
                  start = r"VND " +
                      (double.parse((selectedRange.start / 1000000)
                              .toStringAsFixed(2)))
                          .toString() +
                      "M";
                }
                if (selectedRange.end < 1000000) {
                  end = r"VND " + (selectedRange.end ~/ 1000).toString() + "k";
                } else {
                  end = r"VND " +
                      (double.parse(
                              (selectedRange.end / 1000000).toStringAsFixed(2)))
                          .toString() +
                      "M";
                }
                selectedRange = newRange;
              });
            },
            min: 500000,
            max: 10000000,
            activeColor: kPrimaryColor,
            inactiveColor: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                start,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                end,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
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
                    Navigator.pop(context, selectedRange);
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  Widget buildOption(String text, bool selected) {
    return Container(
      height: 45,
      width: 65,
      decoration: BoxDecoration(
          color: selected ? Colors.blue[900] : Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
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
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
