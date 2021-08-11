import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomAppBar extends StatefulWidget {
  final List<BarItem> barItems;
  final Duration animationDuration;
  final Function onBarTap;
  const CustomBottomAppBar(
      {Key? key,
      required this.barItems,
      this.animationDuration = const Duration(milliseconds: 150),
      required this.onBarTap})
      : super(key: key);
  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar>
    with TickerProviderStateMixin {
  int selectedBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.only(
            bottom: 16.0, top: 16.0, left: 16.0, right: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildBarItems(),
        ),
      ),
    );
  }

  List<Widget> _buildBarItems() {
    List<Widget> _barItems = [];
    for (int i = 0; i < widget.barItems.length; i++) {
      BarItem item = widget.barItems[i];
      bool isSelected = selectedBarIndex == i ? true : false;
      _barItems.add(InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            selectedBarIndex = i;
            widget.onBarTap(selectedBarIndex);
          });
        },
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
              color: isSelected
                  ? item.color.withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          duration: widget.animationDuration,
          child: Row(
            children: [
              FaIcon(
                item.iconData,
                color: isSelected ? item.color : Colors.grey[600],
                size: 24.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              AnimatedSize(
                curve: Curves.easeInOut,
                duration: widget.animationDuration,
                vsync: this,
                child: Text(
                  isSelected ? item.text : "",
                  style: TextStyle(color: item.color, fontSize: 18.0),
                ),
              )
            ],
          ),
        ),
      ));
    }
    return _barItems;
  }
}

class BarItem {
  String text;
  IconData iconData;
  Color color;
  BarItem({required this.text, required this.iconData, required this.color});
}
