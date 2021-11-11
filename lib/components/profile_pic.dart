import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic(
      {Key? key, required this.isEdit, required this.image, required this.uid})
      : super(key: key);
  final bool isEdit;
  final String image;
  final String uid;
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(fit: StackFit.expand, clipBehavior: Clip.none, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(45.0),
          child: widget.image == ""
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45.0),
                      color: Color(0xFFF5F6F9)),
                )
              : CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.image,
                  placeholder: (context, url) => new Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45.0),
                        color: Color(0xFFF5F6F9)),
                  ),
                  errorWidget: (context, url, error) => new Container(
                    color: Color(0xFFF5F6F9),
                  ),
                ),
        ),
        widget.isEdit
            ? Positioned(
                right: -12,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                    child: FaIcon(FontAwesomeIcons.camera),
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: Colors.white))),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFF5F6F9)),
                    ),
                  ),
                ),
              )
            : Container(),
      ]),
    );
  }
}
