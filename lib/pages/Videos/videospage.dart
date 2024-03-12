import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hurriyat/models/Videos/Data.dart';
import 'package:hurriyat/models/Videos/Videos.dart';
import 'package:hurriyat/widgets/videodetails.dart';
import 'package:hurriyat/services/videos/Videos.dart';
import 'package:hurriyat/widgets/NoData.dart';
import 'dart:ui' as ui;
import 'package:hurriyat/widgets/blogtile.dart';
import 'package:hurriyat/widgets/skeleton.dart';
import 'package:hurriyat/widgets/videowidget.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;

import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:skeletonizer/skeletonizer.dart';

class VideosPage extends StatefulWidget {
  int languageid;
  int? videotypeid;
  VideosPage({required this.languageid, required this.videotypeid});

  @override
  State<VideosPage> createState() => _AllNewsState();
}

class _AllNewsState extends State<VideosPage> {
  // List<sliderModel> sliders = [];
  List<Data> allData = [];
  int page_number = 1;
  bool isloading = false;
  void initState() {
    super.initState();

    getNews(widget.languageid);
    scrolcontrolller.addListener(controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrolcontrolller.dispose();
    super.dispose();
  }

  bool skeletonlooder = true;
  bool hasMore = true;
  int limit = 10;
  final scrolcontrolller = ScrollController();
  Future<void> getNews(int languageid) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      dio.Dio _dio = dio.Dio();

      // String url =
      //     "https://hurriyat.net/api/news/$languageid?page=$page_number";
      String url =
          "https://hurriyat.net/api/videos/${widget.videotypeid}/$languageid?limit=$limit&page=$page_number";

      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      dio.Options options =
          buildCacheOptions(const Duration(seconds: 1), forceRefresh: false);
      _dio.interceptors.add(dioCacheManager.interceptor);

      dio.Response response = await _dio.get(
        url,
        options: options,
        // queryParameters: {'page': page_number, 'pageSize': 10}
      );
      Videos newresponse = Videos.fromJson(response.data);

      setState(() {
        allData = allData + newresponse.data;

        skeletonlooder = false;
      });
      // return allData;
    } on dio.DioError catch (e) {
      print("this is the main error" + e.error);
      // return null!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.videotypeid == 1
                ? "News".tr
                : widget.videotypeid == 2
                    ? "Reports".tr
                    : "Analysis".tr,
            style: TextStyle(
                color: Color.fromARGB(255, 0, 130, 185),
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: skeletonlooder
            ? SingleChildScrollView(
                child: Container(
                  height: 1000,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return SkeletonWidget();
                    },
                  ),
                ),
              )
            : allData.length < 1
                ? NoDataAvailableWidget()
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: RefreshIndicator(
                      onRefresh: onRefrish,
                      child: ListView.builder(
                          controller: scrolcontrolller,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount:
                              isloading ? allData.length + 1 : allData.length,
                          itemBuilder: (context, index) {
                            if (index < allData.length) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => VideoDetails(
                                            languageId: widget.languageid,
                                            content: allData[index]
                                                .content
                                                .toString(),
                                            createdAt: allData[index]
                                                .createdAt
                                                .toString(),
                                            title:
                                                allData[index].title.toString(),
                                            user:
                                                allData[index].user.toString(),
                                            videoId: allData[index]
                                                .videoId
                                                .toString(),
                                            videoType: allData[index].videoType,
                                            views: allData[index].views,
                                          )));
                                },
                                child: BlogTileVideo(
                                    desc: allData[index].content.toString(),
                                    imageUrl: allData[index].image.toString(),
                                    title: allData[index].title.toString(),
                                    url: allData[index].id.toString(),
                                    languageID: widget.languageid),
                              );
                            } else {
                              return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 32),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ));
                            }
                          }),
                    ),
                    //   );
                    // }
                  ));
  }

  Future<void> controller() async {
    if (isloading) return;
    if (scrolcontrolller.position.pixels ==
        scrolcontrolller.position.maxScrollExtent) {
      setState(() {
        isloading = true;
      });
      // if (allData.length < limit) {
      //   setState(() {
      //     hasMore = false;
      //   });
      // }
      page_number = page_number + 1;

      await getNews(widget.languageid);

      setState(() {
        isloading = false;
      });
    }
  }

  Future onRefrish() async {
    setState(() {
      getNews(widget.languageid);
      CircularProgressIndicator();
    });
  }
}
