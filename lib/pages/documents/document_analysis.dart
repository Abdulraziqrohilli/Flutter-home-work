import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hurriyat/models/documentsmodels/newdocumentariesapi/Data.dart';
import 'package:hurriyat/models/documentsmodels/newdocumentariesapi/Dumententsapi.dart';

import 'package:hurriyat/widgets/videodetails.dart';
import 'package:hurriyat/pages/analysis/analysis_details.dart';
import 'package:hurriyat/pages/radio_program/videodetails.dart';
import 'package:hurriyat/widgets/NoData.dart';

import 'package:dio/dio.dart' as dio;

import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:hurriyat/widgets/blogtile.dart';
import 'package:hurriyat/widgets/skeleton.dart';
import 'package:hurriyat/widgets/videowidget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllDocumentPage extends StatefulWidget {
  int languageid;
  // String? videotype;
  AllDocumentPage({
    required this.languageid,
  });

  @override
  State<AllDocumentPage> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllDocumentPage> {
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
  // int limit = 10;
  final scrolcontrolller = ScrollController();
  Future<void> getNews(int languageid) async {
    await Future.delayed(Duration(seconds: 1));
    try {
      dio.Dio _dio = dio.Dio();

      // String url =
      // //     "https://hurriyat.net/api/news/$languageid?page=$page_number";
      // String url = widget.videotype == "Latest Programs"
      //     ? "https://hurriyat.net/api/latest-radio-programs/$languageid?page=$page_number"
      //     : "https://hurriyat.net/api/radio-programs/$languageid?page=$page_number";
      String url =
          "https://hurriyat.net/api/documentaries/$languageid?page=$page_number";
      // String url = "https://hurriyat.net/api/analysis/$languageid";

      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      dio.Options options = buildCacheOptions(const Duration(seconds: 3),
          forceRefresh: true, maxStale: Duration(days: 7));
      _dio.interceptors.add(dioCacheManager.interceptor);

      dio.Response response = await _dio.get(
        url,
        options: options,
        // queryParameters: {'page': page_number, 'pageSize': 10}
      );
      Dumententsapi newresponse = Dumententsapi.fromJson(response.data);
      // List<dynamic> responsedata=newresponse.data;
      // List<ArticleModel> newdata=responsedata.map((e) => ArticalNews.fromJson(e)).toList();
      // allData.addAll(newresponse.data);
      // if (allData.isEmpty) {
      //   setState(() {
      //     hasMore = false;
      //   });
      // }
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
            // widget.videotype == "Latest Programs"
            //     ? "Latest Programs".tr
            //     : "All Programs".tr,
            "Analysis".tr,
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
                  height: 1100,
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
                                         createdAt: allData[index].createdAt,
                                    videoId: allData[index].videoId.toString(),
                                    title: allData[index].title.toString(),
                                    content: allData[index].content.toString(),
                                    user: allData[index].user.toString(),
                                    videoType: 1,
                                    views: allData[index].views,
                                    languageId: widget.languageid,
                                          )));
                                },
                                child: BlogTile(
                                    created_at: allData[index].createdAt,
                                    imageUrl: allData[index].image.toString(),
                                    title: allData[index].title.toString(),
                                    url: allData[index].id.toString(),
                                    languageID: widget.languageid,
                                    ),
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
