import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hurriyat/models/gallery/Gallert_details.dart';
import 'dart:ui' as ui;

import 'package:hurriyat/pages/article_view.dart';
import 'package:hurriyat/pages/gallery/details.dart';
import 'package:hurriyat/pages/gallery/gallery_details.dart';
import 'package:hurriyat/pages/home.dart';

class GalleryWidget extends StatelessWidget {
  int? id;
  String? caption;
  String? location;
  int? languageID;
  String? createdAt;
  String? user;
  String? image;
  String? photographer;
  GalleryWidget({
    this.id,
    this.caption,
    this.location,
    this.languageID,
    this.createdAt,
    this.user,
    this.image,
    this.photographer,
  });

  double setSize(BuildContext context, double size) {
    return MediaQuery.of(context).size.width / size;
  }

  @override
  Widget build(BuildContext context) {
    var isportrate = MediaQuery.of(context).orientation == Orientation.portrait;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GalleryDetails(
                      caption: caption,
                      createdAt: createdAt,
                      id: id,
                      image: image,
                      languageID: languageID,
                      location: location,
                      photographer: photographer,
                      user: user,
                    )));
      },
      child: Container(
        // margin: EdgeInsets.only(bottom: 2.0),
        child: Container(
          padding: EdgeInsets.all(3),
          child: Material(
            elevation: 3.0,
            // color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: isportrate ? 5 : 7,
                      child: Stack(
                        children: [
                          Container(
                              // padding: EdgeInsets.all(5),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Hero(
                                    tag: "image",
                                    child: CachedNetworkImage(
                                      imageUrl: image.toString(),
                                      height: isportrate ? 230 : 260,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ))),
                          // Positioned(
                          //   left: languageID == 1 ? 10 : null,
                          //   right: languageID != 1 ? 10 : null,
                          //   top: 5,
                          //   child: Container(
                          //     padding: EdgeInsets.only(left: 3, right: 3),
                          //     decoration: BoxDecoration(
                          //         color: Home.isclick
                          //             ? Colors.white
                          //             : Colors.black,
                          //         borderRadius: BorderRadius.only(
                          //             bottomLeft: Radius.circular(10),
                          //             bottomRight: Radius.circular(10))),
                          //     child: Padding(
                          //       padding:
                          //           const EdgeInsets.only(left: 3, right: 3),
                          //       child: Text(
                          //         location.toString(),
                          //         maxLines: 1,
                          //         textAlign: languageID == 1
                          //             ? TextAlign.left
                          //             : TextAlign.right,
                          //         textDirection: languageID == 1
                          //             ? ui.TextDirection.ltr
                          //             : ui.TextDirection.rtl,
                          //         style: TextStyle(
                          //           // color: Colors.black,
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 16.0,
                          //           fontFamily:
                          //               languageID == 1 ? "Arial" : "Bahij",
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
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
