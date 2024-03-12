import 'package:carousel_slider/carousel_slider.dart';
import 'package:hurriyat/models/show_category.dart';

// import 'package:dio/dio.dart' as dio;
// import 'dart:ui' as ui;

import 'package:hurriyat/models/categroymodel.dart' as m;

import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:hurriyat/models/Slider.dart';
import 'package:hurriyat/models/artical.dart';
import 'package:hurriyat/models/article_model.dart';
import 'package:hurriyat/models/slider_model.dart';
import 'package:hurriyat/pages/article_view.dart';
import 'package:hurriyat/pages/home.dart';
import 'package:hurriyat/services/news.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_html/flutter_html.dart' as style;

import 'package:hurriyat/services/slider_data.dart';
import 'package:hurriyat/widgets/NoData.dart';
import 'package:hurriyat/widgets/blogtile.dart';
import 'package:hurriyat/widgets/skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryPageRow extends StatefulWidget {
  int languageid;
  String name;
  CategoryPageRow({required this.languageid, required this.name});

  @override
  State<CategoryPageRow> createState() => _AllNewsState();
}

class _AllNewsState extends State<CategoryPageRow> {
  // List<sliderModel> sliders = [];
  // List<ShowCategoryModel> allData = [];
  // List<ShowCategoryModel> categories = [];

  int page_number = 1;
  bool isloading = false;
  bool _loading = true, loading2 = true;
  int activeIndex = 0;
  void initState() {
    super.initState();

    // getNews();
    // scrolcontrolller.addListener(controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrolcontrolller.dispose();
    super.dispose();
  }

  bool skeletonlooder = true;

  final scrolcontrolller = ScrollController();
  // Future<void> getNews() async {
  //   await Future.delayed(Duration(seconds: 2));
  //   try {
  //     dio.Dio _dio = dio.Dio();
  //     // String url =
  //     //     "https://hurriyat.net/api/news/category/${widget.name}/${widget.languageid}";
  //     String url =
  //         "https://hurriyat.net/api/news/category/${widget.name}/${widget.languageid}?page=$page_number";
  //     DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
  //     dio.Options options =
  //         buildCacheOptions(const Duration(seconds: 1), forceRefresh: false);
  //     _dio.interceptors.add(dioCacheManager.interceptor);

  //     dio.Response response = await _dio.get(
  //       url,
  //       options: options,
  //       // queryParameters: {'page': page_number, 'pageSize': 10}
  //     );
  //     m.CategoryModel newresponse = m.CategoryModel.fromJson(response.data);
  //     // List<dynamic> responsedata=newresponse.data;
  //     // List<ArticleModel> newdata=responsedata.map((e) => ArticalNews.fromJson(e)).toList();
  //     // allData.addAll(newresponse.data);
  //     setState(() {
  //       allData = allData + newresponse.data;
  //       skeletonlooder = false;
  //     });
  //     // return allData;
  //   } on dio.DioError catch (e) {
  //     print("this is the main error" + e.error);
  //     // return null!;
  //   }
  // }

