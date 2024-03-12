import 'dart:convert';


import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:hurriyat/models/artical.dart';
import 'package:hurriyat/models/article_model.dart';
// import 'package:http/http.dart' as http;

class News {
  News() {
    _dio = Dio();
  }
  late Dio _dio;

  Future<List<ArticleModel>> getNews(int languageid) async {
    try {
      String url = "https://hurriyat.net/api/news/$languageid?page=3";
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      Options options =
          buildCacheOptions(const Duration(seconds: 1), forceRefresh: true);
      _dio.interceptors.add(dioCacheManager.interceptor);

      Response response = await _dio.get(url, options: options);
      ArticalNews newresponse = ArticalNews.fromJson(response.data);
      return newresponse.data;
    } on DioError catch (e) {
      print("this is the main error" + e.error);
      return null!;
    }
  }
}
//   List<ArticleModel> news = [];

//   Future<void> getNews(int languageid) async {
//     var isCacheExist = await APICacheManager().isAPICacheKeyExist("of");
//     if (!isCacheExist) {
//       String url = "https://hurriyat.net/api/news/$languageid";

//       var response = await http.get(Uri.parse(url));

//       var jsonData = jsonDecode(response.body);

// // if(jsonData['status']=='ok'){
//       jsonData["data"].forEach((element) async {
//         // if(element["urlToImage"]!=null && element['description']!=null){
//         ArticleModel articleModel = ArticleModel(
//           title: element["title"],
//           description: element["content"].toString(),
//           url: element["id"].toString(),
//           urlToImage: element["image"],
//           content: element["category_name"],
//           author: element["created_at"],
//         );
//         APICacheDBModel dbModel =
//             new APICacheDBModel(key: "of", syncData: jsonData);

//         await APICacheManager().addCacheData(dbModel);
//         news.add(articleModel);
//       });
//       return null;
//     } else {
//       var cacheData = await APICacheManager().getCacheData("of");

//       news.add(cacheData.syncData as ArticleModel);
//     }
//   }
