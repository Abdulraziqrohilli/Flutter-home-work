import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hurriyat/models/liveapi/Data.dart';
import 'package:hurriyat/models/liveapi/Liveapo.dart';
import 'package:hurriyat/widgets/videodetails.dart';
import 'package:hurriyat/pages/live/livedetails.dart';
import 'package:hurriyat/services/videos/Videos.dart';
import 'package:hurriyat/widgets/NoData.dart';
import 'dart:ui' as ui;
import 'package:hurriyat/widgets/blogtile.dart';
import 'package:hurriyat/widgets/skeleton.dart';
import 'package:hurriyat/widgets/videoskeleton.dart';
import 'package:hurriyat/widgets/videowidget.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;

import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LiveVideosPage extends StatefulWidget {
  int? id;
  LiveVideosPage({
    required this.id,
  });

  @override
  State<LiveVideosPage> createState() => _AllNewsState();
}

class _AllNewsState extends State<LiveVideosPage> {
  // List<sliderModel> sliders = [];
  List<Data> allData = [];
  // int page_number = 1;
  bool isloading = false;
  void initState() {
    super.initState();

    getLive();
    // scrolcontrolller.addListener(controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<Liveapo> getLive() async {
    try {
      dio.Dio _dio = dio.Dio();

      String url = 'https://hurriyat.net/api/live';
      // DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      // dio.Options options = buildCacheOptions(const Duration(seconds: 3),
      //     forceRefresh: true, maxStale: Duration(days: 7));
      // _dio.interceptors.add(dioCacheManager.interceptor);

      dio.Response response = await _dio.get(
        url,
      );
      // DetailsModel newresponse = DetailsModel.fromJson(response.data);
      Liveapo newresponse = Liveapo.fromJson(response.data);
      return newresponse;
    } on dio.DioError catch (e) {
      print("this is the main error" + e.error);
      return null!;
    }
  }
  // Future<void> getLive() async {
  //   // await Future.delayed(Duration(seconds: 2));
  //   try {
  //     dio.Dio _dio = dio.Dio();

  //     // String url =
  //     //     "https://hurriyat.net/api/news/$languageid?page=$page_number";
  //     String url = "https://hurriyat.net/api/live";

  //     // DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
  //     // dio.Options options =
  //     //     buildCacheOptions(const Duration(seconds: 1), forceRefresh: false);
  //     // _dio.interceptors.add(dioCacheManager.interceptor);

  //     dio.Response response = await _dio.get(
  //       url,
  //       // options: options,
  //       // queryParameters: {'page': page_number, 'pageSize': 10}
  //     );
  //     Liveapo newresponse = Liveapo.fromJson(response.data);

  //     setState(() {
  //       allData = allData;

  //       skeletonlooder = false;
  //     });
  //     // return allData;
  //   } on dio.DioError catch (e) {
  //     print("this is the main error" + e.error);
  //     // return null!;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return
        //  skeletonlooder
        //     ?
        //  SingleChildScrollView(
        //     child: Container(
        //       height: 1000,
        //       child: ListView.builder(
        //         itemCount: 10,
        //         itemBuilder: (context, index) {
        //           return SkeletonWidget();
        //         },
        //       ),
        //     ),
        //   )
        // // : allData.length < 1
        // //     ? NoDataAvailableWidget()
        // // :
        Scaffold(
      appBar: AppBar(
        title: Text(
          textAlign:
              widget.id.toString() == '1' ? TextAlign.left : TextAlign.right,
          textDirection: widget.id.toString() == '1'
              ? ui.TextDirection.ltr
              : ui.TextDirection.rtl,
          "Hurriyat Radio Live Stream",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            fontFamily: widget.id == 1
                ? "Arial"
                : widget.id == 4
                    ? "Al-Emarah"
                    : "Bahij",
          ),
        ),
      ),
      body: FutureBuilder<Liveapo>(
        future: getLive(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              // padding: ,
              height: 1000,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return VideoSkeletonWidget();
                },
              ),
            );
          }
          return LiveDetails(
            // languageId: allData[index].,
            createdAt: snapshot.data!.data!.createdAt.toString(),
            title: snapshot.data!.data!.title.toString(),
            videoId: snapshot.data!.data!.videoId.toString(),
            id: snapshot.data!.data!.id,
            updatedAt: snapshot.data!.data!.updatedAt.toString(),
          );
        },

        //   );
        // }
      ),
    );
  }

  // Future<void> controller() async {
  //   if (isloading) return;
  //   if (scrolcontrolller.position.pixels ==
  //       scrolcontrolller.position.maxScrollExtent) {
  //     setState(() {
  //       isloading = true;
  //     });
  //     // if (allData.length < limit) {
  //     //   setState(() {
  //     //     hasMore = false;
  //     //   });
  //     // }
  //     page_number = page_number + 1;

  //     await getNews(widget.languageid);

  //     setState(() {
  //       isloading = false;
  //     });
  //   }
  // }

  Future onRefrish() async {
    setState(() {
      getLive();
      CircularProgressIndicator();
    });
  }
}
