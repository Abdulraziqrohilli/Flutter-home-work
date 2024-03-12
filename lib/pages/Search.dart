import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import 'package:hurriyat/models/category_model.dart';
import 'package:hurriyat/models/search/Search.dart';
import 'package:hurriyat/models/show_category.dart';
import 'package:hurriyat/pages/article_view.dart';
import 'package:hurriyat/services/show_category_news.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:ui' as ui;

import 'package:http/http.dart' as http;
import 'package:hurriyat/models/search/Data.dart';
import 'package:hurriyat/models/categroymodel.dart' as m;
import 'package:hurriyat/widgets/blogtile.dart';
import 'package:hurriyat/widgets/search_widget.dart';

class SearchNews extends StatefulWidget {
  String search;
  int languageid;
  SearchNews({required this.search, required this.languageid});

  @override
  State<SearchNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<SearchNews> {
  // List<ShowCategoryModel> categories = [];
  // List<ShowCategoryModel> lancategories = [];

  bool _loading = true;

  @override
  void initState() {
    getNews();
    super.initState();
  }

  // getNews() async {
  //   ShowCategoryNews showCategoryNews = ShowCategoryNews();
  //   await showCategoryNews.getCategoriesNews(
  //       widget.name.toLowerCase(), widget.languageid);
  //   categories = showCategoryNews.categories;
  //   setState(() {
  //     _loading = false;
  //   });
  // }
  // String searchname = widget.search;

  // List<Data> searchs = [];

  // Future<void> getSearchNews() async {
  //   String url =
  //       "https://hurriyat.net/api/search?query=${widget.search}&language_id=${widget.languageid}";
  //   var response = await http.get(Uri.parse(url));

  //   var jsonData = jsonDecode(response.body);

  //   // if (jsonData['status'] == 'ok') {
  //   jsonData["data"].forEach((json) {
  //     // if (element["urlToImage"] != null && element['description'] != null) {
  //     Data searchModel = Data(
  //       id: jsonData['id'],
  //       title: json['title'],
  //       categoryName: json['category_name'],
  //       createdAt: json['created_at'],
  //       user: json['user'],
  //       image: json['image'],
  //       content: json['content'],
  //       views: json['views'],
  //     );
  //     searchs.add(searchModel);
  //     // }
  //   });
  //   // }
  // }
  Future<List<Data>?> getNews() async {
    try {
      dio.Dio _dio = dio.Dio();

      String url =
          "https://hurriyat.net/api/search?query=${widget.search}&language_id=${widget.languageid}";
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      dio.Options options =
          buildCacheOptions(const Duration(hours: 6), forceRefresh: _loading);
      _dio.interceptors.add(dioCacheManager.interceptor);

      dio.Response response = await _dio.get(url, options: options);
      Search newresponse = Search.fromJson(response.data);
      setState(() {
        _loading = false;
      });
      return newresponse.data;
    } on dio.DioError catch (e) {
      print("this is the main error" + e.error);
      return null!;
    }
  }

  // getNewsbyLanguage() async {
  bool showtext = true;
  //   ShowCategoryNews showCategoryNews = ShowCategoryNews();
  //   await showCategoryNews.getCategoriesNews(widget.name.toLowerCase(),1);
  //   categories = showCategoryNews.categories;
  //   setState(() {
  //     _loading = false;
  //   });
  // }
  // bool _loading = true, loading2 = true;
  void _onrefresh() async {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        showtext = false;
      });
    });
  }

  void _onrefreshs() async {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        showtext = true;
      });
    });
  }

  Future searchBook(String query) async {
    final news = await getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text(
      //   //   widget.search.toString().tr,
      //   //   style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      //   // ),

      //     // IconButton(
      //     //     onPressed: () {
      //     //       SearchWidget(
      //     //           text: widget.search,
      //     //           onChanged: searchBook,
      //     //           hintText: "search here");
      //     //     },
      //     //     icon: Icon(Icons.search_outlined))

      //   // centerTitle: true,
      //   // elevation: 0.0,
      // ),
      body:
          //  _loading
          //     ? Center(child: CircularProgressIndicator())
          //     :

          FutureBuilder<List<Data>?>(
              future: getNews(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  // widget.search == snapshot.data
                  //     ? CircularProgressIndicator()
                  //     : Text("Sorry No Data Found According to Search!!!!");
                  return showtext == true
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text("Sorry No Data Found According to Search!!!!");
                  //       : Center(
                  //           child: Text(
                  //               "Sorry No Data Found According to Search!!!!"));
                }
                if (snapshot.connectionState == true) {
                  // return
                  _loading = false;
                  // Center(
                  //   child: Text("Networks Problems"),
                  // );
                }
                // if (snapshot.data!.isNotEmpty) {
                //   showtext == true;
                // }
                if (snapshot.data!.length == 0) {
                  _onrefresh();
                  if (showtext == true) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (showtext == false) {
                    return Center(
                        child: Text(
                            "Sorry No Data Found According to Search!!!!"));
                  }
                }
                if (snapshot.data!.length >= 1) {
                  showtext = true;
                }

                var searchs = snapshot.data;
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: searchs!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ArticleView(
                                        blogUrl: searchs[index].id.toString(),
                                      )));
                            });
                          },
                          child: BlogTile(
                            created_at: searchs[index].createdAt.toString(),
                              category: searchs[index].categoryName.toString(),
                              imageUrl: searchs[index].image.toString(),
                              title: searchs[index].title.toString(),
                              url: searchs[index].id.toString(),
                              languageID: widget.languageid),
                        );
                        // ShowCategory(
                        //   Image: searchs[index].image!,
                        //   desc: searchs[index].content!,
                        //   title: searchs[index].title!,
                        //   url: searchs[index].id.toString(),
                        //   languageId: widget.languageid,

                        //   // languageId: categories[index].url!
                        // );
                      }),
                );
              }),
    );
  }
}

class ShowCategory extends StatelessWidget {
  String Image, desc, title;
  int languageId;
  String url;

  // url;
  ShowCategory(
      {required this.Image,
      required this.desc,
      required this.title,
      required this.url,
      required this.languageId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.only(bottom: 3, left: 4, right: 4),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: Image,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              // Text(
              //   title,
              //   maxLines: 2,
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 18.0,
              //       fontWeight: FontWeight.bold),
              // ),
              Text(
                maxLines: 2,
                textAlign:
                    //  TextAlign.center,
                    languageId == 1 ? TextAlign.left : TextAlign.right,
                textDirection: languageId == 1
                    ? ui.TextDirection.ltr
                    : ui.TextDirection.rtl,
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: languageId == 1 ? "Arial" : "Bahij",
                ),
              ),
              Text(
                maxLines: 3,
                textAlign:
                    //  TextAlign.center,
                    languageId == 1 ? TextAlign.left : TextAlign.right,
                textDirection: languageId == 1
                    ? ui.TextDirection.ltr
                    : ui.TextDirection.rtl,
                desc.tr,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  fontFamily: languageId == 1 ? "Arial" : "Bahij",
                ),
              ),
              // Text(
              //   desc.tr,
              //   maxLines: 3,
              // ),
              // SizedBox(
              //   height: 20.0,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
