// import 'dart:convert';

// import 'package:api_cache_manager/models/cache_db_model.dart';
// import 'package:api_cache_manager/utils/cache_manager.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hurriyat/models/radioprograms/latest_radio-programm/Data.dart';
// import 'package:hurriyat/models/radioprograms/latest_radio-programm/Latest_radio_programm.dart';
// import 'package:hurriyat/pages/Videos/videospage.dart';
// import 'package:hurriyat/pages/article_view.dart';
// import 'package:hurriyat/pages/radioprogram/details.dart';
// import 'package:http/http.dart' as http;
// import 'dart:ui' as ui;

// import 'package:hurriyat/pages/radioprogram/details1.dart';
// import 'package:hurriyat/services/radioprogram/latestradioPrograms.dart';
// import 'package:hurriyat/services/radioprogram/latestradioprogramdio.dart';
// import 'package:hurriyat/models/radioprograms/Data.dart' as rd;
// import 'package:hurriyat/models/radioprograms/Raido_programs.dart' as r;
// import 'package:hurriyat/services/radioprogram/radioprogramdata.dart';
// import 'package:sembast/sembast.dart';
// import 'package:dio/dio.dart';
// import 'package:dio/dio.dart' as dio;
// import 'package:dio_http_cache/dio_http_cache.dart';

// class sLatestRadioProgramsPage extends StatefulWidget {
//   int languageid;
//   String? name;
//   sLatestRadioProgramsPage({required this.languageid, required this.name});

//   @override
//   State<sLatestRadioProgramsPage> createState() => _AllNewsState();
// }

// class _AllNewsState extends State<sLatestRadioProgramsPage> {
//   // List<Data> latestradioPrograms = [];
//   // bool _loading = true;
//   // ignore: annotate_overrides
//   // void initState() {
//   //   // getlatestradioprogram();

//   //   _onrefresh();
//   //   super.initState();
//   // }

//   // Future<void> _onrefresh() async {
//   //   // Future.delayed(Duration(seconds: 2), () {
//   //   //   CircularProgressIndicator();
//   //   // });
//   //   // loading2 = false;
//   //   Future.delayed(Duration(milliseconds: 100), () {
//   //     _loading = false;
//   //   });
//   // }

//   // () async {
//   //   LatestRadioProgram newsclass = LatestRadioProgram();
//   //   await newsclass.getlatestradioprogram(widget.languageid);
//   //   latestradioPrograms = newsclass.latestradioprograms;
//   //   setState(() {});
//   // }
//   //  Future<List<Data>> getNews() async {
//   //   try {
//   //     dio.Dio _dio = dio.Dio();

//   //     String url =
//   //         "https://hurriyat.net/api/news/category/${widget.name}/${widget.languageid}";
//   //     DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
//   //     dio.Options options =
//   //         buildCacheOptions(const Duration(hours: 6), forceRefresh:true);
//   //     _dio.interceptors.add(dioCacheManager.interceptor);

//   //     dio.Response response = await _dio.get(url, options: options);
//   //     latestradi newresponse = m.CategoryModel.fromJson(response.data);
//   //     setState(() {
//   //       _loading = false;
//   //     });
//   //     return newresponse.data;
//   //   } on dio.DioError catch (e) {
//   //     print("this is the main error" + e.error);
//   //     return null!;
//   //   }
//   // }
//   // Future<dynamic> getlatestradioprogram() async {
//   //   var isCacheExist = await APICacheManager().isAPICacheKeyExist("of");
//   //   if (!isCacheExist) {
//   //     print("online data");

