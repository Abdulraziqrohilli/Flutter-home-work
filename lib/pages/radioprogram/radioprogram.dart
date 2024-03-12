// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:hurriyat/models/radioprograms/Raido_programs.dart';
// import 'package:hurriyat/models/radioprograms/latest_radio-programm/Data.dart';
// import 'package:hurriyat/models/radioprograms/Data.dart';

// import 'package:hurriyat/models/radioprograms/latest_radio-programm/Latest_radio_programm.dart';
// import 'package:hurriyat/pages/Videos/videospage.dart';
// import 'package:hurriyat/pages/article_view.dart';
// import 'package:dio/dio.dart' as dio;
// import 'package:dio_http_cache/dio_http_cache.dart';

// import 'package:skeletonizer/skeletonizer.dart';

// class RadioPrograms extends StatefulWidget {
//   int languageid;
//   String name;
//   RadioPrograms({required this.languageid, required this.name});

//   @override
//   State<RadioPrograms> createState() => _AllNewsState();
// }

// class _AllNewsState extends State<RadioPrograms> {
//   // List<sliderModel> sliders = [];
//   List<Data> allData = [];
//   List<Datar> allDatas = [];
//   int page_number = 1;
//   bool isloading = false;
//   void initState() {
//     super.initState();

//     getlatestradio(widget.languageid);
//     getradio(widget.languageid);
//     scrolcontrolller.addListener(controller);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     scrolcontrolller.dispose();
//     super.dispose();
//   }

//   bool skeletonlooder = true;

//   final scrolcontrolller = ScrollController();
//   Future<void> getlatestradio(int languageid) async {
//     await Future.delayed(Duration(seconds: 2));
//     try {
//       dio.Dio _dio = dio.Dio();
//       // String url = "https://hurriyat.net/api/latest-radio-programs/$languageid";

//       String url =
//           "https://hurriyat.net/api/latest-radio-programs/$languageid?page=$page_number";
//       DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
//       dio.Options options =
//           buildCacheOptions(const Duration(seconds: 1), forceRefresh: false);
//       _dio.interceptors.add(dioCacheManager.interceptor);

//       dio.Response response = await _dio.get(
//         url,
//         options: options,
//         // queryParameters: {'page': page_number, 'pageSize': 10}
//       );
//       LatestRadioProgramm newresponse =
//           LatestRadioProgramm.fromJson(response.data);
//       // List<dynamic> responsedata=newresponse.data;
//       // List<ArticleModel> newdata=responsedata.map((e) => ArticalNews.fromJson(e)).toList();
//       // allData.addAll(newresponse.data);
//       setState(() {
//         allData = allData + newresponse.data;
//         skeletonlooder = false;
//       });
//       // return allData;
//     } on dio.DioError catch (e) {
//       print("this is the main error" + e.error);
//       // return null!;
//     }
//   }

//   Future<void> getradio(int languageid) async {
//     await Future.delayed(Duration(seconds: 2));
//     try {
//       dio.Dio _dio = dio.Dio();
//       // String url = "https://hurriyat.net/api/latest-radio-programs/$languageid";

//       String url =
//           "https://hurriyat.net/api/radio-programs/$languageid?page=$page_number";
//       DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
//       dio.Options options =
//           buildCacheOptions(const Duration(seconds: 1), forceRefresh: false);
//       _dio.interceptors.add(dioCacheManager.interceptor);

//       dio.Response response = await _dio.get(
//         url,
//         options: options,
//         // queryParameters: {'page': page_number, 'pageSize': 10}
//       );
//       RaidoPrograms newresponse = RaidoPrograms.fromJson(response.data);
//       // List<dynamic> responsedata=newresponse.data;
//       // List<ArticleModel> newdata=responsedata.map((e) => ArticalNews.fromJson(e)).toList();
//       // allData.addAll(newresponse.data);
//       setState(() {
//         allDatas = allDatas + newresponse.data;
//         skeletonlooder = false;
//       });
//       // return allData;
//     } on dio.DioError catch (e) {
//       print("this is the main error" + e.error);
//       // return null!;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             widget.name + " Radio Program".toString(),
//             style: TextStyle(
//                 color: Color.fromARGB(255, 0, 130, 185),
//                 fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           elevation: 0.0,
//         ),
//         body:
//             //  FutureBuilder<void>(
//             //     future: getNews(widget.languageid),
//             //     builder: (context, snapshot) {

//             //       if (snapshot.hasError) {
//             //         print(" error" + snapshot.error.toString());
//             //         return Center(
//             //           heightFactor: 23,
//             //           child:
//             //               // CircularProgressIndicator(),
//             //               Text("Please Wait..." + snapshot.hasError.toString()),
//             //         );
//             //       }

//             //       return

