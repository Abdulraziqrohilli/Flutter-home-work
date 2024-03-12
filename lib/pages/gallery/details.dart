import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:ui' as ui;

import 'package:intl/intl.dart';

class GalleryDetails extends StatelessWidget {
  int? id;
  String? caption;
  String? location;
  int? languageID;
  String? createdAt;
  String? user;
  String? image;
  String? photographer;

  GalleryDetails({
    this.id,
    this.caption,
    this.location,
    this.languageID,
    this.createdAt,
    this.user,
    this.image,
    this.photographer,
  });
  final f = new DateFormat('MMMM dd, yyyy - hh:mm');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(5),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(
                        tag: "image",
                        transitionOnUserGestures: true,
                        child: CachedNetworkImage(
                          imageUrl: image.toString(),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ))),
              Container(
                child: Row(
                  crossAxisAlignment: languageID == 1
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Container(
                          child: Text(
                            f
                                .format(DateTime.parse(createdAt.toString())
                                    as DateTime)
                                .toString(),
                            // minago.toString(),
                            // timeago.format(minago,
                            //     locale: "en",
                            //     allowFromNow: true),
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.grey,
                              fontFamily: languageID == 1
                                  ? "Arial"
                                  : languageID == 4
                                      ? "Al-Emarah"
                                      : "Bahij",
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.av_timer_sharp,
                          size: 24,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          user.toString(),
                          maxLines: 1,
                          textAlign:
                              //  TextAlign.center,
                              languageID == 1
                                  ? TextAlign.left
                                  : TextAlign.right,
                          textDirection: languageID == 1
                              ? ui.TextDirection.ltr
                              : ui.TextDirection.rtl,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: "Arial",
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.person,
                          size: 24,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: languageID == 1
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  Text(
                    photographer.toString(),
                    // maxLines: 1,
                    // textAlign:
                    //     //  TextAlign.center,
                    //     url == 1 ? TextAlign.left : TextAlign.right,
                    // textDirection: url == 1
                    //     ? ui.TextDirection.ltr
                    //     : ui.TextDirection.rtl,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: languageID == 1
                          ? "Arial"
                          : languageID == 4
                              ? "Al-Emarah"
                              : "Bahij",
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.photo_camera_front,
                    size: 24,
                  ),
                ],
              ),
              Text(caption.toString(),
                  maxLines: 1,
                  textAlign: languageID == 1 ? TextAlign.left : TextAlign.right,
                  textDirection: languageID == 1
                      ? ui.TextDirection.ltr
                      : ui.TextDirection.rtl,
                  style: TextStyle(
                    // color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    fontFamily: languageID == 1
                        ? "Arial"
                        : languageID == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
