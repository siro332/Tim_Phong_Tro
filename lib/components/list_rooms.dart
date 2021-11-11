import 'package:flutter/material.dart';
import '../features/user_post/domain/entities/post_preview.dart';

class ListRooms extends StatefulWidget {
  ListRooms({Key? key, required this.properties}) : super(key: key);
  final List<UserPostPreview> properties;

  @override
  _ListRoomsState createState() => _ListRoomsState();
}

class _ListRoomsState extends State<ListRooms> {
  @override
  Widget build(BuildContext context) {
    return SliverList(delegate: new SliverChildListDelegate(buildProperties()));
  }

  List<Widget> buildProperties() {
    List<Widget> list = [];
    for (var i = 0; i < widget.properties.length; i++) {
      list.add(Hero(
          tag: widget.properties[i].thumbnailImage,
          child: buildProperty(widget.properties[i], i)));
    }
    return list;
  }

  Widget buildProperty(UserPostPreview property, int index) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => Detail(id: property.id)),
      //   );
      // },
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
                        Text(
                          property.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          r"$" + property.roomInfo.rentalPrice.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
                              property.roomInfo.area.toString() + " m2",
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
