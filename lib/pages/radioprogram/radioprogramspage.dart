// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:hurriyat/models/article_model.dart';
// import 'package:hurriyat/models/radioprograms/Data.dart';
// import 'package:hurriyat/models/slider_model.dart';
// import 'package:hurriyat/pages/Videos/videospage.dart';
// import 'package:hurriyat/pages/article_view.dart';
// import 'package:hurriyat/services/news.dart';
// import 'package:flutter_html/flutter_html.dart' as style;
// import 'package:hurriyat/services/radioprogram/radioprogramdata.dart';

// import 'package:hurriyat/services/slider_data.dart';

// class RadioProgramsPage extends StatefulWidget {
//   int languageid;
//   RadioProgramsPage({required this.languageid});

//   @override
//   State<RadioProgramsPage> createState() => _AllNewsState();
// }

// class _AllNewsState extends State<RadioProgramsPage> {
//   List<Data> radioPrograms = [];
//   bool _loading = true;
//   void initState() {
//     // getradioprogram();

//     _onrefresh();
//     super.initState();
//   }

//   // getradioprogram() async {
//   //   RadioProgram newsclass = RadioProgram();
//   //   await newsclass.getradioprogram(widget.languageid);
//   //   radioPrograms = newsclass.radioprograms;
//   //   setState(() {});
//   // }

//   Future<void> _onrefresh() async {
//     // Future.delayed(Duration(seconds: 2), () {
//     //   CircularProgressIndicator();
//     // });
//     // loading2 = false;
//     Future.delayed(Duration(milliseconds: 100), () {
//       _loading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "Radio Programs",
//             style: TextStyle(
//                 color: Color.fromARGB(255, 0, 130, 185),
//                 fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           elevation: 0.0,
//         ),
//         body: RefreshIndicator(
//             displacement: 250,
//             backgroundColor: Colors.white,
//             color: Colors.red,
//             strokeWidth: 3,
//             triggerMode: RefreshIndicatorTriggerMode.onEdge,
//             onRefresh: () async {
//               await Future.delayed(Duration(seconds: 1));
//               setState(() {
//                 // getallpost();
//                 // CircularProgressIndicator();
//                 _loading
//                     ? Center(child: CircularProgressIndicator())
//                     : initState();
//                 // Center(
//                 //   child: Text("Please Wait"),
//                 // );
//                 //  _onrefresh();
//               });
//             },
//             child: _loading
//                 ? Center(child: CircularProgressIndicator())
//                 : SingleChildScrollView(
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 10.0),
//                       child: ListView.builder(
//                           shrinkWrap: true,
//                           physics: ClampingScrollPhysics(),
//                           itemCount: radioPrograms.length,
//                           itemBuilder: (context, index) {
//                             print("hay");
//                             print(radioPrograms.length);

//                             return BlogTilev(
//                                 desc: "desc",
//                                 imageUrl: radioPrograms[index].image.toString(),
//                                 title: "",
//                                 url: radioPrograms[index].user.toString(),
//                                 languageID: widget.languageid);
//                             //  RadioProgramSection(
//                             //   url: radioPrograms[index].id as int,
//                             //   Image: radioPrograms[index].image.toString(),
//                             //   content: radioPrograms[index].content.toString(),
//                             //   createdAt:
//                             //       radioPrograms[index].createdAt.toString(),
//                             //   title: radioPrograms[index].title.toString(),
//                             //   user: radioPrograms[index].user.toString(),
//                             //   view: radioPrograms[index].views.toString(),
//                             // );
//                           }),
//                     ),
//                   )));
//   }
// }

// class RadioProgramSection extends StatelessWidget {
//   String Image, content, title, user, createdAt;
//   String view;
//   int url;
//   RadioProgramSection({
//     required this.Image,
//     required this.content,
//     required this.title,
//     required this.view,
//     required this.user,
//     required this.createdAt,
//     required this.url,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ArticleView(blogUrl: url.toString())));
//       },
//       child: Container(
//         child: Column(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: CachedNetworkImage(
//                 imageUrl: Image,
//                 width: MediaQuery.of(context).size.width,
//                 height: 200,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Text(
//               title,
//               maxLines: 2,
//               style: TextStyle(
//                   // color: Colors.black,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold),
//             ),
//             Text(
//               content,
//               maxLines: 2,
//               style: TextStyle(
//                   // color: Colors.black,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold),
//             ),
//             Text(
//               user,
//               style: TextStyle(
//                   // color: Colors.black,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold),
//             ),
//             Text(
//               view,
//               style: TextStyle(
//                   // color: Colors.black,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold),
//             ),

//             // Text(

//             //   desc,
//             //   maxLines: 3,
//             // ),
//             SizedBox(
//               height: 20.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
