import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hurriyat/database/database_helper.dart';
import 'package:hurriyat/models/details/Details.dart';
import 'package:hurriyat/pages/all_news.dart';
import 'package:hurriyat/sqflite/note_model.dart';
import 'package:flutter_html/flutter_html.dart' as style;
import 'package:flutter_html/flutter_html.dart';
import 'package:hurriyat/sqflite/sqfliteview.dart';
import 'package:hurriyat/utils/constants/config.dart';
import 'package:hurriyat/widgets/NoData.dart';
import 'package:hurriyat/widgets/blogtile.dart';
import 'package:hurriyat/widgets/networkimage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui' as ui;

import 'package:hurriyat/widgets/skeleton.dart';

class ComNotes extends StatefulWidget {
  int? id;

  ComNotes({required this.id});

  @override
  State<ComNotes> createState() => _ComNotesState();
}

class _ComNotesState extends State<ComNotes> {
  //SQLite instance of DatabaseHelper class
  late DatabaseHelper handler;
  late Future<List<Detailss>> news;
  final db = DatabaseHelper();

  int? selectedId;
  int number = -1;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHelper();
    news = handler.getCompletedNotes();
    handler.initDB().whenComplete(() async {
      setState(() {
        news = getList();
      });
    });
    total();
  }

  // TotalUsers count;
  Future<int?> total() async {
    int? count = await handler.totalUsers();
    setState(() => number = count!);
    return number;
  }

  //Method to get data from database
  Future<List<Detailss>> getList() async {
    return await handler.getCompletedNotes();
  }

  //Method to refresh data on pulling the list
  Future<void> _onRefresh() async {
    setState(() {
      news = getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorites".tr,
          style: TextStyle(
              fontFamily: widget.id == 1
                  ? "Arial"
                  : widget.id == 4
                      ? "Al-Emarah"
                      : "Bahij",
              fontWeight: FontWeight.w600,
              fontSize: 14),
        ),
      ),
      body: FutureBuilder<List<Detailss>>(
          future: news,
          builder:
              (BuildContext context, AsyncSnapshot<List<Detailss>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                //To show a circular progress indicator
                child: CircularProgressIndicator(),
              );
              //If snapshot has error
            }
            if (!snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return SkeletonWidget();
                  });
            }
            if (snapshot.data!.length == 1) {
              return NoDataAvailableWidget();
            }
            // gvn nn
            else {
              final items = snapshot.data ?? <Detailss>[];

              return Scrollbar(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length - 1,
                      itemBuilder: (context, int index) {
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          background: Container(
                            decoration: BoxDecoration(
                              color: Colors.red.shade900,
                            ),
                            alignment: Alignment.centerRight,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Text("Delete".tr,
                                    maxLines: 1,
                                    textAlign: items[index].languageId == 1
                                        ? TextAlign.left
                                        : TextAlign.right,
                                    textDirection: items[index].languageId == 1
                                        ? ui.TextDirection.ltr
                                        : ui.TextDirection.rtl,
                                    style: TextStyle(
                                      // height: 1.5,
                                      overflow: TextOverflow.ellipsis,

                                      // color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      fontFamily: items[index].languageId == 1
                                          ? "Arial"
                                          : "Bahij",
                                    ))
                              ],
                            ),
                          ),
                          key: ValueKey<int>(items[index].userId!),
                          confirmDismiss: (direction) {
                            return showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('Are you sure?'.tr,
                                    maxLines: 1,
                                    textAlign: items[index].languageId == 1
                                        ? TextAlign.left
                                        : TextAlign.right,
                                    textDirection: items[index].languageId == 1
                                        ? ui.TextDirection.ltr
                                        : ui.TextDirection.rtl,
                                    style: TextStyle(
                                      // height: 1.5,
                                      overflow: TextOverflow.ellipsis,

                                      // color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      fontFamily: items[index].languageId == 1
                                          ? "Arial"
                                          : "Bahij",
                                    )),
                                content: Text(
                                    'Do you want to remove the item?'.tr,
                                    maxLines: 1,
                                    textAlign: items[index].languageId == 1
                                        ? TextAlign.left
                                        : TextAlign.right,
                                    textDirection: items[index].languageId == 1
                                        ? ui.TextDirection.ltr
                                        : ui.TextDirection.rtl,
                                    style: TextStyle(
                                      // height: 1.5,
                                      overflow: TextOverflow.ellipsis,

                                      // color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      fontFamily: items[index].languageId == 1
                                          ? "Arial"
                                          : "Bahij",
                                    )),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: Text('No'.tr,
                                        maxLines: 1,
                                        textAlign: items[index].languageId == 1
                                            ? TextAlign.left
                                            : TextAlign.right,
                                        textDirection:
                                            items[index].languageId == 1
                                                ? ui.TextDirection.ltr
                                                : ui.TextDirection.rtl,
                                        style: TextStyle(
                                          // height: 1.5,
                                          overflow: TextOverflow.ellipsis,

                                          // color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                          fontFamily:
                                              items[index].languageId == 1
                                                  ? "Arial"
                                                  : "Bahij",
                                        )),
                                    onPressed: () {
                                      Navigator.of(ctx).pop(false);
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text('Yes'.tr,
                                        maxLines: 1,
                                        textAlign: items[index].languageId == 1
                                            ? TextAlign.left
                                            : TextAlign.right,
                                        textDirection:
                                            items[index].languageId == 1
                                                ? ui.TextDirection.ltr
                                                : ui.TextDirection.rtl,
                                        style: TextStyle(
                                          // height: 1.5,
                                          overflow: TextOverflow.ellipsis,

                                          // color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                          fontFamily:
                                              items[index].languageId == 1
                                                  ? "Arial"
                                                  : "Bahij",
                                        )),
                                    onPressed: () {
                                      Navigator.of(ctx).pop(true);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          onDismissed: (DismissDirection direction) async {
                            await handler
                                .deleteNote(items[index].newsId.toString())
                                .whenComplete(() => ScaffoldMessenger.of(
                                        context)
                                    .showSnackBar(SnackBar(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        backgroundColor: Colors.teal,
                                        behavior: SnackBarBehavior.floating,
                                        duration: const Duration(seconds: 2),
                                        content: Text(
                                            "News Have Been deleted".tr,
                                            maxLines: 1,
                                            textAlign:
                                                items[index].languageId == 1
                                                    ? TextAlign.left
                                                    : TextAlign.right,
                                            textDirection:
                                                items[index].languageId == 1
                                                    ? ui.TextDirection.ltr
                                                    : ui.TextDirection.rtl,
                                            style: TextStyle(
                                              // height: 1.5,
                                              overflow: TextOverflow.ellipsis,

                                              // color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.0,
                                              fontFamily:
                                                  items[index].languageId == 1
                                                      ? "Arial"
                                                      : "Bahij",
                                            )))));
                            setState(() {
                              items.remove(items[index]);

                              total();
                              setState(() {
                                _onRefresh();
                              });
                            });
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => Sqflitedetails(
                                          newsId: items[index].newsId,
                                          title: items[index].title.toString(),
                                          descrition: items[index]
                                              .description
                                              .toString(),
                                          imageUrl:
                                              items[index].image.toString(),
                                          username:
                                              items[index].user.toString(),
                                          createAt:
                                              items[index].createdAt.toString(),
                                          languageId: items[index].languageId,
                                          source:
                                              items[index].source.toString(),
                                          views: items[index].views.toString(),
                                        )),
                              );
                            },
                            child: BlogTile(
                              created_at: items[index].createdAt.toString(),
                              category: items[index].category.toString(),
                              imageUrl: items[index].image.toString(),
                              languageID: items[index].languageId,
                              title: items[index].title.toString(),
                              url: items[index].newsId.toString(),
                            ),
                          ),
                        );
                      }),
                ),
              );
            }
          }),
    );
  }
}

