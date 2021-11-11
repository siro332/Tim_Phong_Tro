import 'package:flutter/material.dart';

import '../features/user_post/domain/entities/post_preview.dart';
import '../features/user_post/presentation/screens/detail.dart';

class PostPreviewEntityList extends StatefulWidget {
  PostPreviewEntityList({Key? key, required this.property}) : super(key: key);
  final UserPostPreview property;

  @override
  _PostPreviewEntityListState createState() => _PostPreviewEntityListState();
}

class _PostPreviewEntityListState extends State<PostPreviewEntityList> {
  @override
  Widget build(BuildContext context) {
    return buildProperty(widget.property);
  }

  Widget buildProperty(UserPostPreview property) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]},';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(id: property.id)),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 24),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Container(
          height: 210,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(property.thumbnailImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.yellow[700],
                //     borderRadius: BorderRadius.all(
                //       Radius.circular(5),
                //     ),
                //   ),
                //   width: 80,
                //   padding: EdgeInsets.symmetric(
                //     vertical: 4,
                //   ),
                //   child: Center(
                //     child: Text(
                //       "FOR " + property.label,
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 14,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Container(),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              property.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              property.roomInfo.address.ward.distric.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.zoom_out_map,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              property.roomInfo.area.toString() + " sqM",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     Icon(
                        //       Icons.star,
                        //       color: Colors.yellow[700],
                        //       size: 14,
                        //     ),
                        //     SizedBox(
                        //       width: 4,
                        //     ),
                        //     Text(
                        //       property.review + " Reviews",
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 14,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Container(
                          child: Text(
                            r"VNĐ " +
                                property.roomInfo.rentalPrice
                                    .toString()
                                    .replaceAllMapped(reg, mathFunc),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
