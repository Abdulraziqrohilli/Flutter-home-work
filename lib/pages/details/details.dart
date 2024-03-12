import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:hurriyat/pages/details/samepost.dart';
import 'package:hurriyat/pages/home.dart';
import 'package:intl/intl.dart';
import 'package:hurriyat/models/details/details.dart' as m;
import 'package:dio/dio.dart' as dio;

import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/flutter_html.dart' as style;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hurriyat/models/details/Details.dart';
import 'package:hurriyat/models/details/details.dart' as m;
import 'package:hurriyat/models/details/detailsmodel.dart';
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
import 'package:skeletonizer/skeletonizer.dart';

class DetailsScreen extends StatefulWidget {
  final String id;
  DetailsScreen({required this.id});

  @override
  State<DetailsScreen> createState() => _apiDetailsScreenState();
}

class _apiDetailsScreenState extends State<DetailsScreen> {
  final f = new DateFormat('yyyy-MM-dd hh:mm');
  final db = DatabaseHelper();
  // var articalState = ArticleView();

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
  Future<m.Details> getdetails() async {
    try {
      dio.Dio _dio = dio.Dio();

      String url = 'https://hurriyat.net/api/news-details/${widget.id}';
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      dio.Options options = buildCacheOptions(const Duration(seconds: 3),
          forceRefresh: true, maxStale: Duration(days: 7));
      _dio.interceptors.add(dioCacheManager.interceptor);

      dio.Response response = await _dio.get(url, options: options);
      // DetailsModel newresponse = DetailsModel.fromJson(response.data);
      m.Details newresponse = m.Details.fromJson(response.data);
      return newresponse;
    } on dio.DioError catch (e) {
      print("this is the main error" + e.error);
      return null!;
    }
  }

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

  // Future<Userdetailsview> getuserpost() async {
  //   final response = await http
  //       .get(Uri.parse('https://faham.org/api/webPostDetails/' + widget.uuid));
  //   var data = jsonDecode(response.body.toString());
  //   if (response.statusCode == 200) {
  //     return Userdetailsview.fromJson(data);
  //   } else {
  //     return Userdetailsview.fromJson(data);
  //   }
  // }

  var clicked = true;

  int count = 1;

  var shareclick = true;

  var saveclick = false;

  int savecount = 1;