class BlogTileoffline extends StatelessWidget {
  String desc, title, imageUrl;

  String? url;
  int? languageID;
  BlogTileoffline({
    required this.desc,
    required this.imageUrl,
    required this.title,
    required this.url,
    required this.languageID,
  });

  double setSize(BuildContext context, double size) {
    return MediaQuery.of(context).size.width / size;
  }

  @override
  Widget build(BuildContext context) {
    var isportrate = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      margin: EdgeInsets.only(bottom: 2.0),
      child: Container(
        padding: EdgeInsets.only(left: 5, bottom: 2, top: 5),
        child: Material(
          elevation: 3.0,
          // color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          child: Row(
            crossAxisAlignment: languageID == 1
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.center,
            mainAxisAlignment: isportrate
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: isportrate ? 2 : 4,
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:
                          //  Image.network(
                          //   imageUrl,
                          //   height: Config.screenHeight = 120.0,
                          //   width: double.infinity,
                          //   fit: BoxFit.cover,
                          //   loadingBuilder: (context, child, url) => url == null
                          //       ? child
                          //       : Center(
                          //           child: Container(
                          //               child: CircularProgressIndicator()),
                          //         ),
                          //   errorBuilder: (context, url, error) {
                          //     // debugPrint(
                          //     //     error.toString());
                          //     return Image.asset(
                          //       "assets/images/general.jpg",
                          //       fit: BoxFit.cover,
                          //       width: double.infinity,
                          //       height: Config.screenHeight = 120,
                          //     );
                          //   },
                          // ),

                          CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: Config.screenHeight = 120,
                              // placeholder: (context, url) => Center(
                              //   child: Container(child: CircularProgressIndicator()),
                              // ),
                              // errorWidget: (context, url, error) {
                              //   debugPrint(error.toString());
                              //   // debugPrint(
                              //   //     error.toString());
                              //   return Image.asset(
                              //     "assets/images/general.jpg",
                              //     fit: BoxFit.cover,
                              //     width: double.infinity,
                              //     height: Config.screenHeight = 120,
                              //   );
                              // },
                              placeholder: (context, url) => Center(
                                    child: Container(
                                        child: CircularProgressIndicator()),
                                  ),
                              errorWidget: (context, url, error) =>
                                  new Container(
                                    child:
                                        Image.asset("assets/logos/logo@2x.png"),
                                  )),
                    )),
              ),
              SizedBox(
                width: 5.0,
              ),
              Flexible(
                flex: isportrate ? 3 : 6,
                child: Column(
                  crossAxisAlignment: languageID == 1
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      // alignment: Alignment(99, 99),
                      child: Column(
                        children: [
                          Text(
                            title,
                            maxLines: 2,
                            textAlign: languageID == 1
                                ? TextAlign.left
                                : TextAlign.right,
                            textDirection: languageID == 1
                                ? ui.TextDirection.ltr
                                : ui.TextDirection.rtl,
                            style: TextStyle(
                              // color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              fontFamily: languageID == 1 ? "Arial" : "Bahij",
                            ),
                          ),
                          Text(
                            desc,
                            maxLines: 3,
                            textAlign: languageID == 1
                                ? TextAlign.left
                                : TextAlign.right,
                            textDirection: languageID == 1
                                ? ui.TextDirection.ltr
                                : ui.TextDirection.rtl,
                            style: TextStyle(
                                fontFamily: languageID == 1 ? "Arial" : "Bahij",

                                // color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
