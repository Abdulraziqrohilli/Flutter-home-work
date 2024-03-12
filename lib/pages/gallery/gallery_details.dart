import 'dart:convert';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hurriyat/models/details/Details.dart';
import 'package:hurriyat/models/gallery/Gallert_details.dart' as m;
import 'package:hurriyat/models/analysis/Analysis_details.dart';
import 'package:hurriyat/sqflite/complete.dart';
import 'package:hurriyat/sqflite/note_model.dart';
import 'package:hurriyat/utils/constants/config.dart';
import 'package:hurriyat/utils/provider/theme_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:hurriyat/database/database_helper.dart';
import 'package:like_button/like_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hurriyat/models/reportsmodels/latest_report.dart';

class Gallery_Details extends StatefulWidget {
  String? blogUrl;
  Gallery_Details({
    this.blogUrl,
  });
  _Analysis_DetailState? __articleViewState;
  @override
  // State<ArticleView> createState() => _ArticleViewState();
  _Analysis_DetailState createState() {
    __articleViewState = _Analysis_DetailState();
    return _Analysis_DetailState();
  }

  getState() => _Analysis_DetailState();
}

class _Analysis_DetailState extends State<Gallery_Details> {
  // SharedPreferences pref=SharedPreferences.
  final db = DatabaseHelper();
  // var articalState = ArticleView();
  final f = new DateFormat('yyyy-MM-dd hh:mm');

  // List<Data> details = [];
  bool _loading = true;

  // getDetails() async {
  //   Details detailsNews = Details();
  //   await detailsNews.getDetails(widget.blogUrl);
  //   details = detailsNews.detaills;
  //   setState(() {
  //     _loading = false;
  //   });
  // }
  // Map<String, dynamic>? newsDetails;
  // Future<m.Details> getdetails() async {
  //   // String url = " https://hurriyat.net/api/news-details/" + 100;

  //   final response = await http.get(
  //       Uri.parse('https://hurriyat.net/api/news-details/${widget.blogUrl}'));
  //   var data = jsonDecode(response.body.toString());

  //   if (response.statusCode == 200) {
  //     _loading = false;
  //     return m.Details.fromJson(data);
  //     // newsDetails = data;
  //   } else {
  //     return m.detailsFromJson(data);
  //   }
  // }
  Future<m.GallertDetails> getdetails() async {
    try {
      dio.Dio _dio = dio.Dio();

      String url = 'https://hurriyat.net/api/gallery-details/${widget.blogUrl}';
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      dio.Options options =
          buildCacheOptions(const Duration(hours: 12), forceRefresh: true);
      _dio.interceptors.add(dioCacheManager.interceptor);

      dio.Response response = await _dio.get(url, options: options);
      // DetailsModel newresponse = DetailsModel.fromJson(response.data);
      m.GallertDetails newresponse = m.GallertDetails.fromJson(response.data);
      return newresponse;
    } on dio.DioError catch (e) {
      print("this is the main error" + e.error);
      return null!;
    }
  }
//   Future<Data> getDetails(String postId) async {
//     String url = " https://hurriyat.net/api/news-details/" + widget.blogUrl;

//     String url1 =
//         "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=54145bc9681c42de9a6cc831aa90502b";
//     var response = await http.get(Uri.parse(url));

//     var jsonData = jsonDecode(response.body);

// // if(jsonData['status']=='ok'){
//     jsonData["data"].forEach((element) {
//       // if(element["urlToImage"]!=null && element['description']!=null){
//       Data articleModel = Data(
//         title: element["title"],
//         description: element["description"],
//         id: element["id"],
//         mainImage: element["main_image"],
//         newsCategory: element["new_category"],
//         newsType: element['news_type'],
//         user: element['user'],
//         source: element['source'],
//         caption: element['caption'],
//         languageId: element['language_id'],
//         createdAt: element["created_at"],
//         tags: element['tags'] != null ? element['tags'].cast<String>() : [],
//       );

//       // }
//     });
//     _loading = false;
//     return Data.fromJson(json);

// // }
//   }
  late DatabaseHelper handler;
  late Future<List<Detailss>> news;
  var items = <Detailss>[];
  int? selectedId;
  int number = -1;
  bool isclicked = false;
  bool isfavorite = false;