//   //     final response = await http
//   //         .get(Uri.parse('https://hurriyat.net/api/latest-radio-programs/2'));
//   //     var data = jsonDecode(response.body.toString());
//   //     APICacheDBModel dbModel =
//   //         new APICacheDBModel(key: "of", syncData: response.body);
//   //     await APICacheManager().addCacheData(dbModel);
//   //     if (response.statusCode == 200) {
//   //       return LatestRadioProgramm.fromJson(data).data?.toList();
//   //     } else {
//   //       return LatestRadioProgramm.fromJson(data).data?.toList();
//   //     }
//   //   } else {
//   //     print("offline data");
//   //     var cacheData = await APICacheManager().getCacheData("of");
//   //     return LatestRadioProgramm.fromJson(cacheData.syncData);
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.name! + " Programs".toString(),
//           style: TextStyle(
//               color: Color.fromARGB(255, 0, 130, 185),
//               fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         elevation: 0.0,
//       ),
//       body:
//           // RefreshIndicator(
//           //   displacement: 250,
//           //   backgroundColor: Colors.white,
//           //   color: Colors.red,
//           //   strokeWidth: 3,
//           //   triggerMode: RefreshIndicatorTriggerMode.onEdge,
//           //   onRefresh: () async {
//           //     await Future.delayed(Duration(seconds: 3));
//           //     setState(() {
//           //       // getallpost();
//           //       // CircularProgressIndicator();
//           //       _loading ? Center(child: CircularProgressIndicator()) : initState();
//           //       // Center(
//           //       //   child: Text("Please Wait"),
//           //       // );
//           //       //  _onrefresh();
//           //     });
//           //   },
//           //   child: _loading
//           //       ? Center(child: CircularProgressIndicator())
//           //       :
//           SafeArea(
//         child: SingleChildScrollView(
//           child: widget.name == "Radio"
//               ? FutureBuilder<List<rd.Data>?>(
//                   future:
//                       RadioProgramDio().getradioprogramDio(widget.languageid),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//                       return Center(
//                         heightFactor: 23,
//                         child: CircularProgressIndicator(),
//                         // Text("Please Wait..."),
//                       );
//                     }

//                     return ListView.builder(
//                         shrinkWrap: true,
//                         physics: ClampingScrollPhysics(),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () {
//                               // MaterialPageRoute(
//                               //             builder: (context) => VideoDetails(
//                               //                   languageId: widget.languageid,
//                               //                   content: snapshot.data![index]
//                               //                       .content
//                               //                       .toString(),
//                               //                   createdAt: snapshot.data![index]
//                               //                       .createdAt
//                               //                       .toString(),
//                               //                   title: snapshot.data![index]
//                               //                       .title
//                               //                       .toString(),
//                               //                   user: snapshot.data![index]
//                               //                       .user
//                               //                       .toString(),
//                               //                   videoId: snapshot.data![index]
//                               //                       .videoId
//                               //                       .toString(),
//                               //                   videoType:
//                               //                       snapshot.data![index].videoType,
//                               //                   views: snapshot.data![index].views,
//                               //                 ));
//                             },
//                             child: BlogTilev(
//                                 desc: "desc",
//                                 imageUrl: snapshot.data![index].image.toString(),
//                                 title: "",
//                                 url: snapshot.data![index].user.toString(),
//                                 languageID: widget.languageid),
//                           );

//                           //  RadioProgramSections(
//                           //   url: widget.languageid,
//                           //   Images: snapshot.data![index].image.toString(),
//                           //   url1: snapshot.data![index].id,
//                           //   host: snapshot.data![index].content.toString(),
//                           //   title: snapshot.data![index].title.toString(),
//                           //   user: snapshot.data![index].user.toString(),
//                           //   view: snapshot.data![index].views.toString(),
//                           // );
//                         });
//                   })
//               : FutureBuilder<List<Data>>(
//                   future: LatestRadioProgramDio()
//                       .getlatestradioprogramDio(widget.languageid),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//                       return Center(
//                         heightFactor: 23,
//                         child: CircularProgressIndicator(),
//                         // Text("Please Wait..."),
//                       );
//                     }

