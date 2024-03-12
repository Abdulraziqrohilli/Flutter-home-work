import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

class AllNews extends StatefulWidget {
  String news;
  int languageid;
  AllNews({required this.news, required this.languageid});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  // List<sliderModel> sliders = [];
  // List<ArticleModel> articles = [];
  void initState() {
    getSlider(widget.languageid);
    getNews();
    super.initState();
  }

  // getNews() async {
  //   News newsclass = News();
  //   await newsclass.getNews(widget.languageid);
  //   // articles = newsclass.getNews(languageid);
  //   setState(() {});
  // }
  Future<List<ArticleModel>> getNews() async {
    try {
      dio.Dio _dio = dio.Dio();

      String url = "https://hurriyat.net/api/news/${widget.languageid}";
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      dio.Options options =
          buildCacheOptions(const Duration(minutes: 1), forceRefresh: true);
      _dio.interceptors.add(dioCacheManager.interceptor);

      dio.Response response = await _dio.get(url, options: options);
      ArticalNews newresponse = ArticalNews.fromJson(response.data);
      return newresponse.data;
    } on dio.DioError catch (e) {
      print("this is the main error" + e.error);
      return null!;
    }
  }

  // Future<List<SliderModel>> getSlider() async {
  //   try {
  //     dio.Dio _dio = dio.Dio();

  //     String url = "https://hurriyat.net/api/latest-news/${widget.languageid}";
  //     DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
  //     dio.Options options =
  //         buildCacheOptions(const Duration(minutes: 1), forceRefresh: true);
  //     _dio.interceptors.add(dioCacheManager.interceptor);

  //     dio.Response response = await _dio.get(url, options: options);
  //     SliderNews newresponse = SliderNews.fromJson(response.data);
  //     return newresponse.data;
  //   } on dio.DioError catch (e) {
  //     print("this is the main error" + e.error);
  //     return null!;
  //   }
  // }
  Future<List<SliderModel>> getSlider(int languageid) async {
    try {
      dio.Dio _dio = dio.Dio();

      String url = "https://hurriyat.net/api/latest-news/$languageid";
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      dio.Options options =
          buildCacheOptions(const Duration(minutes: 1), forceRefresh: true);
      _dio.interceptors.add(dioCacheManager.interceptor);

      dio.Response response = await _dio.get(url, options: options);
      SliderNews newresponse = SliderNews.fromJson(response.data);
      return newresponse.data;
    } on dio.DioError catch (e) {
      print("this is the main error" + e.error);
      return null!;
    }
  }
  // getSlider() async {
  //   Sliders slider = Sliders();
  //   await slider.getSlider(widget.languageid);
  //   sliders = slider.sliders;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.news + " News",
          style: TextStyle(
              color: Color.fromARGB(255, 0, 130, 185),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: widget.news == "Breaking"
          ? FutureBuilder<List<SliderModel>>(
              future: getSlider(widget.languageid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: 100,
                    child: Center(
                      heightFactor: 23,
                      child: CircularProgressIndicator(),
                      // Text("Please Wait..."),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  print(" error" + snapshot.error.toString());
                  return Center(
                    heightFactor: 23,
                    child:
                        // CircularProgressIndicator(),
                        Text("Please Wait..." + snapshot.hasError.toString()),
                  );
                }

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return AllNewsSection(
                            Image: snapshot.data![index].urlToImage!,
                            desc: snapshot.data![index].content!,
                            title: snapshot.data![index].title!,
                            url: snapshot.data![index].url!);
                      }),
                );
              })
          // FutureBuilder<List<SliderModel>>(
          //     future: getSlider(),
          //     builder: (context, snapshot) {
          //       if (!snapshot.hasData) {
          //         return Container(
          //           height: 100,
          //           child: Center(
          //             heightFactor: 23,
          //             child: CircularProgressIndicator(),
          //             // Text("Please Wait..."),
          //           ),
          //         );
          //       }
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
          //     })
          : FutureBuilder<List<ArticleModel>>(
              future: getNews(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: 100,
                    child: Center(
                      heightFactor: 23,
                      child: CircularProgressIndicator(),
                      // Text("Please Wait..."),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  print(" error" + snapshot.error.toString());
                  return Center(
                    heightFactor: 23,
                    child:
                        // CircularProgressIndicator(),
                        Text("Please Wait..." + snapshot.hasError.toString()),
                  );
                }
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return BlogTile(
                          category: snapshot.data![index].content!,
                          created_at: snapshot.data![index].created_at!,

                            imageUrl: snapshot.data![index].urlToImage!,
                            title: snapshot.data![index].title!,
                            url: snapshot.data![index].url!,
                            languageID: widget.languageid);

                        // AllNewsSection(
                        //     Image: snapshot.data![index].urlToImage!,
                        //     desc: snapshot.data![index].description!,
                        //     title: snapshot.data![index].title!,
                        //     url: snapshot.data![index].url!);
                      }),
                );
              }),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  String Image, desc, title;
  String url;
  AllNewsSection(
      {required this.Image,
      required this.desc,
      required this.title,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)));
      },
      child: Container(
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
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                  // color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            style.Html(
              data: desc,
              style: {
                "body": style.Style(
                  fontSize: style.FontSize(18.0),
                  maxLines: 3,
                  // fontWeight: FontWeight.bold,
                  // textAlign: snapshot
                  //             .data!.post!.languageId
                  //             .toString() ==
                  //         '1'
                  //     ? TextAlign.left
                  //     : TextAlign.right,
                  // direction: snapshot
                  //             .data!.post!.languageId
                  //             .toString() ==
                  //         '1'
                  //     ? ui.TextDirection.ltr
                  //     : ui.TextDirection.rtl,
                  // fontFamily: snapshot
                  //             .data!.post!.languageId
                  //             .toString() ==
                  //         '1'
                  //     ? "Arial"
                  //     : "pashto",
                ),
              },
            ),
            // Text(

            //   desc,
            //   maxLines: 3,
            // ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
