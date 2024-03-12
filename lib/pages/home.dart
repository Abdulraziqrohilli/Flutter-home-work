import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hurriyat/pages/Reports/allResports.dart';
import 'package:hurriyat/pages/about_us.dart';
import 'package:hurriyat/pages/analysis/allanalysis.dart';
import 'package:hurriyat/pages/documents/document_analysis.dart';
import 'package:hurriyat/pages/live/livepage.dart';
import 'package:hurriyat/pages/radio_program/videospage.dart';
import 'package:hurriyat/pages/radioprogram/radioprogram.dart';
import 'package:hurriyat/utils/constants/config.dart';
import 'package:hurriyat/utils/utils.dart';
import 'package:hurriyat/widgets/category.dart';
import 'package:hurriyat/widgets/internetconnection.dart';
import 'package:hurriyat/widgets/skeleton.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:get/get_navigation/src/routes/get_transition_mixin.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:get/utils.dart';
import 'package:flutter_html/flutter_html.dart' as style;
import 'package:flutter_html/flutter_html.dart';
// import 'package:http/http.dart';
import 'package:hurriyat/database/database_helper.dart';
import 'package:hurriyat/localstring.dart';
import 'package:hurriyat/models/Slider.dart';
import 'package:hurriyat/models/artical.dart';
import 'dart:ui' as ui;
import 'package:hurriyat/models/article_model.dart';
import 'package:hurriyat/models/category_model.dart';
import 'package:hurriyat/models/slider_model.dart';
import 'package:hurriyat/pages/Reports/ReportsPage.dart';
import 'package:hurriyat/pages/Search.dart';
import 'package:hurriyat/pages/Videos/videospage.dart';
import 'package:hurriyat/pages/all_news.dart';
import 'package:hurriyat/pages/analysis/analysis.dart';
import 'package:hurriyat/pages/article_view.dart';
import 'package:hurriyat/pages/category_news.dart';
import 'package:hurriyat/pages/documents/documents.dart';
import 'package:hurriyat/pages/gallery/Gallery_page.dart';
import 'package:hurriyat/pages/pagenition.dart';
import 'package:hurriyat/pages/radioprogram/2latest.dart';
import 'package:hurriyat/pages/radioprogram/latest_radio_programs.dart';
import 'package:hurriyat/pages/radioprogram/radioprogramspage.dart';
import 'package:hurriyat/pages/search/filter_network_list_page.dart';
import 'package:hurriyat/pages/searchi.dart';
import 'package:hurriyat/sqflite/complete.dart';
import 'package:hurriyat/sqflite/note_model.dart';
import 'package:hurriyat/utils/provider/theme_provider.dart';
import 'package:hurriyat/widgets/blogtile.dart';
import 'package:hurriyat/widgets/textsow.dart';
import 'package:provider/provider.dart';
import 'package:hurriyat/services/data.dart';
import 'package:hurriyat/services/language_data.dart';
import 'package:hurriyat/services/news.dart';
import 'package:hurriyat/services/slider_data.dart';
import 'package:hurriyat/utils/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  // const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
  static bool isclick = true;
}

enum FilterOptions {
  Favorites,
  All,
}

class _HomeState extends State<Home> {
  // sqflite offilen data
  // late DatabaseHelper handler;
  // late Future<List<Detailss>> news;
  // final db = DatabaseHelper();

  // int? selectedId;
  // int number = -1;

  @override

  // TotalUsers count;
  // Future<int?> total() async {
  //   int? count = await handler.totalUsers();
  //   setState(() => number = count!);
  //   return number;
  // }

  // //Method to get data from database
  // Future<List<Detailss>> getList() async {
  //   return await handler.getCompletedNotes();
  // }

  // //Method to refresh data on pulling the list
  // Future<void> _onRefresh() async {
  //   setState(() {
  //     news = getList();
  //   });
  // }

  // offile data sqflite
  var locale;
  bool isdrawer = false;

  var languageids;
  // bool? islocal;
  // storelocal(islocal) async {
  //   final pref = await SharedPreferences.getInstance();
  //   await pref.setString('islocal', islocal);
  // }

  getlocal() async {
    final pref = await SharedPreferences.getInstance();
    locale = pref.getString('islocal');
  }

