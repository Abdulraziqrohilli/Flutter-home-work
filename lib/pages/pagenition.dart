import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:hurriyat/models/Slider.dart';
import 'package:hurriyat/models/artical.dart';
import 'package:hurriyat/models/article_model.dart';
import 'package:hurriyat/models/slider_model.dart';
import 'package:hurriyat/pages/article_view.dart';
import 'package:hurriyat/services/news.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_html/flutter_html.dart' as style;

import 'package:hurriyat/services/slider_data.dart';
import 'package:hurriyat/widgets/blogtile.dart';
import 'package:hurriyat/widgets/internetconnection.dart';
import 'package:hurriyat/widgets/skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Pagenition extends StatefulWidget {
  int languageid;
  Pagenition({required this.languageid});

  @override
  State<Pagenition> createState() => _AllNewsState();
}

class _AllNewsState extends State<Pagenition> {
  // List<sliderModel> sliders = [];

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
  List<ArticleModel> allData = [];
  int page_number = 1;
  final scrolcontrolller = ScrollController();
  Future<void> getNews(int languageid) async {
    // await Future.delayed(Duration(seconds: 1));
    try {
      dio.Dio _dio = dio.Dio();

      String url =
          "https://hurriyat.net/api/news/$languageid?page=$page_number";
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      dio.Options options = buildCacheOptions(const Duration(milliseconds: 100),
          forceRefresh: false, maxStale: Duration(days: 7));
      _dio.interceptors.add(dioCacheManager.interceptor);

      dio.Response response = await _dio.get(
        url,
        options: options,
        // queryParameters: {'page': page_number, 'pageSize': 10}
      );
      ArticalNews newresponse = ArticalNews.fromJson(response.data);
      // List<dynamic> responsedata=newresponse.data;
      // List<ArticleModel> newdata=responsedata.map((e) => ArticalNews.fromJson(e)).toList();
      // allData.addAll(newresponse.data);
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
    return Container(
        height: MediaQuery.of(context).size.width / 0.9,
        // width: double.infinity,
        // appBar: AppBar(
        //   title: Text(
        //     "Trending News",
        //     style: TextStyle(
        //         color: Color.fromARGB(255, 0, 130, 185),
        //         fontWeight: FontWeight.bold),
        //   ),
        //   centerTitle: true,
        //   elevation: 0.0,
        // ),
        child:
            //  FutureBuilder<void>(
            //     future: getNews(widget.languageid),
            //     builder: (context, snapshot) {

            //       if (snapshot.hasError) {
            //         print(" error" + snapshot.error.toString());
            //         return Center(
            //           heightFactor: 23,
            //           child:
            //               // CircularProgressIndicator(),
            //               Text("Please Wait..." + snapshot.hasError.toString()),
            //         );
            //       }

            //       return

            skeletonlooder
                ? ListView.builder(
                    itemCount: 10,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SkeletonWidget(),
                        ],
                      );
                      // BlogTile(
                      //     desc:
                      //         "sdfdasdfasdfasdfasdfasdfasdfasdf",
                      //     imageUrl: "sdfasdfasdf",
                      //     title: "sdfsdfgsdfgsdgdfsdf",
                      //     url: "",
                      //     //     languageID: 1);
                      //     Container(
                      //   height: 165,
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Card(
                      //     child: Column(
                      //       children: [
                      //         Expanded(
                      //           child: Row(
                      //             children: [
                      //               // SizedBox(
                      //               //   width: 10,
                      //               // ),
                      //               Padding(
                      //                 padding: const EdgeInsets.all(10.0),
                      //                 child: Image.asset(
                      //                   "assets/images/sport.jpg",
                      //                   fit: BoxFit.cover,
                      //                   height: 140,
                      //                   width: 140,
                      //                 ),
                      //               ),
                      //               // SizedBox(
                      //               //   width: 5,
                      //               // ),
                      //               Expanded(
                      //                 child: Column(
                      //                   children: [
                      //                     Expanded(
                      //                       child: Text(
                      //                         "asdfasdfasdfasdfasdfsadf",
                      //                         // maxLines: 2,
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       child: Text(
                      //                         "asdfasdfasdfasdfasdfsadf",
                      //                         // maxLines: 2,
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       child: Text(
                      //                         "asdfasdfasdfasdfasdfsadf",
                      //                         // maxLines: 2,
                      //                       ),
                      //                     ),
                      //                     Expanded(
                      //                       child: Text(
                      //                         "asdfasdfasdfasdfasdfsadf",
                      //                         // maxLines: 2,
                      //                       ),
                      //                     ),
                      //                     // Text(
                      //                     //     "asdfasdfasdfasdfasdfsadf"),
                      //                     // Text(
                      //                     //     "asdfasdfasdfasdfasdfsadf"),
                      //                     // Text(
                      //                     //     "asdfasdfasdfasdfasdfsadf"),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     // ListTile(

                      //     //   title: Text(
                      //     //       'Item number $index as title'),
                      //     //   subtitle: const Text('Subtitle here'),
                      //     //   leading: const Icon(
                      //     //     Icons.ac_unit,
                      //     //     size: 88,
                      //     //   ),
                      //     // ),
                      //   ),
                      // );
                    },
                  )
                : Container(
                    margin: EdgeInsets.only(left: 1, right: 1),
                    child: ListView.builder(
                        controller: scrolcontrolller,
                        shrinkWrap: false,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount:
                            isloading ? allData.length + 1 : allData.length,
                        itemBuilder: (context, index) {
                          if (index < allData.length) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ArticleView(
                                            blogUrl: allData[index].url,
                                          )),
                                );
                              },
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ArticleView(
                                          blogUrl: allData[index].url!)));
                                },
                                child: BlogTile(
                                    category: allData[index].content!,
                                    created_at: allData[index].created_at!,
                                    imageUrl: allData[index].urlToImage!,
                                    title: allData[index].title!,
                                    url: allData[index].url!,
                                    languageID: widget.languageid),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: Center(
                                  child: CircularProgressIndicator(
                                // value: 0.5/,
                                strokeCap: StrokeCap.square,
                                // duration
                              )),
                            );
                          }
                        }),
                    //   );
                    // }
                  ));
  }

  bool showprogress = true;
  Future<void> controller() async {
    if (isloading) return;
    if (scrolcontrolller.position.pixels ==
        scrolcontrolller.position.maxScrollExtent) {
      setState(() {
        isloading = true;
      });
      page_number = page_number + 1;
      await getNews(widget.languageid);
      setState(() {
        isloading = false;
      });
    }
  }

  void starttimer() {
    Timer(Duration(seconds: 5), () {
      setState(() {
        showprogress = false;
      });
    });
  }

  Future onRefrish() async {
    setState(() {
      getNews(widget.languageid);
      CircularProgressIndicator();
    });
  }
}