//                     return ListView.builder(
//                         shrinkWrap: true,
//                         physics: ClampingScrollPhysics(),
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context, index) {
//                           return BlogTilev(
//                               desc: "desc",
//                               imageUrl: snapshot.data![index].image.toString(),
//                               title: "",
//                               url: snapshot.data![index].user.toString(),
//                               languageID: widget.languageid);
//                           //  RadioProgramSection(
//                           //   url: widget.languageid,
//                           //   Images: snapshot.data![index].image.toString(),
//                           //   url1: snapshot.data![index].id,
//                           //   host: snapshot.data![index].host.toString(),
//                           //   title: snapshot.data![index].title.toString(),
//                           //   user: snapshot.data![index].user.toString(),
//                           //   view: snapshot.data![index].views.toString(),
//                           // );
//                         });
//                   }),
//         ),
//       ),
//     );
//   }
// }

// class RadioProgramSection extends StatelessWidget {
//   String Images, host, title, user;
//   String view;
//   int url;
//   int? url1;
//   RadioProgramSection({
//     required this.Images,
//     required this.host,
//     required this.title,
//     required this.view,
//     required this.user,
//     required this.url,
//     required this.url1,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ArticleView(blogUrl: url1.toString())));
//       },
//       child: Card(
//         child: Container(
//           margin: EdgeInsets.only(left: 5, right: 5),
//           child: Column(
//             children: [
//               Stack(children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: CachedNetworkImage(
//                     imageUrl: Images,
//                     width: MediaQuery.of(context).size.width,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Positioned(
//                     bottom: 88,
//                     left: 155,
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => RadioDetails(
//                                   url: url.toString(),
//                                 )));
//                       },
//                       child: CircleAvatar(
//                           radius: 18,
//                           backgroundColor: Colors.red,
//                           child: Icon(Icons.play_arrow)),
//                     ))
//                 // CircleAvatar(child: Image(image: AssetImage("assets/images/youtube11.jpg"))))
//               ]),
//               SizedBox(
//                 height: 7,
//               ),
//               Text(
//                 title,
//                 maxLines: 3,
//                 textAlign:
//                     //  TextAlign.center,
//                     url == 1 ? TextAlign.left : TextAlign.right,
//                 textDirection:
//                     url == 1 ? ui.TextDirection.ltr : ui.TextDirection.rtl,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w900,
//                   fontSize: 18,
//                   fontFamily: url == 1 ? "Arial" : "Bahij",
//                 ),
//               ),
//               // Row(
//               //   // crossAxisAlignment:
//               //   //     CrossAxisAlignment.center,
//               //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               //   children: [
//               //     Text(
//               //       textAlign: url.toString() == '1'
//               //           ? TextAlign.left
//               //           : TextAlign.right,
//               //       textDirection: url.toString() == '1'
//               //           ? ui.TextDirection.ltr
//               //           : ui.TextDirection.rtl,
//               //       view.toString(),
//               //       style: TextStyle(
//               //         fontWeight: FontWeight.w500,
//               //         fontSize: 12,
//               //         fontFamily: url.toString() == '1' ? "Arial" : "Bahij",
//               //       ),
//               //     ),
//               //     SizedBox(
//               //       width: 3,
//               //     ),
//               //     Icon(
//               //       Icons.remove_red_eye,
//               //       size: 19,
//               //     ),
//               //     SizedBox(
//               //       width: 15,
//               //     ),
//               //     Text(
//               //       textAlign: url.toString() == '1'
//               //           ? TextAlign.left
//               //           : TextAlign.right,
//               //       textDirection: url.toString() == '1'
//               //           ? ui.TextDirection.ltr
//               //           : ui.TextDirection.rtl,
//               //       user.toString(),
//               //       style: TextStyle(
//               //         fontWeight: FontWeight.w400,
//               //         fontSize: 15,
//               //         fontFamily: url.toString() == '1' ? "Arial" : "Bahij",
//               //       ),
//               //     ),
//               //     SizedBox(
//               //       width: 3,
//               //     ),
//               //     Icon(
//               //       Icons.person,
//               //       size: 19,
//               //     ),
//               //     SizedBox(
//               //       width: 15,
//               //     ),
//               //     Text(
//               //       textAlign: url.toString() == '1'
//               //           ? TextAlign.left
//               //           : TextAlign.right,
//               //       textDirection: url.toString() == '1'
//               //           ? ui.TextDirection.ltr
//               //           : ui.TextDirection.rtl,
//               //       host.toString(),
//               //       style: TextStyle(
//               //         fontWeight: FontWeight.w400,
//               //         fontSize: 15,
//               //         fontFamily: url.toString() == '1' ? "Arial" : "Bahij",
//               //       ),
//               //     ),
//               //     SizedBox(
//               //       width: 3,
//               //     ),
//               //     Icon(
//               //       Icons.person_pin,
//               //       size: 19,
//               //     ),
//               //   ],
//               // ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         view,
//                         // maxLines: 1,
//                         // textAlign:
//                         //     //  TextAlign.center,
//                         //     url == 1 ? TextAlign.left : TextAlign.right,
//                         // textDirection: url == 1
//                         //     ? ui.TextDirection.ltr
//                         //     : ui.TextDirection.rtl,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16,
//                           fontFamily: "Arial",
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Icon(
//                         Icons.remove_red_eye,
//                         size: 24,
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         user,
//                         maxLines: 1,
//                         textAlign:
//                             //  TextAlign.center,
//                             url == 1 ? TextAlign.left : TextAlign.right,
//                         textDirection: url == 1
//                             ? ui.TextDirection.ltr
//                             : ui.TextDirection.rtl,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16,
//                           fontFamily: "Arial",
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Icon(
//                         Icons.person,
//                         size: 24,
//                       ),
//                     ],
//                   ),
//                   Row(
//                     // crossAxisAlignment: CrossAxisAlignment.baseline,
//                     children: [
//                       Container(
//                         width: 120,
//                         child: Text(
//                           host,
//                           maxLines: 3,
//                           textAlign:
//                               //  TextAlign.center,
//                               url == 1 ? TextAlign.left : TextAlign.right,
//                           textDirection: url == 1
//                               ? ui.TextDirection.ltr
//                               : ui.TextDirection.rtl,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 18,
//                             fontFamily: url == 1 ? "Arial" : "Bahij",
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Icon(
//                         Icons.person_pin,
//                         size: 24,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class RadioProgramSections extends StatelessWidget {
//   String Images, host, title, user;
//   String view;
//   int url;
//   int? url1;
//   RadioProgramSections({
//     required this.Images,
//     required this.host,
//     required this.title,
//     required this.view,
//     required this.user,
//     required this.url,
//     required this.url1,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ArticleView(blogUrl: url1.toString())));
//       },
//       child: Card(
//         child: Container(
//           margin: EdgeInsets.only(left: 5, right: 5),
//           child: Column(
//             children: [
//               Stack(children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: CachedNetworkImage(
//                     imageUrl: Images,
//                     width: MediaQuery.of(context).size.width,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Positioned(
//                     bottom: 88,
//                     left: 155,
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => RadioDetails(
//                                   url: url.toString(),
//                                 )));
//                       },
//                       child: CircleAvatar(
//                           radius: 18,
//                           backgroundColor: Colors.red,
//                           child: Icon(Icons.play_arrow)),
//                     ))
//                 // CircleAvatar(child: Image(image: AssetImage("assets/images/youtube11.jpg"))))
//               ]),
//               SizedBox(
//                 height: 7,
//               ),
//               Text(
//                 title,
//                 maxLines: 3,
//                 textAlign:
//                     //  TextAlign.center,
//                     url == 1 ? TextAlign.left : TextAlign.right,
//                 textDirection:
//                     url == 1 ? ui.TextDirection.ltr : ui.TextDirection.rtl,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w900,
//                   fontSize: 18,
//                   fontFamily: url == 1 ? "Arial" : "Bahij",
//                 ),
//               ),
//               // Row(
//               //   // crossAxisAlignment:
//               //   //     CrossAxisAlignment.center,
//               //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               //   children: [
//               //     Text(
//               //       textAlign: url.toString() == '1'
//               //           ? TextAlign.left
//               //           : TextAlign.right,
//               //       textDirection: url.toString() == '1'
//               //           ? ui.TextDirection.ltr
//               //           : ui.TextDirection.rtl,
//               //       view.toString(),
//               //       style: TextStyle(
//               //         fontWeight: FontWeight.w500,
//               //         fontSize: 12,
//               //         fontFamily: url.toString() == '1' ? "Arial" : "Bahij",
//               //       ),
//               //     ),
//               //     SizedBox(
//               //       width: 3,
//               //     ),
//               //     Icon(
//               //       Icons.remove_red_eye,
//               //       size: 19,
//               //     ),
//               //     SizedBox(
//               //       width: 15,
//               //     ),
//               //     Text(
//               //       textAlign: url.toString() == '1'
//               //           ? TextAlign.left
//               //           : TextAlign.right,
//               //       textDirection: url.toString() == '1'
//               //           ? ui.TextDirection.ltr
//               //           : ui.TextDirection.rtl,
//               //       user.toString(),
//               //       style: TextStyle(
//               //         fontWeight: FontWeight.w400,
//               //         fontSize: 15,
//               //         fontFamily: url.toString() == '1' ? "Arial" : "Bahij",
//               //       ),
//               //     ),
//               //     SizedBox(
//               //       width: 3,
//               //     ),
//               //     Icon(
//               //       Icons.person,
//               //       size: 19,
//               //     ),
//               //     SizedBox(
//               //       width: 15,
//               //     ),
//               //     Text(
//               //       textAlign: url.toString() == '1'
//               //           ? TextAlign.left
//               //           : TextAlign.right,
//               //       textDirection: url.toString() == '1'
//               //           ? ui.TextDirection.ltr
//               //           : ui.TextDirection.rtl,
//               //       host.toString(),
//               //       style: TextStyle(
//               //         fontWeight: FontWeight.w400,
//               //         fontSize: 15,
//               //         fontFamily: url.toString() == '1' ? "Arial" : "Bahij",
//               //       ),
//               //     ),
//               //     SizedBox(
//               //       width: 3,
//               //     ),
//               //     Icon(
//               //       Icons.person_pin,
//               //       size: 19,
//               //     ),
//               //   ],
//               // ),

//               Column(
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         host,
//                         maxLines: 2,
//                         textAlign:
//                             //  TextAlign.center,
//                             url == 1 ? TextAlign.left : TextAlign.right,
//                         textDirection: url == 1
//                             ? ui.TextDirection.ltr
//                             : ui.TextDirection.rtl,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 18,
//                           fontFamily: url == 1 ? "Arial" : "Bahij",
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         view,
//                         // maxLines: 1,
//                         // textAlign:
//                         //     //  TextAlign.center,
//                         //     url == 1 ? TextAlign.left : TextAlign.right,
//                         // textDirection: url == 1
//                         //     ? ui.TextDirection.ltr
//                         //     : ui.TextDirection.rtl,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16,
//                           fontFamily: "Arial",
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Icon(
//                         Icons.remove_red_eye,
//                         size: 24,
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     width: 80,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         user,
//                         maxLines: 1,
//                         textAlign:
//                             //  TextAlign.center,
//                             url == 1 ? TextAlign.left : TextAlign.right,
//                         textDirection: url == 1
//                             ? ui.TextDirection.ltr
//                             : ui.TextDirection.rtl,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16,
//                           fontFamily: "Arial",
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Icon(
//                         Icons.person,
//                         size: 24,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
