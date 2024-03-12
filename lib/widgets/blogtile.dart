import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import 'package:hurriyat/pages/article_view.dart';
import 'package:hurriyat/pages/details.dart';
import 'package:hurriyat/pages/home.dart';
import 'package:hurriyat/utils/constants/config.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BlogTile extends StatelessWidget {
  String title, imageUrl;
  String? category;
  String? created_at;
  String? url;
  int? languageID;
  BlogTile({
    required this.imageUrl,
    this.created_at,
    this.category,
    required this.title,
    required this.url,
    required this.languageID,
  });

  double setSize(BuildContext context, double size) {
    return MediaQuery.of(context).size.width / size;
  }

  @override
  Widget build(BuildContext context) {
    final f = new DateFormat('MMM dd,yyyy');

    var isportrate = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      // margin: EdgeInsets.only(bottom: 2.0),
      child: Container(
        padding: EdgeInsets.only(left: 8, bottom: 10, top: 5, right: 5),
        child: Material(
          // elevation: 1.0,
          // color: Colors.white,
          // borderRadius: BorderRadius.circular(10),
          child: languageID == 1
              ? Row(
                  crossAxisAlignment: languageID == 1
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.center,
                  mainAxisAlignment: isportrate
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(
                    //   width: 5.0,
                    // ),
                    // Text("data"),
                    Flexible(
                      flex: isportrate ? 3 : 6,
                      child: Container(
                        constraints:
                            BoxConstraints(minHeight: 105, maxHeight: 105),
                        width: MediaQuery.of(context).size.width / 1.7,
                        // height: isportrate
                        //     ? MediaQuery.of(context).size.height / 6
                        //     : MediaQuery.of(context).size.height / 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: Home.isclick
                                  ? Colors.black.withOpacity(0.1)
                                  : Colors.white.withOpacity(0.1),
                              padding: EdgeInsets.only(left: 3, right: 3),
                              child: Text(
                                category.toString().tr ?? 'null',
                                maxLines: 1,
                                textAlign: languageID == 1
                                    ? TextAlign.left
                                    : TextAlign.right,
                                textDirection: languageID == 1
                                    ? ui.TextDirection.ltr
                                    : ui.TextDirection.rtl,
                                style: TextStyle(
                                  // height: 1.5,
                                  overflow: TextOverflow.ellipsis,

                                  // color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.0,
                                  fontFamily: languageID == 1
                                      ? "Arial"
                                      : languageID == 4
                                          ? "Al-Emarah"
                                          : "Bahij",
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: languageID == 1
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      title,
                                      maxLines: 3,
                                      textAlign: languageID == 1
                                          ? TextAlign.left
                                          : TextAlign.right,
                                      textDirection: languageID == 1
                                          ? ui.TextDirection.ltr
                                          : ui.TextDirection.rtl,
                                      style: TextStyle(
                                        // height: 1.5,
                                        overflow: TextOverflow.ellipsis,

                                        // color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        fontFamily: languageID == 1
                                            ? "Arial"
                                            : languageID == 4
                                                ? "Al-Emarah"
                                                : "Bahij",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            created_at!.isEmpty
                                ? Text("")
                                : Text(
                                  created_at.toString()

                                    // f
                                    //         .format(DateTime.parse(
                                    //                 created_at.toString()
                                    //                 )
                                    //             as DateTime)
                                    //         .toString() 
                                            ??
                                        'null',
                                    maxLines: 1,
                                    textAlign: languageID == 1
                                        ? TextAlign.left
                                        : TextAlign.right,
                                    textDirection: languageID == 1
                                        ? ui.TextDirection.ltr
                                        : ui.TextDirection.rtl,
                                    style: TextStyle(
                                      // height: 1.5,
                                      overflow: TextOverflow.ellipsis,

                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      fontFamily: languageID == 1
                                          ? "Arial"
                                          : languageID == 4
                                              ? "Al-Emarah"
                                              : "Bahij",
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Flexible(
                      flex: isportrate ? 2 : 4,
                      child: Container(
                          constraints:
                              BoxConstraints(minHeight: 105, maxHeight: 105),
                          padding: EdgeInsets.all(3),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            height: isportrate ? 100 : 160,
                            width: double.maxFinite,
                            fit: BoxFit.fill,
                            // height: Config.screenHeight = height,
                            placeholder: (context, url) => Skeletonizer(
                                // enabled: true,
                                child: Container(
                              width: double.infinity,
                              height: 105,
                              child: Image.asset(
                                "assets/logos/logo@2x.png",
                                fit: BoxFit.cover,
                              ),
                            )),
                            errorWidget: (context, url, error) {
                              debugPrint(error.toString());

                              return Container(
                                width: double.infinity,
                                height: 105,
                                child: Image.asset("assets/logos/logo@2x.png",
                                    fit: BoxFit.cover),
                              );
                            },
                            //  Center(
                            //   child:
                            //       Container(child: CircularProgressIndicator()),
                            // ),
                          )),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: languageID == 1
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.center,
                  mainAxisAlignment: isportrate
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(
                    //   width: 5.0,
                    // ),
                    // Text("data"),

                    Flexible(
                      flex: isportrate ? 2 : 4,
                      child: Container(
                          constraints:
                              BoxConstraints(minHeight: 105, maxHeight: 105),
                          padding: EdgeInsets.all(3),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            height: isportrate ? 100 : 160,
                            width: double.maxFinite,
                            fit: BoxFit.fill,
                            // height: Config.screenHeight = height,
                            placeholder: (context, url) => Skeletonizer(
                                // enabled: true,
                                child: Container(
                              width: double.infinity,
                              height: 105,
                              child: Image.asset(
                                "assets/logos/logo@2x.png",
                                fit: BoxFit.cover,
                              ),
                            )),
                            errorWidget: (context, url, error) {
                              debugPrint(error.toString());

                              return Container(
                                width: double.infinity,
                                height: 105,
                                child: Image.asset("assets/logos/logo@2x.png",
                                    fit: BoxFit.cover),
                              );
                            },
                            //  Center(
                            //   child:
                            //       Container(child: CircularProgressIndicator()),
                            // ),
                          )),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Flexible(
                      flex: isportrate ? 3 : 6,
                      child: Container(
                        constraints:
                            BoxConstraints(minHeight: 105, maxHeight: 105),
                        width: MediaQuery.of(context).size.width / 1.7,
                        // height: isportrate
                        //     ? MediaQuery.of(context).size.height / 6
                        //     : MediaQuery.of(context).size.height / 4,
                        child: Column(
                          crossAxisAlignment: languageID == 1
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: Home.isclick
                                  ? Colors.black.withOpacity(0.1)
                                  : Colors.white.withOpacity(0.1),
                              padding: EdgeInsets.only(left: 3, right: 3),
                              child: Text(
                                category.toString().tr ?? 'null',
                                maxLines: 1,
                                textAlign: languageID == 1
                                    ? TextAlign.left
                                    : TextAlign.right,
                                textDirection: languageID == 1
                                    ? ui.TextDirection.ltr
                                    : ui.TextDirection.rtl,
                                style: TextStyle(
                                  // height: 1.5,
                                  overflow: TextOverflow.ellipsis,

                                  // color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.0,
                                  fontFamily: languageID == 1
                                      ? "Arial"
                                      : languageID == 4
                                          ? "Al-Emarah"
                                          : "Bahij",
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: languageID == 1
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      title,
                                      maxLines: 3,
                                      textAlign: languageID == 1
                                          ? TextAlign.left
                                          : TextAlign.right,
                                      textDirection: languageID == 1
                                          ? ui.TextDirection.ltr
                                          : ui.TextDirection.rtl,
                                      style: TextStyle(
                                        // height: 1.5,
                                        overflow: TextOverflow.ellipsis,

                                        // color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        fontFamily: languageID == 1
                                            ? "Arial"
                                            : languageID == 4
                                                ? "Al-Emarah"
                                                : "Bahij",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            created_at!.isEmpty
                                ? Text('')
                                : Text(
                                  created_at.toString(),
                                    // f
                                    //     .format(DateTime.parse(
                                    //         created_at.toString()) as DateTime)
                                    //     .toString(),
                                    maxLines: 1,
                                    textAlign: languageID == 1
                                        ? TextAlign.left
                                        : TextAlign.right,
                                    textDirection: languageID == 1
                                        ? ui.TextDirection.ltr
                                        : ui.TextDirection.rtl,
                                    style: TextStyle(
                                      // height: 1.5,
                                      overflow: TextOverflow.ellipsis,

                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      fontFamily: languageID == 1
                                          ? "Arial"
                                          : languageID == 4
                                              ? "Al-Emarah"
                                              : "Bahij",
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
