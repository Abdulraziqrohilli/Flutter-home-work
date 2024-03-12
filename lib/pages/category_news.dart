// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dio_http_cache/dio_http_cache.dart';
// import 'package:flutter/material.dart';
// import 'package:get/utils.dart';
// import 'package:hurriyat/models/category_model.dart';
// import 'package:hurriyat/models/show_category.dart';
// import 'package:hurriyat/pages/article_view.dart';
import 'package:hurriyat/models/show_category.dart';
import 'package:hurriyat/services/show_category_news.dart';
// import 'package:dio/dio.dart' as dio;
// import 'dart:ui' as ui;

import 'package:hurriyat/models/categroymodel.dart' as m;

// class CategoryNews extends StatefulWidget {
//   String name;
//   int languageid;
//   CategoryNews({required this.name, required this.languageid});

//   @override
//   State<CategoryNews> createState() => _CategoryNewsState();
// }

// class _CategoryNewsState extends State<CategoryNews> {
//   // List<ShowCategoryModel> categories = [];
//   // List<ShowCategoryModel> lancategories = [];

//   bool _loading = true;

//   @override
//   void initState() {
//     super.initState();
//     getNews();
//   }

//   // getNews() async {
//   //   ShowCategoryNews showCategoryNews = ShowCategoryNews();
//   //   await showCategoryNews.getCategoriesNews(
//   //       widget.name.toLowerCase(), widget.languageid);
//   //   categories = showCategoryNews.categories;
//   //   setState(() {
//   //     _loading = false;
//   //   });
//   // }
//   Future<List<ShowCategoryModel>> getNews() async {
//     try {
//       dio.Dio _dio = dio.Dio();

//       String url =
//           "https://hurriyat.net/api/news/category/${widget.name}/${widget.languageid}";
//       DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
//       dio.Options options =
//           buildCacheOptions(const Duration(hours: 6), forceRefresh: _loading);
//       _dio.interceptors.add(dioCacheManager.interceptor);

//       dio.Response response = await _dio.get(url, options: options);
//       m.CategoryModel newresponse = m.CategoryModel.fromJson(response.data);
//       setState(() {
//         _loading = false;
//       });
//       return newresponse.data;
//     } on dio.DioError catch (e) {
//       print("this is the main error" + e.error);
//       return null!;
//     }
//   }
//   // getNewsbyLanguage() async {

//   //   ShowCategoryNews showCategoryNews = ShowCategoryNews();
//   //   await showCategoryNews.getCategoriesNews(widget.name.toLowerCase(),1);
//   //   categories = showCategoryNews.categories;
//   //   setState(() {
//   //     _loading = false;
//   //   });
//   // }
//   // bool _loading = true, loading2 = true;
//   Future<void> _onrefresh() async {
//     Future.delayed(const Duration(seconds: 3), () {
//       CircularProgressIndicator();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.name.toString().tr,
//           style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         elevation: 0.0,
//       ),
//       body:
//           //  _loading
//           //     ? Center(child: CircularProgressIndicator())
//           //     :
//           FutureBuilder<List<ShowCategoryModel>>(
//               future: getNews(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: Column(
//                       children: [
//                         Text(
//                           "No Data are Availabe",
//                         )
//                       ],
//                     ),
//                   );
//                 }
//                 if (snapshot.connectionState == true) {
//                   // return
//                   _loading = false;
//                   // Center(
//                   //   child: Text("Networks Problems"),
//                   // );
//                 }
//                 // categories = snapshot.data;
//                 return Container(
//                   margin: EdgeInsets.symmetric(horizontal: 10.0),
//                   child: ListView.builder(
//                       shrinkWrap: true,
//                       physics: ClampingScrollPhysics(),
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         return ShowCategory(
//                           Image: snapshot.data![index].urlToImage!,
//                           desc: snapshot.data![index].content!,
//                           title: snapshot.data![index].title!,
//                           url: snapshot.data![index].url!,
//                           languageId: widget.languageid,

//                           // languageId: categories[index].url!
//                         );
//                       }),
//                 );
//               }),
//     );
//   }
// }

// class ShowCategory extends StatelessWidget {
//   String Image, desc, title;
//   int languageId;
//   String url;

//   // url;
//   ShowCategory(
//       {required this.Image,
//       required this.desc,
//       required this.title,
//       required this.url,
//       required this.languageId});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
//       },
//       child: Card(
//         child: Container(
//           padding: EdgeInsets.only(bottom: 3, left: 4, right: 4),
//           child: Column(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: CachedNetworkImage(
//                   imageUrl: Image,
//                   width: MediaQuery.of(context).size.width,
//                   height: 200,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               SizedBox(
//                 height: 5.0,
//               ),
//               // Text(
//               //   title,
//               //   maxLines: 2,
//               //   style: TextStyle(
//               //       color: Colors.black,
//               //       fontSize: 18.0,
//               //       fontWeight: FontWeight.bold),
//               // ),
//               Text(
//                 maxLines: 2,
//                 textAlign:
//                     //  TextAlign.center,
//                     languageId == 1 ? TextAlign.left : TextAlign.right,
//                 textDirection: languageId == 1
//                     ? ui.TextDirection.ltr
//                     : ui.TextDirection.rtl,
//                 title,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   fontFamily: languageId == 1 ? "Arial" : "Bahij",
//                 ),
//               ),
//               Text(
//                 maxLines: 3,
//                 textAlign:
//                     //  TextAlign.center,
//                     languageId == 1 ? TextAlign.left : TextAlign.right,
//                 textDirection: languageId == 1
//                     ? ui.TextDirection.ltr
//                     : ui.TextDirection.rtl,
//                 desc.tr,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 16,
//                   fontFamily: languageId == 1 ? "Arial" : "Bahij",
//                 ),
//               ),
//               // Text(
//               //   desc.tr,
//               //   maxLines: 3,
//               // ),
//               // SizedBox(
//               //   height: 20.0,
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
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
import 'package:hurriyat/widgets/NoData.dart';
import 'package:hurriyat/widgets/blogtile.dart';
import 'package:hurriyat/widgets/skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryPage extends StatefulWidget {
  int languageid;
  String name;
  CategoryPage({required this.languageid, required this.name});

  @override
  State<CategoryPage> createState() => _AllNewsState();
}