  Future<List<SliderModel>> getSlider(int languageid) async {
    try {
      dio.Dio _dio = dio.Dio();

      String url =
          "https://hurriyat.net/api/news/category/${widget.name}/${widget.languageid}";
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      dio.Options options = buildCacheOptions(const Duration(seconds: 4),
          forceRefresh: false, maxStale: Duration(days: 7));
      _dio.interceptors.add(dioCacheManager.interceptor);

      dio.Response response = await _dio.get(url, options: options);
      SliderNews newresponse = SliderNews.fromJson(response.data);
      // if(response.co)
      skeletonlooder = false;
      loading2 = false;
      _loading = false;
      return newresponse.data;
    } on dio.DioError catch (e) {
      print("this is the main error" + e.error);
      // ignore: null_check_always_fails
      return null!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // appBar: AppBar(
      //   title: Text(
      //     widget.name.toString(),
      //     style: TextStyle(
      //         color: Color.fromARGB(255, 0, 130, 185),
      //         fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      //   elevation: 0.0,
      // ),
      child:
          // loading2
          // ? Container(
          //     height: 200,
          //     width: 250,
          //     child: CarouselSlider.builder(
          //         // carouselController: CarouselController(),

          //         itemCount: 5,
          //         itemBuilder: (context, index, realIndex) {
          //           // String? res =
          //           //     snapshot.data![index].urlToImage;
          //           // String? res1 =
          //           //     snapshot.data![index].title;
          //           // String? res3 =
          //           //     snapshot.data![index].content;

          //           // // int? res2 =
          //           // //     snapshot.data![index].languageId;
          //           // String? url = snapshot.data![index].url;
          //           return Skeletonizer(
          //             enabled: true,
          //             child: Image.asset("assets/images/sport.jpg"),
          //           );
          //         },
          //         options: CarouselOptions(
          //             reverse: widget.languageid == 1 ? false : true,
          //             height: 180,
          //             autoPlay: true,
          //             enlargeCenterPage: true,
          //             enlargeStrategy: CenterPageEnlargeStrategy.height,
          //             onPageChanged: (index, reason) {
          //               setState(() {
          //                 activeIndex = index;
          //               });
          //             })),
          //   )
          // :
          FutureBuilder<List<SliderModel>>(
              future: getSlider(widget.languageid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CarouselSlider.builder(
                      itemCount: 3,
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
                          height: 140,
                          width: 250,
                          child: Skeletonizer(
                            enabled: true,
                            child: Image.asset("assets/images/sport.jpg"),
                          ),
                        );
                      },
                      options: CarouselOptions(
                          reverse: widget.languageid == 1 ? false : true,
                          height: 140,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
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
                        Text("Please Wait..." + snapshot.hasError.toString()),
                  );
                }

                return CarouselSlider.builder(
                    itemCount: 3,
                    itemBuilder: (context, index, realIndex) {
                      String? res = snapshot.data![index].urlToImage;
                      String? res1 = snapshot.data![index].title;
                      String? res3 = snapshot.data![index].content;

                      // int? res2 =
                      //     snapshot.data![index].languageId;
                      String? url = snapshot.data![index].url;
                      return GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ArticleView(
                                      blogUrl: url,
                                    ))),
                        child: buildImage(
                            image: res,
                            languageId: widget.languageid,
                            categorys: res3,
                            index: index,
                            name: res1
                            // res!, index, res1, res2, res3
                            ),
                      );
                    },
                    options: CarouselOptions(
                        reverse: widget.languageid == 1 ? false : true,
                        height: 150,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        }));
              }),
      // : Container(
      //     margin: EdgeInsets.symmetric(horizontal: 10.0),
      //     child: RefreshIndicator(
      //       onRefresh: onRefrish,
      //       child: ListView.builder(
      //           controller: scrolcontrolller,
      //           shrinkWrap: true,
      //           physics: ClampingScrollPhysics(),
      //           itemCount: isloading
      //               ? allData.length + 1
      //               : allData.length,
      //           itemBuilder: (context, index) {
      //             if (index < allData.length) {
      //               return GestureDetector(
      //                 onTap: () {
      //                   Navigator.of(context).push(
      //                     MaterialPageRoute(
      //                         builder: (context) => ArticleView(
      //                               blogUrl: allData[index].url,
      //                             )),
      //                   );
      //                 },
      //                 child: BlogTile(
      //                   category: allData[index].description.toString(),
      //                     desc: allData[index].content!,
      //                     imageUrl: allData[index].urlToImage!,
      //                     title: allData[index].title!,
      //                     url: allData[index].url!,
      //                     languageID: widget.languageid),
      //               );
      //             } else {
      //               return Padding(
      //                 padding: EdgeInsets.symmetric(vertical: 32),
      //                 child: Column(
      //                   children: [
      //                     // SkeletonWidget(),
      //                     Center(
      //                       child: CircularProgressIndicator(),
      //                     ),
      //                   ],
      //                 ),
      //               );
      //             }
      //           }),
      //     ),
      //     //   );
      //     // }
      //   )
    );
  }

  // Future<void> controller() async {
  //   if (isloading) return;
  //   if (scrolcontrolller.position.pixels ==
  //       scrolcontrolller.position.maxScrollExtent) {
  //     setState(() {
  //       isloading = true;
  //     });
  //     page_number = page_number + 1;
  //     await getNews();
  //     setState(() {
  //       isloading = false;
  //     });
  //   }
  // }

  // Future onRefrish() async {
  //   Future.delayed(Duration(seconds: 2), () {
  //     setState(() {
  //       getNews();
  //       CircularProgressIndicator();
  //     });
  //   });
  // }

  Widget buildImage(
          {String? image,
          int? index,
          String? name,
          int? languageId,
          String? categorys}) =>
      Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 150,
                fit: BoxFit.cover,
                width: MediaQuery.of(context as BuildContext).size.width,
                imageUrl: image.toString(),
                placeholder: (context, url) => Skeletonizer(
                    // enabled: true,
                    child: Container(
                  width: double.infinity,
                  height: 190,
                  child: Image.asset("assets/logos/logo@2x.png"),
                )),
                errorWidget: (context, url, error) {
                  debugPrint(error.toString());

                  return Container(
                    width: double.infinity,
                    height: 150,
                    child: Image.asset("assets/logos/logo@2x.png",
                        fit: BoxFit.cover),
                  );
                },
              ),
            ),
            languageId == 1
                ? Positioned(
                    top: 10,
                    left: 10,
                    child: Center(
                        child: Container(
                      // width: 180,
                      //  padding: EdgeInsets.only(left: 0.0),
                      // margin: EdgeInsets.only(top: 170.0),
                      // width: MediaQuery.of(context as BuildContext).size.width,
                      decoration: BoxDecoration(
                          color: Home.isclick ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      padding: EdgeInsets.only(right: 5, left: 5),
                      // : EdgeInsets.only(left: 9),
                      child: Text(
                        maxLines: 1,
                        textAlign:
                            languageId == 1 ? TextAlign.left : TextAlign.right,
                        // _languageId != 1 ? TextAlign.left : TextAlign.center,
                        textDirection: languageId == 1
                            ? ui.TextDirection.ltr
                            : ui.TextDirection.rtl,
                        categorys.toString().tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: "Bahij",
                          color: Home.isclick ? Colors.white : Colors.black,
                        ),
                      ),
                    )),
                  )
                : Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      // width: 180,
                      //  padding: EdgeInsets.only(left: 0.0),
                      // margin: EdgeInsets.only(top: 170.0),
                      // width: MediaQuery.of(context as BuildContext).size.width,
                      decoration: BoxDecoration(
                          color: Home.isclick ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      padding: EdgeInsets.only(right: 5, left: 5),
                      // : EdgeInsets.only(left: 9),
                      child: FittedBox(
                        child: Text(
                          maxLines: 2,
                          textAlign: languageId == 1
                              ? TextAlign.left
                              : TextAlign.right,
                          textDirection: languageId == 1
                              ? ui.TextDirection.ltr
                              : ui.TextDirection.rtl,
                          categorys.toString().tr,
                          style: TextStyle(
                            color: Home.isclick ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: "Bahij",
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              width: 5,
            ),
            Container(
              height: 150,
              padding: EdgeInsets.only(bottom: 5, left: 3, right: 3, top: 3),
              //     ? EdgeInsets.only(left: 10)
              //     : EdgeInsets.only(right: 10),
              margin: EdgeInsets.only(top: 100.0),
              width: MediaQuery.of(context as BuildContext).size.width,
              decoration: BoxDecoration(
                  // border: Border.all(width: 0.4, color: Colors.grey),
                  color: Home.isclick ? Colors.black54 : Colors.white70,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
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
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      shadows: [
                        Shadow(
                            // color: const Color.fromARGB(255, 194, 14, 2),
                            offset: Offset(0.0, 0.5),
                            blurRadius: 0.5),
                      ],
                      height: 1,
                      color: Home.isclick ? Colors.white : Colors.black,

                      // shadows: 3,
                      fontFamily: "Bahij",
                    ),
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
}
