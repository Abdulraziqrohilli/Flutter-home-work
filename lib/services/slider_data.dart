import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:http/http.dart' as http;
import 'package:hurriyat/models/Slider.dart';
import 'package:hurriyat/models/slider_model.dart';

class Sliders {
  Sliders() {
    _dio = Dio();
  }
  late Dio _dio;

  Future<List<SliderModel>> getSlider(int languageid) async {
    try {
      String url = "https://hurriyat.net/api/latest-news/$languageid";
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      Options options =
          buildCacheOptions(const Duration(minutes: 1), forceRefresh: true);
      _dio.interceptors.add(dioCacheManager.interceptor);

      Response response = await _dio.get(url, options: options);
      SliderNews newresponse = SliderNews.fromJson(response.data);
      return newresponse.data;
    } on DioError catch (e) {
      print("this is the main error" + e.error);
      return null!;
    }
  }
  // List<sliderModel> sliders = [];

  // Future<void> getSlider(int languageid) async {
  //   String url = "https://hurriyat.net/api/latest-news/$languageid";

  //   String url1 =
  //       "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=8eb940539c874fa98a2050d4afde5d5b";
  //   var response = await http.get(Uri.parse(url));

  //   var jsonData = jsonDecode(response.body);

  //   // if (jsonData['status'] == 'ok') {
  //   jsonData["data"].forEach((element) {
  //     // if (element["image"] != null && element['title'] != null)
  //     // {
  //     sliderModel slidermodel = sliderModel(
  //       title: element["title"],
  //       description: element["content"],
  //       url: element["id"].toString(),
  //       urlToImage: element["image"],
  //       content: element["category_name"],
  //       author: element["user"],
  //       languageId: element["language_id"],

  //       // title: element['title'],
  //       // // description: element['description'],
  //       // image: element['image'],
  //       // // url: element['url'],
  //       // user: element['user'],
  //       // categoryName: element['category_name']
  //     );
  //     sliders.add(slidermodel);
  //     // }
  //   });
  //   // }
  // }
}