class _AllNewsState extends State<CategoryPage> {
  // List<sliderModel> sliders = [];
  List<ShowCategoryModel> allData = [];
  // List<ShowCategoryModel> categories = [];

  int page_number = 1;
  bool isloading = false;
  void initState() {
    super.initState();

    getNews();
    scrolcontrolller.addListener(controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrolcontrolller.dispose();
    super.dispose();
  }

  bool skeletonlooder = true;

  final scrolcontrolller = ScrollController();
  Future<void> getNews() async {
    await Future.delayed(Duration(seconds: 2));
    try {
      dio.Dio _dio = dio.Dio();
      // String url =
      //     "https://hurriyat.net/api/news/category/${widget.name}/${widget.languageid}";
      String url =
          "https://hurriyat.net/api/news/category/${widget.name}/${widget.languageid}?page=$page_number";
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      dio.Options options =
          buildCacheOptions(const Duration(seconds: 1), forceRefresh: false);
      _dio.interceptors.add(dioCacheManager.interceptor);

      dio.Response response = await _dio.get(
        url,
        options: options,
        // queryParameters: {'page': page_number, 'pageSize': 10}
      );
      m.CategoryModel newresponse = m.CategoryModel.fromJson(response.data);
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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name.toString(),
            style: TextStyle(
                color: Color.fromARGB(255, 0, 130, 185),
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body:
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
                ? SingleChildScrollView(
                    child: Container(
                      height: 1000,
                      child: Skeletonizer(
                        enabled: true,
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return SkeletonWidget();
                            // BlogTile(
                            //     desc:
                            //         "sdfdasdfasdfasdfasdfasdfasdfasdf",
                            //     imageUrl: "sdfasdfasdf",
                            //     title: "sdfsdfgsdfgsdgdfsdf",
                            //     url: "",
                            //     languageID: 1);
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
                        ),
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
                              itemCount: isloading
                                  ? allData.length + 1
                                  : allData.length,
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
                                    child: BlogTile(
                                      category: allData[index].description.toString(),
                                      created_at: allData[index].createAt.toString(),

                                        imageUrl: allData[index].urlToImage!,
                                        title: allData[index].title!,
                                        url: allData[index].url!,
                                        languageID: widget.languageid),
                                  );
                                } else {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 32),
                                    child: Column(
                                      children: [
                                        // SkeletonWidget(),
                                        Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ],
                                    ),
                                  );
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
      page_number = page_number + 1;
      await getNews();
      setState(() {
        isloading = false;
      });
    }
  }

  Future onRefrish() async {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        getNews();
        CircularProgressIndicator();
      });
    });
  }
}
