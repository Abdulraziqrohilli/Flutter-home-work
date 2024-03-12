import 'dart:convert';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hurriyat/models/details/Details.dart';
import 'package:hurriyat/models/details/details.dart' as m;
import 'package:hurriyat/sqflite/complete.dart';
import 'package:hurriyat/sqflite/note_model.dart';
import 'package:hurriyat/utils/constants/config.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;
import 'package:hurriyat/database/database_helper.dart';

class Sqflitedetails extends StatefulWidget {
  String? title, descrition, imageUrl, username, source, views, createAt;
  int? newsId, languageId;
  Sqflitedetails(
      {required this.newsId,
      required this.title,
      required this.descrition,
      required this.imageUrl,
      required this.username,
      required this.createAt,
      required this.languageId,
      required this.source,
      required this.views});

  @override
  State<Sqflitedetails> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<Sqflitedetails> {
  final db = DatabaseHelper();

  final f = new DateFormat('yyyy-MM-dd hh:mm');

  // List<Data> details = [];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getdetails();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.languageId == 1 ? "Hurriyat News" : "حوریت نېوز",
          style: TextStyle(fontWeight: FontWeight.bold),
          // newsDetails![],
          // details[widget.blogUrl].title.toString(),
          // style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Container(
                width: Config.setSize(context, 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5, top: 10, right: 10),
                      child: Text(
                        textAlign: widget.languageId.toString() == '1'
                            ? TextAlign.left
                            : TextAlign.right,
                        textDirection: widget.languageId.toString() == '1'
                            ? ui.TextDirection.ltr
                            : ui.TextDirection.rtl,
                        widget.title.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          fontFamily: widget.languageId.toString() == '1'
                              ? "Arial"
                              : "Bahij",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: CachedNetworkImage(
                        imageUrl: widget.imageUrl.toString(),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: Config.screenHeight = 230,
                        placeholder: (context, url) => Center(
                          child: Container(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) {
                          // debugPrint(error.toString());
                          // debugPrint(
                          //     error.toString());
                          return Image.asset(
                            "assets/logos/logo@2x.png",
                            fit: BoxFit.cover,
                            width: 200,
                            height: Config.screenHeight = 230,
                          );
                        },
                      ),
                    ),
                    // Divider(
                    //   thickness: 1,
                    //   height: 5,
                    // ),

                    Column(
                      crossAxisAlignment: widget.languageId.toString() == '1'
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        // Container(
                        //     width: Config.setSize(context, 0.1),
                        //     child: Column(
                        //         crossAxisAlignment:
                        //             widget.languageId.toString() == '1'
                        //                 ? CrossAxisAlignment.start
                        //                 : CrossAxisAlignment.end,
                        //         children: [
                        //           Padding(
                        //             padding: const EdgeInsets.only(
                        //                 left: 1, top: 3, right: 1),
                        //             child: Text(
                        //               textAlign:
                        //                   widget.languageId.toString() == '1'
                        //                       ? TextAlign.left
                        //                       : TextAlign.right,
                        //               textDirection:
                        //                   widget.languageId.toString() == '1'
                        //                       ? ui.TextDirection.ltr
                        //                       : ui.TextDirection.rtl,
                        //               widget.title.toString(),
                        //               style: TextStyle(
                        //                 fontWeight: FontWeight.bold,
                        //                 fontSize: 11,
                        //                 fontFamily:
                        //                     widget.languageId.toString() == '1'
                        //                         ? "Arial"
                        //                         : "Bahij",
                        //               ),
                        //             ),
                        //           )
                        //         ])),
                        Padding(
                          padding: const EdgeInsets.only(left: 3, right: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.history_toggle_off_rounded,
                                    size: 19,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    f
                                        .format(DateTime.parse(
                                                widget.createAt.toString())
                                            as DateTime)
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 13
                                        // color: Colors.white,
                                        ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.source_sharp,
                                    size: 19,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    textAlign:
                                        widget.languageId.toString() == '1'
                                            ? TextAlign.left
                                            : TextAlign.right,
                                    textDirection:
                                        widget.languageId.toString() == '1'
                                            ? ui.TextDirection.ltr
                                            : ui.TextDirection.rtl,
                                    widget.source == 'null'
                                        ? widget.languageId == 1
                                            ? "Hurriyat News"
                                            : "حوریت نېوز"
                                        : widget.source.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      fontFamily:
                                          widget.languageId.toString() == '1'
                                              ? "Arial"
                                              : "Bahij",
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.remove_red_eye,
                                    size: 19,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    textAlign:
                                        widget.languageId.toString() == '1'
                                            ? TextAlign.left
                                            : TextAlign.right,
                                    textDirection:
                                        widget.languageId.toString() == '1'
                                            ? ui.TextDirection.ltr
                                            : ui.TextDirection.rtl,
                                    widget.views.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      fontFamily:
                                          widget.languageId.toString() == '1'
                                              ? "Arial"
                                              : "Bahij",
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.person_pin,
                                    size: 19,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    widget.username.toString(),
                                    textAlign:
                                        widget.languageId.toString() == '1'
                                            ? TextAlign.left
                                            : TextAlign.right,
                                    textDirection:
                                        widget.languageId.toString() == '1'
                                            ? ui.TextDirection.ltr
                                            : ui.TextDirection.rtl,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      fontFamily:
                                          widget.languageId.toString() == '1'
                                              ? "Arial"
                                              : "Bahij",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Row(
                        //   mainAxisSize: MainAxisSize.max,
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   crossAxisAlignment:
                        //       widget.languageId.toString() == '1'
                        //           ? CrossAxisAlignment.start
                        //           : CrossAxisAlignment.end,
                        //   children: [
                        //     FittedBox(
                        //       child: Row(
                        //         children: [
                        //           Icon(Icons.calendar_month_outlined),
                        //           SizedBox(
                        //             width: 3,
                        //           ),
                        //           Text(
                        //             f
                        //                 .format(DateTime.parse(
                        //                         widget.createAt.toString())
                        //                     as DateTime)
                        //                 .toString(),
                        //             style: TextStyle(
                        //                 // fontWeight: FontWeight.bold
                        //                 // color: Colors.white,
                        //                 ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     Row(
                        //       children: [
                        //         Icon(Icons.remove_red_eye_outlined),
                        //         SizedBox(
                        //           width: 3,
                        //         ),
                        //         Text(
                        //           textAlign: widget.languageId.toString() == '1'
                        //               ? TextAlign.left
                        //               : TextAlign.right,
                        //           textDirection:
                        //               widget.languageId.toString() == '1'
                        //                   ? ui.TextDirection.ltr
                        //                   : ui.TextDirection.rtl,
                        //           widget.views.toString(),
                        //           style: TextStyle(
                        //             // fontWeight: FontWeight.bold,
                        //             fontSize: 16,
                        //             fontFamily:
                        //                 widget.languageId.toString() == '1'
                        //                     ? "Arial"
                        //                     : "Bahij",
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     Row(
                        //       children: [
                        //         Icon(Icons.person),
                        //         SizedBox(
                        //           width: 3,
                        //         ),
                        //         Text(
                        //           textAlign: widget.languageId.toString() == '1'
                        //               ? TextAlign.left
                        //               : TextAlign.right,
                        //           textDirection:
                        //               widget.languageId.toString() == '1'
                        //                   ? ui.TextDirection.ltr
                        //                   : ui.TextDirection.rtl,
                        //           widget.username.toString(),
                        //           style: TextStyle(
                        //             // fontWeight: FontWeight.w500,
                        //             fontSize: 16,
                        //             fontFamily:
                        //                 widget.languageId.toString() == '1'
                        //                     ? "Arial"
                        //                     : "Bahij",
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      height: 1,
                    ),
                    // Text("title"),
                    Html(
                      data: widget.descrition.toString(),
                      style: {
                        "body": Style(
                          // alignment: Alignment.topLeft,
                          fontSize: FontSize(15.0),
                          // fontWeight: FontWeight.w300,
                          textAlign: widget.languageId.toString() == '1'
                              ? TextAlign.left
                              : TextAlign.right,
                          direction: widget.languageId.toString() == '1'
                              ? ui.TextDirection.ltr
                              : ui.TextDirection.rtl,
                          fontFamily: widget.languageId.toString() == '1'
                              ? "Arial"
                              : "Bahij",
                        ),
                      },
                    ),
                  ],
                ),
              ),
            ),
    );

// this place

    //       }),
    // ))

    // );
  }
}
