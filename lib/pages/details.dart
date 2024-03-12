import 'package:flutter/material.dart';
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
  final String? index;
  DetailsScreen({required this.index});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final M = new DateFormat(':mm');
  final H = new DateFormat('hh');
  final D = new DateFormat('dd');

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

      String url = 'https://hurriyat.net/api/news-details/${widget.index}';
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      dio.Options options = buildCacheOptions(const Duration(seconds: 3),
          forceRefresh: true, maxStale: Duration(days: 7));
      _dio.interceptors.add(dioCacheManager.interceptor);

      dio.Response response = await _dio.get(url, options: options);
      // DetailsModel newresponse = DetailsModel.fromJson(response.data);
      m.Details newrespons = m.Details.fromJson(response.data);
      return newrespons;
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
    return Scaffold(
      body: FutureBuilder<m.Details>(
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
            final newresponse = snapshot.data!;
            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.black,
                    expandedHeight: 300.0,
                    floating: true,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 5, bottom: 3),
                        child: Text(
                          newresponse.user.toString(),
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      background: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: double.infinity,
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
                                            "assets/image/faham0.jpg"))),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.8),
                                ],
                                begin: Alignment.topCenter,
                                stops: [0.6, 1],
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 30, bottom: 5),
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: CircleAvatar(
                                          radius: 31,
                                          backgroundColor: Colors.red,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(30),
                                            ),
                                            child: CachedNetworkImage(
                                                // width: 350,
                                                fit: BoxFit.cover,
                                                height: 60,
                                                width: 60,
                                                // fit: BoxFit.cover,
                                                // imageBuilder: (context, imageProvider) {
                                                //   return CircleAvatar(
                                                //     // radius: ,
                                                //     child: Container(),
                                                //     backgroundImage: imageProvider,
                                                //   );
                                                // },
                                                imageUrl: snapshot
                                                    .data!.mainImage
                                                    .toString(),
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child: Container(
                                                          child:
                                                              CircularProgressIndicator()),
                                                    ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    new Container(
                                                        child: Image.asset(
                                                            fit: BoxFit.fill,
                                                            "assets/image/faham0.jpg"))),
                                          ),
                                        ),
                                      ),
                                      Text(
                                          "${H.format(DateTime.parse(snapshot.data!.createdAt.toString()) as DateTime).toString()} hours ago",
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.9),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ];
              },
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                padding: EdgeInsets.all(8),
                child: ListView(
                  children: [
                    Text(
                      snapshot.data!.title.toString(),
                      textAlign: snapshot.data!.languageId == 1
                          ? TextAlign.left
                          : TextAlign.right,
                      textDirection: snapshot.data!.languageId == 1
                          ? ui.TextDirection.ltr
                          : ui.TextDirection.rtl,
                      // maxLines: 3,
                      style: TextStyle(
                        color: Home.isclick ? Colors.black : Colors.white,
                        // overflow: TextOverflow.ellipsis,
                        fontSize: snapshot.data!.languageId == 1 ? 16 : 20,
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
                    SizedBox(
                      height: 20,
                    ),
                    Html(
                      data: snapshot.data!.description.toString(),
                      style: {
                        "body": style.Style(
                          // alignment: Alignment.topLeft,
                          fontSize: FontSize(18.0),
                          // fontWeight: FontWeight.w300,
                          textAlign: snapshot.data!.languageId.toString() == '1'
                              ? TextAlign.left
                              : TextAlign.right,
                          direction: snapshot.data!.languageId.toString() == '1'
                              ? ui.TextDirection.ltr
                              : ui.TextDirection.rtl,
                          fontFamily:
                              snapshot.data!.languageId.toString() == '1'
                                  ? "Arial"
                                  : "Bahij",
                        ),
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Share this Post:",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xff4267B2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.facebook),
                                Text(
                                  "Facebook",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.facebook),
                                Text(
                                  "Twitter",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffFD1D1D),
                                  Color(0xffC13584),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.facebook),
                                Text(
                                  "Instagram",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Share this Post:",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.24,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, i) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => DetailsScreen(
                                  index: widget.index,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width * 0.36,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    newresponse.mainImage.toString(),

                                    // fit: BoxFit.cover,
                                  ),
                                  fit: BoxFit.cover,
                                  // onError: (context, url) => Center(
                                  //     child: Container(
                                  //         child: CircularProgressIndicator()),
                                  //   ),
                                  onError: (context, url) => new Container(
                                      child: Image.asset(
                                          fit: BoxFit.fill,
                                          "assets/image/faham0.jpg"))),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.9)
                                  ],
                                  begin: Alignment.topCenter,
                                  stops: [0.5, 1],
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Text(
                                    newresponse.title.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${H.format(DateTime.parse(snapshot.data!.createdAt.toString()) as DateTime).toString()} hours ago",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