  removelocal() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove("islocal");
  }

  storelanguageid(languageid) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('languageid', languageid);
  }

  getlanguageid() async {
    final pref = await SharedPreferences.getInstance();
    languageids = pref.getInt('languageid')!;
  }

  removelanguageid() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove("languageid");
  }

  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  // List<ArticleModel> articles = [];
  bool _loading = true, loading2 = true;
  int activeIndex = 0;

  // storecolor(int color) async {
  //   final pref = await SharedPreferences.getInstance();
  //   await pref.setInt('color', color);
  // }

  // int? color;
  // getcolor() async {
  //   final pref = await SharedPreferences.getInstance();
  //   color = pref.getInt('color');
  // }

  // removecolor() async {
  //   final pref = await SharedPreferences.getInstance();
  //   pref.remove("color");
  // }

  final scrolcontroller = ScrollController();
  late DioCacheManager dioCacheManager;
  late DioCacheManager latestdioCacheManager;
  Future<List<ArticleModel>> getNews(int languageid) async {
    try {
      dio.Dio _dio = dio.Dio();

      String url = "https://hurriyat.net/api/news/$languageid";
      latestdioCacheManager = DioCacheManager(CacheConfig());
      dio.Options options = buildCacheOptions(const Duration(milliseconds: 100),
          forceRefresh: true, maxStale: const Duration(days: 7));
      _dio.interceptors.add(dioCacheManager.interceptor);

      dio.Response response = await _dio.get(url, options: options);
      ArticalNews newresponse = ArticalNews.fromJson(response.data);
      return newresponse.data;
    } on dio.DioError catch (e) {
      print("this is the main error" + e.error);
      // ignore: null_check_always_fails
      return null!;
    }
  }

  // late Connectivity _connectivity;
  // late ConnectivityResult _connectivityResult;
  @override
  void initState() {
    // getlanguageid();
    _onrefresh();
    super.initState();
    // _connectivity = Connectivity();
    // // Subscribe to connection changes
    // _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    //   setState(() {
    //     _connectivityResult = result;
    //   });
    //   // Show overlay notification when connectivity changes
    //   showConnectivityOverlay(result);
    // });
    // // Get initial connection status
    // _initConnectivity();
  }

  // getNews(int languageId) async {
  //   News newsclass = News();
  //   await newsclass.getNews(languageId);
  //   // articles = newsclass.news;
  //   setState(() {
  //     // _loading = false;
  //   });
  // }
  Future<List<SliderModel>> getSlider(int languageid) async {
    try {
      dio.Dio _dio = dio.Dio();

      String url = "https://hurriyat.net/api/latest-news/$languageid";
      dioCacheManager = DioCacheManager(CacheConfig());
      dio.Options options = buildCacheOptions(const Duration(milliseconds: 100),
          forceRefresh: false, maxStale: Duration(days: 7));
      _dio.interceptors.add(dioCacheManager.interceptor);

      dio.Response response = await _dio.get(url, options: options);
      SliderNews newresponse = SliderNews.fromJson(response.data);
      // if(response.co)
      return newresponse.data;
    } on dio.DioError catch (e) {
      print("this is the main error" + e.error);
      // ignore: null_check_always_fails
      return null!;
    }
  }
  // getSlider(int languageId) async {
  //   Sliders slider = Sliders();
  //   await slider.getSlider(languageId);
  //   sliders = slider.sliders;
  //   setState(() {
  //     // loading2 = false;
  //   });
  // }

  Future<void> _onrefresh() async {
    rightoleft = true;
    rightoleft2 = true;
    rightoleft3 = true;
    rightoleft4 = true;
    rightoleft5 = true;
    rightoleft6 = true;
    rightoleft7 = true;
    rightoleft8 = true;
    // showconnectivity();

    getlanguageid();
    getlocal();

    // Future.delayed(Duration(seconds: 2), () {
    //   CircularProgressIndicator();
    // });

    Future.delayed(Duration(milliseconds: 100), () {
      if (languageids != null || languageids != 1) {
        setState(() {
          isdrawer = true;
        });
        if (languageids == 2) {
          setState(() {
            // rightoleft = true;

            // locale = "US";
            // removelocal();
            // storelocal(false);
            Get.updateLocale(Locale('pa', 'AF'));
            categories = getCategories();
            // getSlider(2);
            // getNews(2);
            // storelanguageid(2);

            // Navigator.of(context).pop();
            // storelanguage("AF");
            // Get.reset();
            // storelanguageid(2);
            // _onrefresh();
            // // locale = "AF";
            // locale = Locale('pa', 'AF');
            // Get.updateLocale(locale);
          });
        }
        if (languageids == 3) {
          setState(() {
            // rightoleft = true;

            // locale = "US";
            // removelocal();
            // locale = "AF";
            Get.updateLocale(Locale('dr', 'AF'));
            categories = getCategories();
            // getSlider(3);
            // getNews(3);
          });
        }
        if (languageids == 4) {
          setState(() {
            // removelocal();
            // rightoleft = true;

            // isdrawer = true;
            // locale = "AF";
            Get.updateLocale(Locale('arr', 'ARR'));
            storelanguageid(4);

            // storelanguageid(false);
            categories = getCategories();
            // getSlider(4);
            // getNews(4);
          });
        }
      }
      if (languageids == null || languageids == 1) {
        setState(() {
          isdrawer = false;
          rightoleft = true;
          // _loading = false;
          // loading2 = false;

          // locale = "US";
          // removelocal();
          storelanguageid(1);
          // storelanguageid(true);

          Get.updateLocale(Locale('en', 'US'));
          categories = getCategories();
        });
      }
    });
    setState(() {
      getSlider(languageids ?? 1);
      getNews(languageids ?? 1);
    });
    // _loading = false;
    loading2 = true;
    _loading = true;
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        loading2 = false;
        _loading = false;
      });
    });
    // initState();
  }

  bool rightoleft = true;
  bool rightoleft2 = true;
  bool rightoleft3 = true;
  bool rightoleft4 = true;
  bool rightoleft5 = true;
  bool rightoleft6 = true;
  bool rightoleft7 = true;
  bool rightoleft8 = true;
  Drawer _drawer() {
    return Drawer(
      width: 225,
      child: ListView(
        children: [
          Container(
            // padding:
            //     EdgeInsets.only(top: MediaQuery.of(context).padding.top - 15),
            width: 100,
            height: 120,
            child: Image.asset(
              "assets/logos/logo@2x.png",
              // fit: BoxFit.cover,
              // height: 100,
              // width: 20,
            ),
          ),
          Divider(),

          ExpansionTile(
            // backgroundColor: Colors.blue,
            // collapsedIconColor: Colors.blue,
            textColor: Colors.blue,
            // collapsedTextColor: Colors.blue,
            iconColor: Colors.blue,
            title: Text("Video News".tr,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: languageids == 1
                      ? "Arial"
                      : languageids == 4
                          ? "Al-Emarah"
                          : "Bahij",
                ),
                textAlign: languageids == 1 ? TextAlign.left : TextAlign.right),
            // leading: Icon(Icons.receipt_long_rounded),
            leading: Icon(isdrawer == false
                ? Icons.video_camera_back_rounded
                : rightoleft3
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_outlined),
            trailing: Icon(isdrawer
                ? Icons.video_camera_back_rounded
                : rightoleft3
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_outlined),
            onExpansionChanged: (value) {
              setState(() {
                rightoleft3 = rightoleft3;
              });
            },

            children: [
              ListTile(
                title: Text(
                  "News".tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: languageids == 1
                        ? "Arial"
                        : languageids == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                  textAlign:
                      languageids == 1 ? TextAlign.left : TextAlign.right,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VideosPage(
                            languageid: languageids,
                            videotypeid: 1,
                          )));
                },
              ),
              ListTile(
                title: Text(
                  "Reports".tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: languageids == 1
                        ? "Arial"
                        : languageids == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                  textAlign:
                      languageids == 1 ? TextAlign.left : TextAlign.right,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VideosPage(
                            languageid: languageids,
                            videotypeid: 2,
                          )));
                },
              ),
              ListTile(
                title: Text(
                  "Analysis".tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: languageids == 1
                        ? "Arial"
                        : languageids == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                  textAlign:
                      languageids == 1 ? TextAlign.left : TextAlign.right,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VideosPage(
                            languageid: languageids,
                            videotypeid: 3,
                          )));
                },
              ),
            ],
          ),
          // ExpansionTile(
          //   // backgroundColor: Colors.blue,
          //   // collapsedIconColor: Colors.blue,
          //   textColor: Colors.blue,
          //   // collapsedTextColor: Colors.blue,
          //   iconColor: Colors.blue,
          //   title: Text("Documentaries".tr,
          //       style: TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.bold,
          //         fontFamily: languageids == 1
          //             ? "Arial"
          //             : languageids == 4
          //                 ? "Al-Emarah"
          //                 : "Bahij",
          //       ),
          //       textAlign: languageids == 1 ? TextAlign.left : TextAlign.right),
          //   // leading: Icon(Icons.receipt_long_rounded),
          //   leading: Icon(isdrawer == false
          //       ? Icons.receipt_long_rounded
          //       : rightoleft3
          //           ? Icons.keyboard_arrow_down_rounded
          //           : Icons.keyboard_arrow_up_outlined),
          //   trailing: Icon(isdrawer
          //       ? Icons.receipt_long_rounded
          //       : rightoleft3
          //           ? Icons.keyboard_arrow_down_rounded
          //           : Icons.keyboard_arrow_up_outlined),
          //   onExpansionChanged: (value) {
          //     setState(() {
          //       rightoleft3 = rightoleft3;
          //     });
          //   },

          //   children: [
          //     ListTile(
          //       title: Text(
          //         "Documentaries".tr,
          //         style: TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.bold,
          //           fontFamily: languageids == 1
          //               ? "Arial"
          //               : languageids == 4
          //                   ? "Al-Emarah"
          //                   : "Bahij",
          //         ),
          //         textAlign:
          //             languageids == 1 ? TextAlign.left : TextAlign.right,
          //       ),
          //       onTap: () {
          //         Navigator.of(context).push(MaterialPageRoute(
          //             builder: (context) => AllDocumentPage(
          //                   languageid: languageids,
          //                   // name: "Documentaries",
          //                 )));
          //       },
          //     ),
          //     ListTile(
          //       title: Text(
          //         "Latest Documentaries".tr,
          //         style: TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.bold,
          //           fontFamily: languageids == 1
          //               ? "Arial"
          //               : languageids == 4
          //                   ? "Al-Emarah"
          //                   : "Bahij",
          //         ),
          //         textAlign:
          //             languageids == 1 ? TextAlign.left : TextAlign.right,
          //       ),
          //       onTap: () {
          //         Navigator.of(context).push(MaterialPageRoute(
          //             builder: (context) => DocumentsPage(
          //                   languageid: languageids,
          //                   name: "Latest Documentaries",
          //                 )));
          //       },
          //     ),
          //   ],
          // ),

          ExpansionTile(
            // backgroundColor: Colors.blue,
            // collapsedIconColor: Colors.blue,
            textColor: Colors.blue,
            // collapsedTextColor: Colors.blue,
            iconColor: Colors.blue,
            title: Text("Reports".tr,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: languageids == 1
                      ? "Arial"
                      : languageids == 4
                          ? "Al-Emarah"
                          : "Bahij",
                ),
                textAlign: languageids == 1 ? TextAlign.left : TextAlign.right),
            // leading: Icon(Icons.newspaper),
            leading: Icon(isdrawer == false
                ? Icons.newspaper
                : rightoleft4
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_outlined),
            trailing: Icon(isdrawer
                ? Icons.newspaper
                : rightoleft4
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_outlined),
            onExpansionChanged: (value) {
              setState(() {
                rightoleft4 = !rightoleft4;
              });
            },
            children: [
              ListTile(
                title: Text(
                  "Reports".tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: languageids == 1
                        ? "Arial"
                        : languageids == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                  textAlign:
                      languageids == 1 ? TextAlign.left : TextAlign.right,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllReportsPage(
                            languageid: languageids,
                            // name: "Reports",
                          )));
                },
              ),
              ListTile(
                title: Text(
                  "Latest Reports".tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: languageids == 1
                        ? "Arial"
                        : languageids == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                  textAlign:
                      languageids == 1 ? TextAlign.left : TextAlign.right,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReportsPage(
                            languageid: languageids,
                            name: "Latest Reports",
                          )));
                },
              ),
            ],
          ),
          ExpansionTile(
            textColor: const Color.fromARGB(255, 0, 138, 252),
            iconColor: const Color.fromARGB(255, 0, 138, 252),
            title: Text("Analysis".tr,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: languageids == 1
                      ? "Arial"
                      : languageids == 4
                          ? "Al-Emarah"
                          : "Bahij",
                ),
                textAlign: languageids == 1 ? TextAlign.left : TextAlign.right),
            // leading: Icon(Icons.analytics_outlined),
            leading: Icon(isdrawer == false
                ? Icons.analytics_outlined
                : rightoleft6
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_outlined),
            trailing: Icon(isdrawer
                ? Icons.analytics_outlined
                : rightoleft6
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_outlined),
            onExpansionChanged: (value) {
              setState(() {
                rightoleft6 = !rightoleft6;
              });
            },
            children: [
              ListTile(
                title: Text(
                  "Analysis".tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: languageids == 1
                        ? "Arial"
                        : languageids == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                  textAlign:
                      languageids == 1 ? TextAlign.left : TextAlign.right,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllAnalysisPage(
                            languageid: languageids,
                            // videotype: ,
                            // name: "Analysis",
                          )));
                },
              ),
              ListTile(
                title: Text(
                  "Latest Analysis".tr,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: languageids == 1
                        ? "Arial"
                        : languageids == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                  textAlign:
                      languageids == 1 ? TextAlign.left : TextAlign.right,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AnalysisPage(
                            languageid: languageids,
                            name: "Latest Analysis",
                          )));
                },
              ),
            ],
          ),
          ListTile(
            leading: isdrawer == false
                ? Icon(
                    Icons.receipt_long_outlined,
                  )
                : null,
            trailing: isdrawer
                ? Icon(
                    Icons.receipt_long_outlined,
                  )
                : null,
            title: Text(
              "Documentaries".tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: languageids == 1
                    ? "Arial"
                    : languageids == 4
                        ? "Al-Emarah"
                        : "Bahij",
              ),
              textAlign: languageids == 1 ? TextAlign.left : TextAlign.right,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AllDocumentPage(
                        languageid: languageids,
                        // name: "Documentaries",
                      )));
            },
          ),
          // ExpansionTile(
          //   textColor: const Color.fromARGB(255, 0, 138, 252),
          //   iconColor: const Color.fromARGB(255, 0, 138, 252),
          //   title: Text("Radio Programs".tr,
          //       style: TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.bold,
          //         fontFamily: languageids == 1
          //             ? "Arial"
          //             : languageids == 4
          //                 ? "Al-Emarah"
          //                 : "Bahij",
          //       ),
          //       textAlign: languageids == 1 ? TextAlign.left : TextAlign.right),
          //   // leading: Icon(Icons.radio),
          //   leading: Icon(isdrawer == false
          //       ? Icons.radio
          //       : rightoleft7
          //           ? Icons.keyboard_arrow_down_rounded
          //           : Icons.keyboard_arrow_up_outlined),
          //   trailing: Icon(isdrawer
          //       ? Icons.radio
          //       : rightoleft7
          //           ? Icons.keyboard_arrow_down_rounded
          //           : Icons.keyboard_arrow_up_outlined),
          //   onExpansionChanged: (value) {
          //     setState(() {
          //       rightoleft7 = !rightoleft7;
          //     });
          //   },
          //   children: [
          //     ListTile(
          //       title: Text(
          //         "All Programs".tr,
          //         style: TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.bold,
          //           fontFamily: languageids == 1
          //               ? "Arial"
          //               : languageids == 4
          //                   ? "Al-Emarah"
          //                   : "Bahij",
          //         ),
          //         textAlign:
          //             languageids == 1 ? TextAlign.left : TextAlign.right,
          //       ),
          //       onTap: () {
          //         Navigator.of(context).push(MaterialPageRoute(
          //             builder: (context) => RadioVideosPage(
          //                   languageid: 2,
          //                   videotype: "",
          //                 )));
          //       },
          //     ),
          //     ListTile(
          //       title: Text(
          //         "Latest Programs".tr,
          //         style: TextStyle(
          //           fontSize: 14,
          //           fontWeight: FontWeight.bold,
          //           fontFamily: languageids == 1
          //               ? "Arial"
          //               : languageids == 4
          //                   ? "Al-Emarah"
          //                   : "Bahij",
          //         ),
          //         textAlign:
          //             languageids == 1 ? TextAlign.left : TextAlign.right,
          //       ),
          //       onTap: () {
          //         Navigator.of(context).push(MaterialPageRoute(
          //             builder: (context) => RadioVideosPage(
          //                   languageid: languageids,
          //                   videotype: "Latest Programs",
          //                 )));
          //       },
          //     ),
          //   ],
          // ),

          ListTile(
            leading: isdrawer == false
                ? Icon(
                    Icons.radio_outlined,
                  )
                : null,
            trailing: isdrawer
                ? Icon(
                    Icons.radio_outlined,
                  )
                : null,
            title: Text(
              "Radio Programs".tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: languageids == 1
                    ? "Arial"
                    : languageids == 4
                        ? "Al-Emarah"
                        : "Bahij",
              ),
              textAlign: languageids == 1 ? TextAlign.left : TextAlign.right,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RadioVideosPage(
                        languageid: languageids,
                        videotype: "",
                      )));
            },
          ),
          ListTile(
            leading: isdrawer == false
                ? Icon(
                    Icons.live_tv_sharp,
                    color: Colors.red,
                  )
                : null,
            trailing: isdrawer
                ? Icon(
                    Icons.live_tv_sharp,
                    color: Colors.red,
                  )
                : null,
            title: Text(
              "Live Programs".tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: languageids == 1
                    ? "Arial"
                    : languageids == 4
                        ? "Al-Emarah"
                        : "Bahij",
              ),
              textAlign: languageids == 1 ? TextAlign.left : TextAlign.right,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LiveVideosPage(
                        id: languageids,
                      )));
            },
          ),
          ListTile(
            leading: isdrawer == false
                ? Icon(
                    Icons.photo_album,
                  )
                : null,
            trailing: isdrawer
                ? Icon(
                    Icons.photo_album,
                  )
                : null,
            title: Text(
              "Gallery".tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: languageids == 1
                    ? "Arial"
                    : languageids == 4
                        ? "Al-Emarah"
                        : "Bahij",
              ),
              textAlign: languageids == 1 ? TextAlign.left : TextAlign.right,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GalleryPage(
                        languageid: languageids,
                        name: "Gallery",
                      )));
            },
          ),

          ListTile(
            leading: isdrawer == false
                ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : null,
            trailing: isdrawer
                ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : null,
            title: Text(
              "Favorites".tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: languageids == 1
                    ? "Arial"
                    : languageids == 4
                        ? "Al-Emarah"
                        : "Bahij",
              ),
              textAlign: languageids == 1 ? TextAlign.left : TextAlign.right,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ComNotes(
                        id: languageids,
                      )));
            },
          ),
          ExpansionTile(
            iconColor: Colors.blue,
            textColor: Colors.blue,
            onExpansionChanged: (value) {
              setState(() {
                rightoleft = !rightoleft;
              });
            },
            leading: Icon(isdrawer == false
                ? Icons.language_outlined
                : rightoleft
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_outlined),
            trailing: Icon(isdrawer
                ? Icons.language_outlined
                : rightoleft
                    ? Icons.keyboard_arrow_down_rounded
                    : Icons.keyboard_arrow_up_outlined),
            title: Text(
              "Language".tr,
              textAlign: languageids == 1 ? TextAlign.left : TextAlign.right,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            children: [
              ListTile(
                title: Text(
                  "Pashto".tr,
                  textAlign:
                      languageids == 1 ? TextAlign.left : TextAlign.right,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: languageids == 1
                        ? "Arial"
                        : languageids == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                ),
                onTap: () {
                  setState(() {
                    isdrawer = true;
                    // language = true;

                    // storelanguage();

                    removelanguageid();

                    storelanguageid(2);
                    // storelocal('pa');
                    locale = Locale('pa', 'AF');
                    Get.updateLocale(locale);
                    // storelanguage("AF");
                    // Get.reset();
                    _onrefresh();
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                title: Text(
                  "Dari".tr,
                  textAlign:
                      languageids == 1 ? TextAlign.left : TextAlign.right,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: languageids == 1
                        ? "Arial"
                        : languageids == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                ),
                onTap: () {
                  setState(() {
                    // language = true;
                    // storelanguage();
                    isdrawer = true;

                    removelanguageid();

                    storelanguageid(3);
                    // storelocal('dr');
                    locale = Locale('dr', 'AF');
                    Get.updateLocale(locale);
                    // storelanguage('AF');
                    // Get.reset();
                    _onrefresh();
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                title: Text(
                  "Arabic".tr,
                  textAlign:
                      languageids == 1 ? TextAlign.left : TextAlign.right,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: languageids == 1
                        ? "Arial"
                        : languageids == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                ),
                onTap: () {
                  setState(() {
                    isdrawer = true;
                    // language = true;

                    // storelanguage();

                    removelanguageid();

                    // storelocal('pa');
                    locale = Locale('arr', 'ARR');
                    Get.updateLocale(locale);
                    storelanguageid(4);

                    // storelanguage("AF");
                    // Get.reset();
                    _onrefresh();
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                title: Text(
                  "English".tr,
                  textAlign:
                      languageids == 1 ? TextAlign.left : TextAlign.right,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: languageids == 1
                        ? "Arial"
                        : languageids == 4
                            ? "Al-Emarah"
                            : "Bahij",
                  ),
                ),
                onTap: () {
                  setState(() {
                    isdrawer = false;

                    removelanguageid();
                    // removelocal();
                    storelanguageid(1);
                    // storelocal('en');
                    // language = false;
                    // removelocale.toString().contains('AF')();
                    locale = Locale('en', 'US');
                    Get.updateLocale(locale);
                    _onrefresh();
                    Navigator.pop(context);

                    // Get.reset();
                  });
                },
              ),
            ],
          ),
          ListTile(
            leading: isdrawer == false
                ? Icon(
                    Icons.perm_device_information_rounded,
                    // color: Colors.red,
                  )
                : null,
            trailing: isdrawer
                ? Icon(
                    Icons.perm_device_information_rounded,

                    // color: Colors.red,
                  )
                : null,
            title: Text(
              "About Us".tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: languageids == 1
                    ? "Arial"
                    : languageids == 4
                        ? "Al-Emarah"
                        : "Bahij",
              ),
              textAlign: languageids == 1 ? TextAlign.left : TextAlign.right,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AboutUs(
                        languageID: languageids,
                      )));
            },
          ),
        ],
      ),
    );
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndecatorKey =
      GlobalKey<RefreshIndicatorState>();
  void refreshMethod(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      print("The refresh indecator is good enoup for work!!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // onDrawerChanged: (isOpened) {
      //   setState(() {
      //     Navigator.of(context).pop();
      //   });
      // },

      appBar: AppBar(
        // clipBehavior: Clip.antiAlias,
        leadingWidth: languageids == 1 ? 40 : 100,
        leading: languageids != 1
            ?

            // IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
            Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          Home.isclick = !Home.isclick;

                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleThemes();
                        });
                      },
                      icon: Home.isclick
                          ? Icon(Icons.nights_stay_sharp)
                          : Icon(
                              Icons.wb_sunny,
                              color: Colors.yellow,
                            )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Searchs(languageids)));
                      },
                      icon: Icon(Icons.search)),
                ],
              )
            : null,
        actions: languageids == 1
            ? [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Searchs(languageids)));
                    },
                    icon: Icon(
                      Icons.search,
                      // size: 22,
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        Home.isclick = !Home.isclick;

                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleThemes();
                      });
                    },
                    icon: Home.isclick
                        ? Icon(Icons.nights_stay_sharp)
                        : Icon(
                            Icons.wb_sunny,
                            color: Colors.yellow,
                          )),
              ]
            : null,
        title: Row(
          mainAxisAlignment: languageids == 1
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            // Expanded(
            //   child: SizedBox(
            //       // width: languageids == 1 ? 1 : 10,
            //       ), //
            // ),
            Expanded(
              child: Row(
                mainAxisAlignment: languageids == 1
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  Text(
                    languageids == 1 ? "Hurriyat" : "نېوز",
                    style: TextStyle(
                      fontSize: languageids == 1 ? 20 : 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: languageids == 1
                          ? "Arial"
                          : languageids == 4
                              ? "Al-Emarah"
                              : "Bahij",
                    ),
                  ),
                  languageids == 1
                      ? Expanded(
                          child: Text(
                            "News".tr,
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 130, 185),
                              fontWeight: FontWeight.bold,
                              fontSize: languageids == 1 ? 22 : 22,
                              fontFamily: languageids == 1
                                  ? "Arial"
                                  : languageids == 4
                                      ? "Al-Emarah"
                                      : "Bahij",
                            ),
                          ),
                        )
                      : Text(
                          languageids == 1 ? "News" : "حوریت",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 130, 185),
                            fontWeight: FontWeight.bold,
                            fontSize: languageids == 1 ? 22 : 24,
                            fontFamily: languageids == 1
                                ? "Arial"
                                : languageids == 4
                                    ? "Al-Emarah"
                                    : "Bahij",
                          ),
                        ),
                ],
              ),
            ),
            // Expanded(
            //   child:
            // ),
            // Expanded(
            //   child:
            // ),
          ],
        ),
        // centerTitle: true,
        elevation: 1.0,
      ),

      body: RefreshIndicator(
        key: _refreshIndecatorKey,
        displacement: 100,
        backgroundColor: Colors.white,
        color: Colors.red,
        // strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          // await Future.delayed(Duration(seconds: 4));
          // return setState(() {
          print("object");
          // getallpost();
          _onrefresh();
          // latestdioCacheManager.clearAll();

          // getNews(languageids);
          // getSlider(languageids);
          //dioCacheManager;
          dioCacheManager.clearAll();

          // CircularProgressIndicator();
          // _loading
          //     ? Center(child: CircularProgressIndicator())
          //     : _onrefresh();
          // });
        },
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: languageids == 1
                  //     ? CrossAxisAlignment.start
                  //     : CrossAxisAlignment.end,

                  children: [
                    MyAppInternet(),

                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: 10.0),
                      height: 30,
                      child: ListView.builder(
                          // shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          reverse: languageids == 1 ? false : true,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                                languageId: languageids!,
                                categoryName: categories[index].categoryName);
                          }),
                    ),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    // Divider(
                    //   height: 15,
                    //   thickness: 2,
                    //   // color: Colors.red,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 5, top: 10),
                      child: Row(
                        mainAxisAlignment: languageids == 1
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          Text(
                            languageids == 1
                                ? 'Latest News'
                                : languageids == 2
                                    ? 'ورستي خبرونه'
                                    : languageids == 3
                                        ? 'آخرین اخبار'
                                        : 'أحدث الأخبار ',
                            style: TextStyle(
                              // color: const Color.fromARGB(255, 255, 1, 1),
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              fontFamily: languageids == 1
                                  ? "Arial"
                                  : languageids == 4
                                      ? "Al-Emarah"
                                      : "Bahij",
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => AllNews(
                          //                   news: "Breaking",
                          //                   languageid: languageids!,
                          //                 )));
                          //   },
                          //   child: Text(
                          //     languageids == 1
                          //         ? 'ُView All'
                          //         : languageids == 2
                          //             ? 'ټول لیدل'
                          //             : languageids == 3
                          //                 ? 'بازدید همه'
                          //                 : 'ټول لیدل',
                          //     style: TextStyle(
                          //         decoration: TextDecoration.underline,
                          //         decorationColor:
                          //             Color.fromARGB(255, 0, 130, 185),
                          //         // color: Color.fromARGB(255, 0, 130, 185),
                          //         fontFamily:
                          //             languageids == 1
                          // ? "Arial"
                          // : languageids == 4
                          //     ? "Al-Emarah"
                          //     : "Bahij",
                          //         fontWeight: FontWeight.w600,
                          //         fontSize: 14.0),
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    loading2
                        ? Container(
                            height: 200,
                            width: 250,
                            child: CarouselSlider.builder(
                                // carouselController: CarouselController(),

                                itemCount: 5,
                                itemBuilder: (context, index, realIndex) {
                                  // String? res =
                                  //     snapshot.data![index].urlToImage;
                                  // String? res1 =
                                  //     snapshot.data![index].title;
                                  // String? res3 =
                                  //     snapshot.data![index].content;

                                  // // int? res2 =
                                  // //     snapshot.data![index].languageId;
                                  // String? url = snapshot.data![index].url;
                                  return Skeletonizer(
                                    enabled: true,
                                    child:
                                        Image.asset("assets/images/sport.jpg"),
                                  );
                                },
                                options: CarouselOptions(
                                    reverse: languageids == 1 ? false : true,
                                    height: 180,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.height,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        activeIndex = index;
                                      });
                                    })),
                          )
                        : FutureBuilder<List<SliderModel>>(
                            future: getSlider(languageids),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CarouselSlider.builder(
                                    itemCount: 5,
                                    itemBuilder: (context, index, realIndex) {
                                      // String? res =
                                      //     snapshot.data![index].urlToImage;
                                      // String? res1 =
                                      //     snapshot.data![index].title;
                                      // String? res3 =
                                      //     snapshot.data![index].content;

                                      // // int? res2 =
                                      // //     snapshot.data![index].languageId;
                                      // String? url = snapshot.data![index].url;
                                      return Container(
                                        height: 180,
                                        width: 250,
                                        child: Skeletonizer(
                                          enabled: true,
                                          child: Image.asset(
                                              "assets/images/sport.jpg"),
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                        reverse:
                                            languageids == 1 ? false : true,
                                        height: 180,
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        enlargeStrategy:
                                            CenterPageEnlargeStrategy.height,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            activeIndex = index;
                                          });
                                        }));
                              }

                              //  SingleChildScrollView(
                              //   scrollDirection: Axis.vertical,
                              //   child: Container(
                              //     child: Skeletonizer(
                              //       enabled: true,
                              //       child: Row(
                              //         children: [
                              //           Card(
                              //             child: ListTile(
                              //               title:
                              //                   Text('Item number as title'),
                              //               subtitle:
                              //                   const Text('Subtitle here'),
                              //               trailing:
                              //                   const Icon(Icons.ac_unit),
                              //             ),
                              //           ),
                              //           Card(
                              //             child: ListTile(
                              //               title:
                              //                   Text('Item number as title'),
                              //               subtitle:
                              //                   const Text('Subtitle here'),
                              //               trailing:
                              //                   const Icon(Icons.ac_unit),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // );

                              if (snapshot.hasError) {
                                print(" error" + snapshot.error.toString());
                                return Center(
                                  heightFactor: 23,
                                  child:
                                      // CircularProgressIndicator(),
                                      Text("Please Wait..." +
                                          snapshot.hasError.toString()),
                                );
                              }

                              return CarouselSlider.builder(
                                  itemCount: 5,
                                  itemBuilder: (context, index, realIndex) {
                                    String? res =
                                        snapshot.data![index].urlToImage;
                                    String? res1 = snapshot.data![index].title;
                                    String? res3 =
                                        snapshot.data![index].content;

                                    // int? res2 =
                                    //     snapshot.data![index].languageId;
                                    String? url = snapshot.data![index].url;
                                    return GestureDetector(
                                      onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => ArticleView(
                                                    blogUrl: url,
                                                  ))),
                                      child: buildImage(
                                          image: res,
                                          languageId: languageids,
                                          categorys: res3,
                                          index: index,
                                          name: res1
                                          // res!, index, res1, res2, res3
                                          ),
                                    );
                                  },
                                  options: CarouselOptions(
                                      reverse: languageids == 1 ? false : true,
                                      height: 190,
                                      autoPlay: true,
                                      enlargeCenterPage: true,
                                      enlargeStrategy:
                                          CenterPageEnlargeStrategy.height,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          activeIndex = index;
                                        });
                                      }));
                            }),

                    SizedBox(
                      height: 5,
                    ),
                    Center(child: buildIndicator()),

                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          languageids == 1
                              ? Text(
                                  languageids == 1
                                      ? 'News'
                                      : languageids == 2
                                          ? 'خبرونه'
                                          : languageids == 3
                                              ? 'خبرها'
                                              : 'الأخبار',
                                  style: TextStyle(
                                      // color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: languageids == 1
                                          ? "Arial"
                                          : languageids == 4
                                              ? "Al-Emarah"
                                              : "Bahij",
                                      fontSize: 16.0),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Pagenition(
                                              languageid: languageids),
                                          // AllNews(
                                          //   news: "Trending",
                                          //   languageid: languageids!,
                                          // )
                                        ));
                                  },
                                  child: Text(
                                    "",
                                    // languageids == 1
                                    //     ? 'ُView All'
                                    //     : languageids == 2
                                    //         ? 'ټول لیدل'
                                    //         : languageids == 3
                                    //             ? 'بازدید همه'
                                    //             : 'ټول لیدل',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            Color.fromARGB(255, 0, 130, 185),
                                        // color: Color.fromARGB(255, 0, 130, 185),
                                        fontFamily: languageids == 1
                                            ? "Arial"
                                            : languageids == 4
                                                ? "Al-Emarah"
                                                : "Bahij",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0),
                                  ),
                                ),
                          languageids != 1
                              ? Text(
                                  languageids == 1
                                      ? 'ُTrending News'
                                      : languageids == 2
                                          ? 'عام خبرونه'
                                          : languageids == 3
                                              ? 'خبرهای عام'
                                              : 'الأخبار الشائعة',
                                  style: TextStyle(
                                      // color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: languageids == 1
                                          ? "Arial"
                                          : languageids == 4
                                              ? "Al-Emarah"
                                              : "Bahij",
                                      fontSize: 16.0),
                                )
                              : Text(
                                  // languageids == 1
                                  //     ? 'ُView All'
                                  //     : languageids == 2
                                  //         ? 'ټول لیدل'
                                  //         : languageids == 3
                                  //             ? 'بازدید همه'
                                  //             : 'ټول لیدل',
                                  "",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          Color.fromARGB(255, 0, 130, 185),
                                      // color: Color.fromARGB(255, 0, 130, 185),
                                      fontFamily: languageids == 1
                                          ? "Arial"
                                          : languageids == 4
                                              ? "Al-Emarah"
                                              : "Bahij",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0),
                                ),
                        ],
                      ),
                    ),

                    // loading2?
                    // ? SingleChildScrollView(
                    //     child: Column(
                    //       children: [
                    //         ListView.builder(
                    //             shrinkWrap: false,
                    //             physics: BouncingScrollPhysics(
                    //                 parent:
                    //                     AlwaysScrollableScrollPhysics()),
                    //             itemCount: 10,
                    //             // shrinkWrap: true,
                    //             // physics: AlwaysScrollableScrollPhysics(),
                    //             itemBuilder: (context, index) {
                    //               return SkeletonWidget();
                    //             }),
                    //       ],
                    //     ),
                    //   )
                    // :
                    Pagenition(languageid: languageids ?? 1),
                    // FutureBuilder<List<ArticleModel>>(
                    //     future: getNews(languageids ?? 1),
                    //     builder: (context, snapshot) {
                    //       if (!snapshot.hasData) {
                    //         return SingleChildScrollView(
                    //           child: ListView.builder(
                    //               itemCount: 10,
                    //               shrinkWrap: true,
                    //               itemBuilder: (context, index) {
                    //                 return SkeletonWidget();
                    //               }),
                    //         );
                    //       }
                    //       if (snapshot.hasError) {
                    //         print(" error" + snapshot.error.toString());
                    //         return Center(
                    //           heightFactor: 23,
                    //           child:
                    //               // CircularProgressIndicator(),
                    //               Text("Please Wait..." +
                    //                   snapshot.hasError.toString()),
                    //         );
                    //       }
                    //       return ListView.builder(
                    //           controller: scrolcontroller,
                    //           shrinkWrap: true,
                    //           // physics: ClampingScrollPhysics(),
                    //           itemCount: snapshot.data!.length,
                    //           itemBuilder: (context, index) {
                    //             return BlogTile(
                    //               category: snapshot.data![index].content
                    //                   .toString(),
                    //               url: snapshot.data![index].url,
                    //               desc: snapshot.data![index].description!,
                    //               imageUrl:
                    //                   snapshot.data![index].urlToImage!,
                    //               title: snapshot.data![index].title!,
                    //               languageID: languageids,
                    //             );
                    //           });
                    //     })
                    // Container(
                    //   child:
                    // )
                  ],
                ),
              ),
      ),
      drawer: languageids == 1 ? _drawer() : null,

      endDrawer: languageids != 1 ? _drawer() : null,
    );
  }

  Widget buildImage(
          {String? image,
          int? index,
          String? name,
          int? languageId,
          String? categorys}) =>
      Container(
          decoration: const BoxDecoration(
            // border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(0.8)),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 190,
                fit: BoxFit.cover,
                width: MediaQuery.of(context as BuildContext).size.width,
                imageUrl: image.toString(),
                placeholder: (context, url) => Skeletonizer(
                    // enabled: true,
                    child: Container(
                  width: double.infinity,
                  height: 190,
                  child: Image.asset(
                    "assets/logos/logo@2x.png",
                    fit: BoxFit.cover,
                  ),
                )),
                errorWidget: (context, url, error) {
                  debugPrint(error.toString());

                  return Container(
                    width: double.infinity,
                    height: 190,
                    child: Image.asset("assets/logos/logo@2x.png",
                        fit: BoxFit.cover),
                  );
                },
              ),
            ),
            languageId == 1
                ? Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      // height: 18,
                      child:
                          // CategoryTile(
                          // languageId: languageId as int,
                          // categoryName: categorys,
                          Center(
                              child: Container(
                        // width: 180,
                        //  padding: EdgeInsets.only(left: 0.0),
                        // margin: EdgeInsets.only(top: 170.0),
                        // width: MediaQuery.of(context as BuildContext).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 130, 185),
                          // borderRadius: BorderRadius.only(
                          //     bottomLeft: Radius.circular(10),
                          //     bottomRight: Radius.circular(10))
                        ),
                        padding: EdgeInsets.only(right: 5, left: 5),
                        // : EdgeInsets.only(left: 9),
                        child: Text(
                          maxLines: 1,
                          textAlign: languageId == 1
                              ? TextAlign.left
                              : TextAlign.right,
                          // _languageId != 1 ? TextAlign.left : TextAlign.center,
                          textDirection: languageId == 1
                              ? ui.TextDirection.ltr
                              : ui.TextDirection.rtl,
                          categorys.toString().tr,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: languageids == 1
                                ? "Arial"
                                : languageids == 4
                                    ? "Al-Emarah"
                                    : "Bahij",
                            color: Colors.white,
                          ),
                        ),
                      )),
                    ),
                  )
                : Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      height: 22,
                      child:
                          // CategoryTile(
                          // languageId: languageId as int,
                          // categoryName: categorys,
                          Center(
                              child: Container(
                        // width: 180,
                        padding: EdgeInsets.only(
                          left: 4,
                          right: 4,
                          bottom: 1,
                        ),
                        // margin: EdgeInsets.only(top: 170.0),
                        // width: MediaQuery.of(context as BuildContext).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 130, 185),
                          // borderRadius: BorderRadius.only(
                          //     bottomLeft: Radius.circular(10),
                          //     bottomRight: Radius.circular(10))
                        ),
                        // : EdgeInsets.only(left: 9),
                        child: Text(
                          maxLines: 1,
                          textAlign: languageId == 1
                              ? TextAlign.left
                              : TextAlign.right,
                          // _languageId != 1 ? TextAlign.left : TextAlign.center,
                          textDirection: languageId == 1
                              ? ui.TextDirection.ltr
                              : ui.TextDirection.rtl,
                          categorys.toString().tr,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            fontFamily: languageids == 1
                                ? "Arial"
                                : languageids == 4
                                    ? "Al-Emarah"
                                    : "Bahij",
                            color: Colors.white,
                          ),
                        ),
                      )),
                    ),
                  ),
            SizedBox(
              width: 5,
            ),
            Container(
              height: 190,
              padding: EdgeInsets.only(bottom: 5, left: 3, right: 3),
              //     ? EdgeInsets.only(left: 10)
              //     : EdgeInsets.only(right: 10),
              margin: EdgeInsets.only(top: 130.0),
              width: MediaQuery.of(context as BuildContext).size.width,
              decoration: BoxDecoration(
                // border: Border.all(width: 0.4, color: Colors.grey),
                gradient: Home.isclick == false
                    ? LinearGradient(
                        colors: [
                            Colors.white.withOpacity(0.6),
                            Color.fromARGB(255, 34, 26, 26).withOpacity(0.6),
                          ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)
                    : LinearGradient(
                        colors: [
                            Color.fromARGB(255, 34, 26, 26).withOpacity(0.6),
                            Colors.white.withOpacity(0.6)
                          ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter),

                // color: Home.isclick
                //     ? Color.fromARGB(255, 34, 26, 26).withOpacity(0.6)
                //     : Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Center(
                child: Container(
                  child: Text(
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    // languageId == 1 ? TextAlign.left : TextAlign.right,
                    textDirection: languageId == 1
                        ? ui.TextDirection.ltr
                        : ui.TextDirection.rtl,
                    name.toString(),
                    style: TextStyle(
                      // letterSpacing: 1,
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                      // shadows: [
                      //   Shadow(
                      //       // color: const Color.fromARGB(255, 194, 14, 2),
                      //       offset: Offset(0.0, 0.5),
                      //       blurRadius: 0.5),
                      // ],
                      height: 1.1,
                      color: Home.isclick ? Colors.black : Colors.white,

                      // shadows: 3,
                      fontFamily: languageids == 1
                          ? "Arial"
                          : languageids == 4
                              ? "Al-Emarah"
                              : "Bahij",
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  //  ShowText(
                  //   textdata: name,
                  //   languageId: _languageId,
                  //   maxline: 2,
                  //   fontWeight: FontWeight.bold,
                  //   textsize: 25,
                  // ),
                ),
              ),
            ),
          ]));

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        textDirection: languageids == 1 ? TextDirection.ltr : TextDirection.rtl,
// textDirection: ,
        count: 5,
        effect: SlideEffect(
          dotWidth: 15,
          dotHeight: 9,
          activeDotColor: Color.fromARGB(255, 0, 130, 185),
        ),
      );
}
