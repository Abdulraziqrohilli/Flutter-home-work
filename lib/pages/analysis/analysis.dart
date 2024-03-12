import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hurriyat/models/analysis/Analysis_details.dart';
import 'package:hurriyat/models/analysis/latest_analysis/Data.dart';
import 'package:hurriyat/models/analysis/latest_analysis/Latest_analsis.dart';
import 'package:hurriyat/pages/analysis/analysis_details.dart';
import 'package:hurriyat/pages/article_view.dart';
import 'package:hurriyat/pages/radioprogram/details.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

import 'package:hurriyat/pages/radioprogram/details1.dart';
import 'package:hurriyat/services/analysis/analysis.dart';
import 'package:hurriyat/services/analysis/latestanalysis.dart';
import 'package:hurriyat/services/radioprogram/latestradioPrograms.dart';
import 'package:hurriyat/services/radioprogram/latestradioprogramdio.dart';
import 'package:hurriyat/models/analysis/Data.dart' as ad;
import 'package:hurriyat/models/analysis/Analysis.dart' as am;
import 'package:hurriyat/services/radioprogram/radioprogramdata.dart';
import 'package:hurriyat/widgets/NoData.dart';
import 'package:hurriyat/widgets/blogtile.dart';
import 'package:hurriyat/widgets/skeleton.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio_http_cache/dio_http_cache.dart';

class AnalysisPage extends StatefulWidget {
  int languageid;
  String? name;
  AnalysisPage({required this.languageid, required this.name});

  @override
  State<AnalysisPage> createState() => _AllNewsState();
}

class _AllNewsState extends State<AnalysisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name!.tr.toString(),
          style: TextStyle(
              color: Color.fromARGB(255, 0, 130, 185),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body:
          // RefreshIndicator(
          //   displacement: 250,
          //   backgroundColor: Colors.white,
          //   color: Colors.red,
          //   strokeWidth: 3,
          //   triggerMode: RefreshIndicatorTriggerMode.onEdge,
          //   onRefresh: () async {
          //     await Future.delayed(Duration(seconds: 3));
          //     setState(() {
          //       // getallpost();
          //       // CircularProgressIndicator();
          //       _loading ? Center(child: CircularProgressIndicator()) : initState();
          //       // Center(
          //       //   child: Text("Please Wait"),
          //       // );
          //       //  _onrefresh();
          //     });
          //   },
          //   child: _loading
          //       ? Center(child: CircularProgressIndicator())
          //       :
          SafeArea(
        child: SingleChildScrollView(
          child: widget.name == "Analysis"
              ? FutureBuilder<List<ad.Data>?>(
                  future: AnalysisDio().getAnalyisDio(widget.languageid),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return SkeletonWidget();
                          });
                    }
                    if (snapshot.data!.length == 0) {
                      return NoDataAvailableWidget();
                    }

                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Analysis_Details(
                                        blogUrl:
                                            snapshot.data![index].id.toString(),
                                      )));
                            },
                            child: BlogTile(
                                created_at: snapshot.data![index].createdAt,
                                imageUrl:
                                    snapshot.data![index].image.toString(),
                                title: snapshot.data![index].title.toString(),
                                url: snapshot.data![index].id.toString(),
                                languageID: widget.languageid),
                          );
                          // RadioProgramSections(
                          //   languageID: widget.languageid,
                          //   Images: snapshot.data![index].image.toString(),
                          //   createdAt: snapshot.data![index].createdAt,
                          //   url: snapshot.data![index].id,
                          //   host: snapshot.data![index].content.toString(),
                          //   title: snapshot.data![index].title.toString(),
                          //   user: snapshot.data![index].user.toString(),
                          //   view: snapshot.data![index].views.toString(),
                          // );
                        });
                  })
              : FutureBuilder<List<Data>?>(
                  future: LatestAnalysisDio()
                      .getLatestAnalyisDio(widget.languageid),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return SkeletonWidget();
                          });
                    }
                    if (snapshot.data!.length == 0) {
                      return NoDataAvailableWidget();
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Analysis_Details(
                                        blogUrl:
                                            snapshot.data![index].id.toString(),
                                      )));
                            },
                            child: BlogTile(
                                created_at: "",
                                imageUrl:
                                    snapshot.data![index].image.toString(),
                                title: snapshot.data![index].title.toString(),
                                url: snapshot.data![index].id.toString(),
                                languageID: widget.languageid),
                          );
                        });
                  }),
        ),
      ),
    );
  }
}