  Future<List<Detailss>> getList() async {
    return await handler.getCompletedNotes();
  }

  // SharedPreferences prep = SharedPreferences();
  // TotalUsers count;
  Future<int?> signlenewsId() async {
    int? count = await handler.newsId();
    setState(() => number = count!);
    return number;
  }

  // final SharedPreferences preff =
  //     SharedPreferences.getInstance() as SharedPreferences;
  int? setnewsIds;
  storenewsids(setnewsIds) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('newsid', setnewsIds);
  }

  int? getnewsIds;
  // = preff.getStringList("newsid");

  getnewsid() async {
    final pref = await SharedPreferences.getInstance();
    getnewsIds = pref.getInt('newsid');
  }

  removelanguageid() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove("languageid");
  }

  // List<Map<String, dynamic>>? newsIdss;
  // void sqfliteids() async {
  //   newsIdss = await handler.getAllIds();
  // }

  @override
  void initState() {
    // TODO: implement initState
    getnewsid();
    getdetails();

    handler = DatabaseHelper();
    news = handler.getCompletedNotes();
    handler.initDB().whenComplete(() async {
      setState(() {
        news = getList();
      });
    });
    _loading = false;

    total();
    // Future.delayed(Duration(seconds: 1), () {
    //   setState(() {
    //     // isclicked = true;
    //     // Navigator.of(context).pop(true);
    //   });
    // });
    super.initState();
  }
  // late DatabaseHelper handler;
  // late Future<List<Detailss>> news;
  // final db = DatabaseHelper();

  // int? selectedId;
  // int number = -1;

  // @override
  // void initState() {
  //   super.initState();

  // }
  final newsids = <Detailss>[];

  // TotalUsers count;
  Future<int?> total() async {
    int? count = await handler.totalUsers();
    setState(() => number = count!);
    return number;
  }

  //Method to get data from database

  //Method to refresh data on pulling the list
  Future<void> _onRefresh() async {
    setState(() {
      news = getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _loading
              ? Center(child: Text(""))
              : Container(
                  alignment: Alignment.center,
                  child: FutureBuilder<m.GallertDetails>(
                      future: getdetails(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            // heightFactor: 23,
                            child: Text(""),
                          );
                        }
                        // final itemss = snapshot.data ?? <Detailss>[];
                        return Row(
                          // mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // snapshot.data!.languageId.toString() == '1'
                          //     ? CrossAxisAlignment.start
                          //     : CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // onPressed: () {},

                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () async {
                                      setState(() async {
                                        await Share.share("afsdfasd");
                                      });
                                    },
                                    child: Icon(
                                      Icons.share,
                                      size: 24,
                                    )),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),

                            Row(
                              children: [
                                FutureBuilder<List<Detailss>>(
                                    future: news,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<Detailss>>
                                            snapshott) {
                                      if (snapshott.connectionState !=
                                          ConnectionState.waiting) {
                                        final items =
                                            snapshott.data ?? <Detailss>[];
                                        int? id = snapshot.data!.id as int?;
                                        int i;
                                        for (i = 0; i < items.length; i++) {
                                          // items[i].newsId == id
                                          //     ? isclicked = true
                                          //     : isclicked = false;
                                          // if (items[i].newsId == id) {
                                          //   isclicked = true;
                                          // }
                                          isclicked = items[i].newsId == id
                                              ? true
                                              : false;
                                          // isclicked = true;
                                          // for deleting the news form favorites

                                          //  for storing the news into the favorits list
                                          if (items[i].newsId == id) {
                                            return LikeButton(
                                              size: 22,
                                              isLiked: isclicked,
                                              onTap: (isclicked) async {
                                                this.isclicked = !isclicked;
                                                Future.delayed(
                                                    Duration(milliseconds: 100),
                                                    () async {
                                                  if (isclicked == true) {
                                                    db
                                                        .deleteNote(items[i]
                                                            .newsId
                                                            .toString())
                                                        .whenComplete(() {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            backgroundColor:
                                                                Colors.teal,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            duration:
                                                                const Duration(
                                                                    seconds: 2),
                                                            content: Row(
                                                              children: [
                                                                // items[index].usrImage == null
                                                                //     ? Text("nopicture")
                                                                //     : Text("we have picture"),
                                                                Text(
                                                                  "News Has Been Removed!",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            )),
                                                      );
                                                    });
                                                  } else if (isclicked ==
                                                      false) {
                                                    var res = await db
                                                        .createNote(Detailss(
                                                          category:"Null",

                                                      newsId: snapshot.data!.id
                                                          as int,
                                                      title: snapshot
                                                          .data!.caption
                                                          .toString(),
                                                      description: snapshot
                                                          .data!.location
                                                          .toString(),
                                                      userId: 1,
                                                      createdAt: snapshot
                                                          .data!.createdAt
                                                          .toString(),
                                                      user: snapshot.data!.user
                                                          .toString(),
                                                      source: snapshot
                                                          .data!.photographer
                                                          .toString(),
                                                      image: snapshot
                                                          .data!.image
                                                          .toString(),
                                                      languageId: snapshot.data!
                                                          .languageId as int,
                                                      views: snapshot.data!.id
                                                          .toString(),
                                                    ))
                                                        .whenComplete(() {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            backgroundColor:
                                                                Colors.teal,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            duration:
                                                                const Duration(
                                                                    seconds: 2),
                                                            content: Row(
                                                              children: [
                                                                // items[index].usrImage == null
                                                                //     ? Text("nopicture")
                                                                //     : Text("we have picture"),
                                                                Text(
                                                                  "News Has Been Added!",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            )),
                                                      );
                                                    });
                                                    if (res > 0) {
                                                      if (!mounted) {
                                                        print(
                                                            "News Has Been Added Successfully!" +
                                                                res.toString());
                                                      }
                                                      ;
                                                      // Navigator.push(context,
                                                      //     MaterialPageRoute(builder: (context) => const LoginScreen())

                                                      //     );
                                                    }
                                                  }
                                                });
                                                return !isclicked;
                                              },
                                              likeBuilder: (isclicked) {
                                                return Icon(
                                                  isclicked
                                                      ? Icons.bookmark_add
                                                      : Icons
                                                          .bookmark_add_outlined,
                                                  // color: isclicked
                                                  //     ? Colors.red
                                                  //     : Colors.black,
                                                  size: 24,
                                                );
                                              },
                                            );
                                          }
                                        }
                                      }
                                      final items =
                                          snapshott.data ?? <Detailss>[];
                                      int? id = snapshot.data!.id as int?;
                                      int i;
                                      for (i = 0; i < items.length; i++) {
                                        if (items[i].newsId != id ||
                                            items[i].userId == 1) {
                                          isclicked = items[i].newsId == id
                                              ? true
                                              : false;
                                          return LikeButton(
                                            size: 22,
                                            isLiked: isclicked,
                                            onTap: (isclicked) async {
                                              this.isclicked = !isclicked;
                                              Future.delayed(
                                                  Duration(milliseconds: 200),
                                                  () {
                                                setState(() async {
                                                  if (isclicked == true) {
                                                    db
                                                        .deleteNote(items[i]
                                                            .newsId
                                                            .toString())
                                                        .whenComplete(() {
                                                      // showAboutDialog(
                                                      //     context: context,
                                                      //     applicationName:
                                                      //         "The Item has been Successfully Removed!");
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            backgroundColor:
                                                                Colors.teal,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            duration:
                                                                const Duration(
                                                                    seconds: 2),
                                                            content: Row(
                                                              children: [
                                                                // items[index].usrImage == null
                                                                //     ? Text("nopicture")
                                                                //     : Text("we have picture"),
                                                                Text(
                                                                  "News Has Been Removed!",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            )),
                                                      );
                                                    });
                                                  } else if (isclicked ==
                                                      false) {
                                                    var res = await db
                                                        .createNote(Detailss(
                                                          category:"Null",

                                                      newsId: snapshot.data!.id
                                                          as int,
                                                      title: snapshot
                                                          .data!.caption
                                                          .toString(),
                                                      description: snapshot
                                                          .data!.location
                                                          .toString(),
                                                      userId: 1,
                                                      createdAt: snapshot
                                                          .data!.createdAt
                                                          .toString(),
                                                      user: snapshot.data!.user
                                                          .toString(),
                                                      source: snapshot
                                                          .data!.photographer
                                                          .toString(),
                                                      image: snapshot
                                                          .data!.image
                                                          .toString(),
                                                      languageId: snapshot.data!
                                                          .languageId as int,
                                                      views: snapshot.data!.id
                                                          .toString(),
                                                    ))
                                                        .whenComplete(() {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            backgroundColor:
                                                                Colors.teal,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            duration:
                                                                const Duration(
                                                                    seconds: 2),
                                                            content: Row(
                                                              children: [
                                                                // items[index].usrImage == null
                                                                //     ? Text("nopicture")
                                                                //     : Text("we have picture"),
                                                                Text(
                                                                  "News Has Been Added!",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            )),
                                                      );
                                                    });
                                                    if (res > 0) {
                                                      if (!mounted) {
                                                        print(
                                                            "This is the problems" +
                                                                res.toString());
                                                      }
                                                      ;
                                                      // Navigator.push(context,
                                                      //     MaterialPageRoute(builder: (context) => const LoginScreen())

                                                      //     );
                                                    }
                                                  }
                                                });
                                              });
                                              return !isclicked;
                                            },
                                            likeBuilder: (isclicked) {
                                              return Icon(
                                                isclicked
                                                    ? Icons.bookmark_add
                                                    : Icons
                                                        .bookmark_add_outlined,
                                                size: 24,
                                              );
                                            },
                                          );
                                        }
                                      }
                                      return Text("");
                                    }),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        );
                      }),
                ),
        ],
        // title: Text(
        //   "details",
        //   // newsDetails![],
        //   // details[widget.blogUrl].title.toString(),
        //   // style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        // ),
        // centerTitle: true,
        // elevation: 0.0,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                child: FutureBuilder<m.GallertDetails>(
                    future: getdetails(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          // heightFactor: 23,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 80,
                              ),
                              Container(child: CircularProgressIndicator()),
                              Text("Please Wait..."),
                            ],
                          ),
                        );
                      }
                      // Detailss d = items.firstWhere(
                      //     (element) => element.newsId == snapshot.data!.id);
                      // final itemss = snapshot.data ?? <Detailss>[];
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment:
                              snapshot.data!.languageId.toString() == '1'
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 1, top: 10, right: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    snapshot.data!.languageId.toString() == '1'
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.end,
                                children: [
                                  Text(
                                    textAlign:
                                        snapshot.data!.languageId.toString() ==
                                                '1'
                                            ? TextAlign.left
                                            : TextAlign.right,
                                    textDirection:
                                        snapshot.data!.languageId.toString() ==
                                                '1'
                                            ? ui.TextDirection.ltr
                                            : ui.TextDirection.rtl,
                                    snapshot.data!.location.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      fontFamily: snapshot.data!.languageId
                                                  .toString() ==
                                              '1'
                                          ? "Arial"
                                          : "Bahij",
                                    ),
                                  ),
                                  Text(":"),
                                  Icon(Icons.location_on),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 1, top: 5, right: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    snapshot.data!.languageId.toString() == '1'
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.end,
                                children: [
                                  Text(
                                    textAlign:
                                        snapshot.data!.languageId.toString() ==
                                                '1'
                                            ? TextAlign.left
                                            : TextAlign.right,
                                    textDirection:
                                        snapshot.data!.languageId.toString() ==
                                                '1'
                                            ? ui.TextDirection.ltr
                                            : ui.TextDirection.rtl,
                                    snapshot.data!.photographer.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      fontFamily: snapshot.data!.languageId
                                                  .toString() ==
                                              '1'
                                          ? "Arial"
                                          : "Bahij",
                                    ),
                                  ),
                                  Text(":"),
                                  Icon(Icons.photo_camera_front_outlined),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            CachedNetworkImage(
                              imageUrl: snapshot.data!.image.toString(),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: Config.screenHeight = 230,
                              placeholder: (context, url) => Center(
                                child: Container(
                                    child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) {
                                debugPrint(error.toString());
                                // debugPrint(
                                //     error.toString());
                                return Container(
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/general.jpg",
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: Config.screenHeight = 230,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            // Divider(
                            //   thickness: 1,
                            //   height: 5,
                            // ),

                            // Text(
                            //   textAlign:
                            //       snapshot.data!.languageId.toString() == '1'
                            //           ? TextAlign.left
                            //           : TextAlign.right,
                            //   textDirection:
                            //       snapshot.data!.languageId.toString() == '1'
                            //           ? ui.TextDirection.ltr
                            //           : ui.TextDirection.rtl,
                            //   snapshot.data!.description.toString(),
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.w500,
                            //     fontSize: 15,
                            //     fontFamily:
                            //         snapshot.data!.languageId.toString() ==
                            //                 '1'
                            //             ? "Arial"
                            //             : "Bahij",
                            //   ),
                            // ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                          .format(DateTime.parse(snapshot
                                              .data!.createdAt
                                              .toString()) as DateTime)
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13
                                          // color: Colors.white,
                                          ),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     Icon(
                                //       Icons.photo_camera_front_outlined,
                                //       size: 19,
                                //     ),
                                //     SizedBox(
                                //       width: 3,
                                //     ),
                                //     Text(
                                //       textAlign: snapshot.data!.languageId
                                //                   .toString() ==
                                //               '1'
                                //           ? TextAlign.left
                                //           : TextAlign.right,
                                //       textDirection: snapshot.data!.languageId
                                //                   .toString() ==
                                //               '1'
                                //           ? ui.TextDirection.ltr
                                //           : ui.TextDirection.rtl,
                                //       snapshot.data!.photographer == null
                                //           ? snapshot.data!.languageId == 1
                                //               ? "Hurriyat News"
                                //               : "حوریت نېوز"
                                //           : snapshot.data!.photographer
                                //               .toString(),
                                //       style: TextStyle(
                                //         fontWeight: FontWeight.w500,
                                //         fontSize: 12,
                                //         fontFamily: snapshot.data!.languageId
                                //                     .toString() ==
                                //                 '1'
                                //             ? "Arial"
                                //             : "Bahij",
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   children: [
                                //     Icon(
                                //       Icons.remove_red_eye,
                                //       size: 19,
                                //     ),
                                //     SizedBox(
                                //       width: 3,
                                //     ),
                                //     Text(
                                //       textAlign: snapshot.data!.languageId
                                //                   .toString() ==
                                //               '1'
                                //           ? TextAlign.left
                                //           : TextAlign.right,
                                //       textDirection: snapshot.data!.languageId
                                //                   .toString() ==
                                //               '1'
                                //           ? ui.TextDirection.ltr
                                //           : ui.TextDirection.rtl,
                                //       snapshot.data!.views.toString(),
                                //       style: TextStyle(
                                //         fontWeight: FontWeight.w500,
                                //         fontSize: 12,
                                //         fontFamily: snapshot.data!.languageId
                                //                     .toString() ==
                                //                 '1'
                                //             ? "Arial"
                                //             : "Bahij",
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      textAlign: snapshot.data!.languageId
                                                  .toString() ==
                                              '1'
                                          ? TextAlign.left
                                          : TextAlign.right,
                                      textDirection: snapshot.data!.languageId
                                                  .toString() ==
                                              '1'
                                          ? ui.TextDirection.ltr
                                          : ui.TextDirection.rtl,
                                      snapshot.data!.user.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        fontFamily: snapshot.data!.languageId
                                                    .toString() ==
                                                '1'
                                            ? "Arial"
                                            : "Bahij",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Icon(
                                      Icons.person_pin,
                                      size: 19,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Html(
                              data: snapshot.data!.caption.toString(),
                              style: {
                                "body": Style(
                                  // alignment: Alignment.topLeft,
                                  fontSize: FontSize(15.0),
                                  // fontWeight: FontWeight.w300,
                                  textAlign:
                                      snapshot.data!.languageId.toString() ==
                                              '1'
                                          ? TextAlign.left
                                          : TextAlign.right,
                                  direction:
                                      snapshot.data!.languageId.toString() ==
                                              '1'
                                          ? ui.TextDirection.ltr
                                          : ui.TextDirection.rtl,
                                  fontFamily:
                                      snapshot.data!.languageId.toString() ==
                                              '1'
                                          ? "Arial"
                                          : "Bahij",
                                ),
                              },
                            ),
                          ],
                        ),
                        // ),
                      );
                    }),
              ),
            ),
    );
  }
}