//             skeletonlooder
//                 ? SingleChildScrollView(
//                     child: Container(
//                       height: 1000,
//                       child: Skeletonizer(
//                         enabled: true,
//                         child: ListView.builder(
//                           itemCount: 10,
//                           itemBuilder: (context, index) {
//                             return
//                                 // BlogTile(
//                                 //     desc:
//                                 //         "sdfdasdfasdfasdfasdfasdfasdfasdf",
//                                 //     imageUrl: "sdfasdfasdf",
//                                 //     title: "sdfsdfgsdfgsdgdfsdf",
//                                 //     url: "",
//                                 //     languageID: 1);
//                                 Container(
//                               height: 165,
//                               padding: const EdgeInsets.all(8.0),
//                               child: Card(
//                                 child: Column(
//                                   children: [
//                                     Expanded(
//                                       child: Row(
//                                         children: [
//                                           // SizedBox(
//                                           //   width: 10,
//                                           // ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(10.0),
//                                             child: Image.asset(
//                                               "assets/images/sport.jpg",
//                                               fit: BoxFit.cover,
//                                               height: 140,
//                                               width: 140,
//                                             ),
//                                           ),
//                                           // SizedBox(
//                                           //   width: 5,
//                                           // ),
//                                           Expanded(
//                                             child: Column(
//                                               children: [
//                                                 Expanded(
//                                                   child: Text(
//                                                     "asdfasdfasdfasdfasdfsadf",
//                                                     // maxLines: 2,
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   child: Text(
//                                                     "asdfasdfasdfasdfasdfsadf",
//                                                     // maxLines: 2,
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   child: Text(
//                                                     "asdfasdfasdfasdfasdfsadf",
//                                                     // maxLines: 2,
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   child: Text(
//                                                     "asdfasdfasdfasdfasdfsadf",
//                                                     // maxLines: 2,
//                                                   ),
//                                                 ),
//                                                 // Text(
//                                                 //     "asdfasdfasdfasdfasdfsadf"),
//                                                 // Text(
//                                                 //     "asdfasdfasdfasdfasdfsadf"),
//                                                 // Text(
//                                                 //     "asdfasdfasdfasdfasdfsadf"),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 // ListTile(

//                                 //   title: Text(
//                                 //       'Item number $index as title'),
//                                 //   subtitle: const Text('Subtitle here'),
//                                 //   leading: const Icon(
//                                 //     Icons.ac_unit,
//                                 //     size: 88,
//                                 //   ),
//                                 // ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   )
//                 : widget.name == "Latest"
//                     ? Container(
//                         margin: EdgeInsets.symmetric(horizontal: 10.0),
//                         child: RefreshIndicator(
//                           onRefresh: onRefrish,
//                           child: ListView.builder(
//                               controller: scrolcontrolller,
//                               shrinkWrap: true,
//                               physics: ClampingScrollPhysics(),
//                               itemCount: isloading
//                                   ? allData.length + 1
//                                   : allData.length,
//                               itemBuilder: (context, index) {
//                                 if (index < allData.length) {
//                                   return GestureDetector(
//                                     onTap: () {
//                                       // Navigator.of(context).push(
//                                       //   MaterialPageRoute(
//                                       //       builder: (context) => ArticleView(
//                                       //             blogUrl: allData[index].url,
//                                       //           )),
//                                       // );
//                                     },
//                                     child: BlogTilev(
//                                         desc: "",
//                                         imageUrl: allData[index].image!,
//                                         title: "",
//                                         url: allData[index].id.toString(),
//                                         languageID: widget.languageid),
//                                   );
//                                 } else {
//                                   return const Padding(
//                                     padding: EdgeInsets.symmetric(vertical: 32),
//                                     child: Center(
//                                       child: CircularProgressIndicator(),
//                                     ),
//                                   );
//                                 }
//                               }),
//                         ),
//                         //   );
//                         // }
//                       )
//                     : Container(
//                         margin: EdgeInsets.symmetric(horizontal: 10.0),
//                         child: RefreshIndicator(
//                           onRefresh: onRefrish,
//                           child: ListView.builder(
//                               controller: scrolcontrolller,
//                               shrinkWrap: true,
//                               physics: ClampingScrollPhysics(),
//                               itemCount: isloading
//                                   ? allDatas.length + 1
//                                   : allDatas.length,
//                               itemBuilder: (context, index) {
//                                 if (index < allDatas.length) {
//                                   return GestureDetector(
//                                     onTap: () {
//                                       // Navigator.of(context).push(
//                                       //   MaterialPageRoute(
//                                       //       builder: (context) => ArticleView(
//                                       //             blogUrl: allData[index].url,
//                                       //           )),
//                                       // );
//                                     },
//                                     child: BlogTilev(
//                                         desc: "",
//                                         imageUrl: allDatas[index].image!,
//                                         title: "",
//                                         url: allDatas[index].id.toString(),
//                                         languageID: widget.languageid),
//                                   );
//                                 } else {
//                                   return const Padding(
//                                     padding: EdgeInsets.symmetric(vertical: 32),
//                                     child: Center(
//                                       child: CircularProgressIndicator(),
//                                     ),
//                                   );
//                                 }
//                               }),
//                         ),
//                         //   );
//                         // }
//                       ));
//   }

//   Future<void> controller() async {
//     if (isloading) return;
//     if (scrolcontrolller.position.pixels ==
//         scrolcontrolller.position.maxScrollExtent) {
//       setState(() {
//         isloading = true;
//       });
//       page_number = page_number + 1;
//       await getradio(widget.languageid);
//       await getlatestradio(widget.languageid);
//       setState(() {
//         isloading = false;
//       });
//     }
//   }

//   Future onRefrish() async {
//     setState(() {
//       getradio(widget.languageid);
//       getlatestradio(widget.languageid);
//       CircularProgressIndicator();
//     });
//   }
// }