  int sharecount = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<m.Details>(
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
                  // Text("Please Wait..."),
                ],
              ),
            );
          }

          return SafeArea(
              child: Scaffold(
                  body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  centerTitle: true,

                  // elevation: 1,
                  // bottom: PreferredSizeWidget.sliverapp,
                  // backgroundColor:
                  //     Home.isclick == true ? Colors.white70 : Colors.black54,
                  expandedHeight: 250.0,
                  floating: true,

                  pinned: true,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Home.isclick == true ? Colors.black : Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    _loading
                        ? Center(child: Text(""))
                        : Container(
                            alignment: Alignment.center,
                            child: FutureBuilder<m.Details>(
                                future: getdetails(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Skeletonizer(
                                        child: Row(
                                      children: [
                                        Icon(Icons.save),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ));
                                    // hei
                                  }
                                  // final itemss = snapshot.data ?? <Detailss>[];
                                  return Row(
                                    // mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // snapshot.data!.languageId.toString() == '1'
                                    //     ? CrossAxisAlignment.start
                                    //     : CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      // onPressed: () {},

                                      // Row(
                                      //   children: [
                                      //     GestureDetector(
                                      //         onTap: () async {
                                      //           setState(() async {
                                      //             await Share.share("afsdfasd");
                                      //           });
                                      //         },
                                      //         child: Icon(
                                      //           Icons.share,
                                      //           size: 24,
                                      //         )),
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   width: 20,
                                      // ),

                                      Container(
                                        // margin: EdgeInsets.only(bottom: 2.0),
                                        // decoration: BoxDecoration(
                                        //   boxShadow: [
                                        //     BoxShadow(blurRadius: 10)
                                        //   ],
                                        // ),
                                        //   borderRadius:
                                        //       BorderRadius.circular(1),
                                        // ),
                                        // color: Home.isclick
                                        //     ? Colors.white70
                                        //     : Colors.black54,
                                        // height: 25,
                                        child: Row(
                                          children: [
                                            FutureBuilder<List<Detailss>>(
                                                future: news,
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<
                                                            List<Detailss>>
                                                        snapshott) {
                                                  if (snapshott
                                                          .connectionState !=
                                                      ConnectionState.waiting) {
                                                    final items =
                                                        snapshott.data ??
                                                            <Detailss>[];
                                                    int? id = snapshot.data!.id;
                                                    int i;
                                                    for (i = 0;
                                                        i < items.length;
                                                        i++) {
                                                      // items[i].newsId == id
                                                      //     ? isclicked = true
                                                      //     : isclicked = false;
                                                      // if (items[i].newsId == id) {
                                                      //   isclicked = true;
                                                      // }
                                                      isclicked =
                                                          items[i].newsId == id
                                                              ? true
                                                              : false;
                                                      // isclicked = true;
                                                      // for deleting the news form favorites

                                                      //  for storing the news into the favorits list
                                                      if (items[i].newsId ==
                                                          id) {
                                                        return LikeButton(
                                                          size: 22,
                                                          isLiked: isclicked,
                                                          onTap:
                                                              (isclicked) async {
                                                            this.isclicked =
                                                                !isclicked;
                                                            Future.delayed(
                                                                Duration(
                                                                    milliseconds:
                                                                        100),
                                                                () async {
                                                              if (isclicked ==
                                                                  true) {
                                                                db
                                                                    .deleteNote(items[
                                                                            i]
                                                                        .newsId
                                                                        .toString())
                                                                    .whenComplete(
                                                                        () {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                8)),
                                                                        backgroundColor: Colors
                                                                            .teal,
                                                                        behavior: SnackBarBehavior
                                                                            .floating,
                                                                        duration: const Duration(
                                                                            seconds:
                                                                                2),
                                                                        content:
                                                                            Row(
                                                                          children: [
                                                                            // items[index].usrImage == null
                                                                            //     ? Text("nopicture")
                                                                            //     : Text("we have picture"),
                                                                            Text(
                                                                              "News Has Been Removed!",
                                                                              style: const TextStyle(color: Colors.white),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                  );
                                                                });
                                                              } else if (isclicked ==
                                                                  false) {
                                                                var res =
                                                                    await db
                                                                        .createNote(
                                                                            Detailss(
                                                                              category: snapshot
                                                                      .data!
                                                                      .newsCategory
                                                                      .toString(),
                                                                  newsId: snapshot
                                                                          .data!
                                                                          .id
                                                                      as int,
                                                                  title: snapshot
                                                                      .data!
                                                                      .title
                                                                      .toString(),
                                                                  description: snapshot
                                                                      .data!
                                                                      .description
                                                                      .toString(),
                                                                  userId: 1,
                                                                  createdAt: snapshot
                                                                      .data!
                                                                      .createdAt
                                                                      .toString(),
                                                                  user: snapshot
                                                                      .data!
                                                                      .user
                                                                      .toString(),
                                                                  source: snapshot
                                                                      .data!
                                                                      .source
                                                                      .toString(),
                                                                  image: snapshot
                                                                      .data!
                                                                      .mainImage
                                                                      .toString(),
                                                                  languageId: snapshot
                                                                          .data!
                                                                          .languageId
                                                                      as int,
                                                                  views: snapshot
                                                                      .data!
                                                                      .views
                                                                      .toString(),
                                                                ))
                                                                        .whenComplete(
                                                                            () {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                8)),
                                                                        backgroundColor: Colors
                                                                            .teal,
                                                                        behavior: SnackBarBehavior
                                                                            .floating,
                                                                        duration: const Duration(
                                                                            seconds:
                                                                                2),
                                                                        content:
                                                                            Row(
                                                                          children: [
                                                                            // items[index].usrImage == null
                                                                            //     ? Text("nopicture")
                                                                            //     : Text("we have picture"),
                                                                            Text(
                                                                              "News Has Been Added!",
                                                                              style: const TextStyle(color: Colors.white),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                  );
                                                                });
                                                                if (res > 0) {
                                                                  if (!mounted) {
                                                                    print("News Has Been Added Successfully!" +
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
                                                          likeBuilder:
                                                              (isclicked) {
                                                            return Icon(
                                                              isclicked
                                                                  ? Icons
                                                                      .bookmark_add
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
                                                      snapshott.data ??
                                                          <Detailss>[];
                                                  int? id = snapshot.data!.id;
                                                  int i;
                                                  for (i = 0;
                                                      i < items.length;
                                                      i++) {
                                                    if (items[i].newsId != id ||
                                                        items[i].userId == 1) {
                                                      isclicked =
                                                          items[i].newsId == id
                                                              ? true
                                                              : false;
                                                      return LikeButton(
                                                        size: 22,
                                                        isLiked: isclicked,
                                                        onTap:
                                                            (isclicked) async {
                                                          this.isclicked =
                                                              !isclicked;
                                                          Future.delayed(
                                                              Duration(
                                                                  milliseconds:
                                                                      200), () {
                                                            setState(() async {
                                                              if (isclicked ==
                                                                  true) {
                                                                db
                                                                    .deleteNote(items[
                                                                            i]
                                                                        .newsId
                                                                        .toString())
                                                                    .whenComplete(
                                                                        () {
                                                                  // showAboutDialog(
                                                                  //     context: context,
                                                                  //     applicationName:
                                                                  //         "The Item has been Successfully Removed!");
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                8)),
                                                                        backgroundColor: Colors
                                                                            .teal,
                                                                        behavior: SnackBarBehavior
                                                                            .floating,
                                                                        duration: const Duration(
                                                                            seconds:
                                                                                2),
                                                                        content:
                                                                            Row(
                                                                          children: [
                                                                            // items[index].usrImage == null
                                                                            //     ? Text("nopicture")
                                                                            //     : Text("we have picture"),
                                                                            Text(
                                                                              "News Has Been Removed!",
                                                                              style: const TextStyle(color: Colors.white),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                  );
                                                                });
                                                              } else if (isclicked ==
                                                                  false) {
                                                                var res =
                                                                    await db
                                                                        .createNote(
                                                                            Detailss(
                                                                              category:snapshot
                                                                      .data!
                                                                      .newsCategory
                                                                      .toString() ,
                                                                  newsId: snapshot
                                                                          .data!
                                                                          .id
                                                                      as int,
                                                                  title: snapshot
                                                                      .data!
                                                                      .title
                                                                      .toString(),
                                                                  description: snapshot
                                                                      .data!
                                                                      .description
                                                                      .toString(),
                                                                  userId: 1,
                                                                  createdAt: snapshot
                                                                      .data!
                                                                      .createdAt
                                                                      .toString(),
                                                                  user: snapshot
                                                                      .data!
                                                                      .user
                                                                      .toString(),
                                                                  source: snapshot
                                                                      .data!
                                                                      .source
                                                                      .toString(),
                                                                  image: snapshot
                                                                      .data!
                                                                      .mainImage
                                                                      .toString(),
                                                                  languageId: snapshot
                                                                          .data!
                                                                          .languageId
                                                                      as int,
                                                                  views: snapshot
                                                                      .data!
                                                                      .views
                                                                      .toString(),
                                                                ))
                                                                        .whenComplete(
                                                                            () {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                8)),
                                                                        backgroundColor: Colors
                                                                            .teal,
                                                                        behavior: SnackBarBehavior
                                                                            .floating,
                                                                        duration: const Duration(
                                                                            seconds:
                                                                                2),
                                                                        content:
                                                                            Row(
                                                                          children: [
                                                                            // items[index].usrImage == null
                                                                            //     ? Text("nopicture")
                                                                            //     : Text("we have picture"),
                                                                            Text(
                                                                              "News Has Been Added!",
                                                                              style: const TextStyle(color: Colors.white),
                                                                            ),
                                                                          ],
                                                                        )),
                                                                  );
                                                                });
                                                                if (res > 0) {
                                                                  if (!mounted) {
                                                                    print("This is the problems" +
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
                                                        likeBuilder:
                                                            (isclicked) {
                                                          return Icon(
                                                            isclicked
                                                                ? Icons
                                                                    .bookmark_add
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
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  );
                                }),
                          ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    titlePadding: EdgeInsets.only(right: 34, left: 39),
                    expandedTitleScale: 1.4,
                    centerTitle: true,
                    stretchModes: [
                      StretchMode.blurBackground,
                      StretchMode.fadeTitle,
                      StretchMode.zoomBackground,
                    ],
                    title: Text(
                      snapshot.data!.title.toString(),
                      textAlign: snapshot.data!.languageId == 1
                          ? TextAlign.left
                          : TextAlign.right,
                      textDirection: snapshot.data!.languageId == 1
                          ? ui.TextDirection.ltr
                          : ui.TextDirection.rtl,
                      maxLines: 3,
                      style: TextStyle(
                        color: Home.isclick ? Colors.black : Colors.white,
                        // overflow: TextOverflow.ellipsis,
                        fontSize: snapshot.data!.languageId == 1 ? 16 : 18,
                        fontWeight: FontWeight.w600,
                        // shadows: [
                        //   Shadow(
                        //       color: Home.isclick == true
                        //           ? Colors.black
                        //           : Colors.white,
                        //       offset: Offset(-1, 2))
                        // ],
                        fontFamily: snapshot.data!.languageId.toString() == '1'
                            ? "Arial"
                            : "Bahij",
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          child: CachedNetworkImage(
                              // width: 350,

                              fit: BoxFit.fill,
                              // imageBuilder: (context, imageProvider) {
                              //   return CircleAvatar(
                              //     // radius: ,
                              //     child: Container(),
                              //     backgroundImage: imageProvider,
                              //   );
                              // },
                              imageUrl: snapshot.data!.mainImage.toString(),
                              placeholder: (context, url) => Center(
                                    child: Container(
                                        child: CircularProgressIndicator()),
                                  ),
                              errorWidget: (context, url, error) =>
                                  new Container(
                                      child: Image.asset(
                                          fit: BoxFit.fill,
                                          "assets/image/faham0.jpg"))
                                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Home.isclick
                                    ? Colors.white.withOpacity(0.8)
                                    : Colors.black.withOpacity(0.8)
                              ],
                              begin: Alignment.topCenter,
                              stops: [0.3, 1],
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top: 0, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: "Sigmar"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ];
            },
            body: SingleChildScrollView(
              child: Column(
                children: [
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
                          FittedBox(
                            child: Text(
                              f
                                  .format(DateTime.parse(
                                          snapshot.data!.createdAt.toString())
                                      as DateTime)
                                  .toString(),
                              maxLines: 1,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13
                                  // color: Colors.white,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 3,
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
                                snapshot.data!.languageId.toString() == '1'
                                    ? TextAlign.left
                                    : TextAlign.right,
                            textDirection:
                                snapshot.data!.languageId.toString() == '1'
                                    ? ui.TextDirection.ltr
                                    : ui.TextDirection.rtl,
                            snapshot.data!.source == null
                                ? snapshot.data!.languageId == 1
                                    ? "Hurriyat News"
                                    : "حوریت نېوز"
                                : snapshot.data!.source.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              fontFamily:
                                  snapshot.data!.languageId.toString() == '1'
                                      ? "Arial"
                                      : "Bahij",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 6,
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
                                snapshot.data!.languageId.toString() == '1'
                                    ? TextAlign.left
                                    : TextAlign.right,
                            textDirection:
                                snapshot.data!.languageId.toString() == '1'
                                    ? ui.TextDirection.ltr
                                    : ui.TextDirection.rtl,
                            snapshot.data!.views.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              fontFamily:
                                  snapshot.data!.languageId.toString() == '1'
                                      ? "Arial"
                                      : "Bahij",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.person_pin,
                            size: 19,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            textAlign:
                                snapshot.data!.languageId.toString() == '1'
                                    ? TextAlign.left
                                    : TextAlign.right,
                            textDirection:
                                snapshot.data!.languageId.toString() == '1'
                                    ? ui.TextDirection.ltr
                                    : ui.TextDirection.rtl,
                            snapshot.data!.user.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontFamily:
                                  snapshot.data!.languageId.toString() == '1'
                                      ? "Arial"
                                      : "Bahij",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  Html(
                    data: snapshot.data!.description.toString(),
                    style: {
                      "body": style.Style(
                        // alignment: Alignment.topLeft,
                        fontSize: FontSize(15.0),
                        // fontWeight: FontWeight.w300,
                        textAlign: snapshot.data!.languageId.toString() == '1'
                            ? TextAlign.left
                            : TextAlign.right,
                        direction: snapshot.data!.languageId.toString() == '1'
                            ? ui.TextDirection.ltr
                            : ui.TextDirection.rtl,
                        fontFamily: snapshot.data!.languageId.toString() == '1'
                            ? "Arial"
                            : "Bahij",
                      ),
                    },
                  ),
                  Divider(),
                  CategoryPageRow(
                      languageid: snapshot.data!.languageId as int,
                      name: snapshot.data!.newsCategory.toString()),
                  Divider(),
                ],
              ),
            ),
          )));
        },
      ),
    );
  }
}
