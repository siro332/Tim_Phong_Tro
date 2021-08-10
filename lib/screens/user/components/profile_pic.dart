import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tim_phong_tro/services/auth_services.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key? key,
    this.image = "",
  }) : super(key: key);
  final String image;

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
          child: AuthServices().currentUser == null ||
                  AuthServices().currentUser!.image != ""
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45.0),
                      color: Color(0xFFF5F6F9)),
                )
              : CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: AuthServices().currentUser!.image!,
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
        Positioned(
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
      ]),
    );
  }
}