class RadioProgramSection extends StatelessWidget {
  String Images, host, title, user;
  String view;
  int langugaeId;
  int? url;
  RadioProgramSection({
    required this.Images,
    required this.host,
    required this.title,
    required this.view,
    required this.user,
    required this.url,
    required this.langugaeId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Analysis_Details(blogUrl: url.toString())));
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          child: Column(
            children: [
              Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: Images,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                // Positioned(
                //     bottom: 88,
                //     left: 155,
                //     child: GestureDetector(
                //       onTap: () {
                //         Navigator.of(context).push(MaterialPageRoute(
                //             builder: (context) => RadioDetails(
                //                   url: url.toString(),
                //                 )));
                //       },
                //       child: CircleAvatar(
                //           radius: 18,
                //           backgroundColor: Colors.red,
                //           child: Icon(Icons.play_arrow)),
                //     ))
                // CircleAvatar(child: Image(image: AssetImage("assets/images/youtube11.jpg"))))
              ]),
              SizedBox(
                height: 7,
              ),
              Text(
                title,
                maxLines: 3,
                textAlign:
                    //  TextAlign.center,
                    url == 1 ? TextAlign.left : TextAlign.right,
                textDirection:
                    url == 1 ? ui.TextDirection.ltr : ui.TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  fontFamily: url == 1 ? "Arial" : "Bahij",
                ),
              ),
              // Row(
              //   // crossAxisAlignment:
              //   //     CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Text(
              //       textAlign: url.toString() == '1'
              //           ? TextAlign.left
              //           : TextAlign.right,
              //       textDirection: url.toString() == '1'
              //           ? ui.TextDirection.ltr
              //           : ui.TextDirection.rtl,
              //       view.toString(),
              //       style: TextStyle(
              //         fontWeight: FontWeight.w500,
              //         fontSize: 12,
              //         fontFamily: url.toString() == '1' ? "Arial" : "Bahij",
              //       ),
              //     ),
              //     SizedBox(
              //       width: 3,
              //     ),
              //     Icon(
              //       Icons.remove_red_eye,
              //       size: 19,
              //     ),
              //     SizedBox(
              //       width: 15,
              //     ),
              //     Text(
              //       textAlign: url.toString() == '1'
              //           ? TextAlign.left
              //           : TextAlign.right,
              //       textDirection: url.toString() == '1'
              //           ? ui.TextDirection.ltr
              //           : ui.TextDirection.rtl,
              //       user.toString(),
              //       style: TextStyle(
              //         fontWeight: FontWeight.w400,
              //         fontSize: 15,
              //         fontFamily: url.toString() == '1' ? "Arial" : "Bahij",
              //       ),
              //     ),
              //     SizedBox(
              //       width: 3,
              //     ),
              //     Icon(
              //       Icons.person,
              //       size: 19,
              //     ),
              //     SizedBox(
              //       width: 15,
              //     ),
              //     Text(
              //       textAlign: url.toString() == '1'
              //           ? TextAlign.left
              //           : TextAlign.right,
              //       textDirection: url.toString() == '1'
              //           ? ui.TextDirection.ltr
              //           : ui.TextDirection.rtl,
              //       host.toString(),
              //       style: TextStyle(
              //         fontWeight: FontWeight.w400,
              //         fontSize: 15,
              //         fontFamily: url.toString() == '1' ? "Arial" : "Bahij",
              //       ),
              //     ),
              //     SizedBox(
              //       width: 3,
              //     ),
              //     Icon(
              //       Icons.person_pin,
              //       size: 19,
              //     ),
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        view,
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
                          fontFamily: "Arial",
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.remove_red_eye,
                        size: 24,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        user,
                        maxLines: 1,
                        textAlign:
                            //  TextAlign.center,
                            url == 1 ? TextAlign.left : TextAlign.right,
                        textDirection: url == 1
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
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Container(
                        width: 120,
                        child: Text(
                          host,
                          maxLines: 3,
                          textAlign:
                              //  TextAlign.center,
                              url == 1 ? TextAlign.left : TextAlign.right,
                          textDirection: url == 1
                              ? ui.TextDirection.ltr
                              : ui.TextDirection.rtl,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            fontFamily: url == 1 ? "Arial" : "Bahij",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.person_pin,
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RadioProgramSections extends StatelessWidget {
  String Images, host, title, user;
  String view;
  int languageID;
  String? createdAt;
  int? url;
  RadioProgramSections({
    required this.Images,
    required this.host,
    required this.title,
    required this.view,
    required this.user,
    required this.languageID,
    required this.url,
    required this.createdAt,
  });
  final f = new DateFormat('yyyy-MM-dd hh:mm');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Analysis_Details(blogUrl: url.toString())));
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          child: Column(
            children: [
              Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: Images,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                //   Positioned(
                //       bottom: 88,
                //       left: 155,
                //       child: GestureDetector(
                //         onTap: () {
                //           Navigator.of(context).push(MaterialPageRoute(
                //               builder: (context) => RadioDetails(
                //                     url: url.toString(),
                //                   )));
                //         },
                //         child: CircleAvatar(
                //             radius: 18,
                //             backgroundColor: Colors.red,
                //             child: Icon(Icons.play_arrow)),
                //       ))
                //   // CircleAvatar(child: Image(image: AssetImage("assets/images/youtube11.jpg"))))
              ]),
              SizedBox(
                height: 7,
              ),
              Text(
                title,
                maxLines: 4,
                textAlign:
                    //  TextAlign.center,
                    url == 1 ? TextAlign.left : TextAlign.right,
                textDirection:
                    url == 1 ? ui.TextDirection.ltr : ui.TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  fontFamily: url == 1 ? "Arial" : "Bahij",
                ),
              ),
              Column(
                children: [
                  Column(
                    children: [
                      Text(
                        host,
                        maxLines: 3,
                        textAlign:
                            //  TextAlign.center,
                            url == 1 ? TextAlign.left : TextAlign.right,
                        textDirection: url == 1
                            ? ui.TextDirection.ltr
                            : ui.TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontFamily: url == 1 ? "Arial" : "Bahij",
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                .format(DateTime.parse(createdAt.toString())
                                    as DateTime)
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 13
                                // color: Colors.white,
                                ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   width: 45,
                      // ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        view,
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
                          fontFamily: "Arial",
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.remove_red_eye,
                        size: 24,
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   width: 20,
                  // ),
                  Row(
                    children: [
                      Text(
                        user,
                        maxLines: 2,
                        textAlign:
                            //  TextAlign.center,
                            url == 1 ? TextAlign.left : TextAlign.right,
                        textDirection: url == 1
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
            ],
          ),
        ),
      ),
    );
  }
}
