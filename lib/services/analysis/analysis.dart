// import 'dart:convert';

// import 'package:hurriyat/models/radioprograms/Data.dart';

// class RadioProgram {
//   List<Data> radioprograms = [];

//   Future<void> getradioprogram(int languageid) async {
//     String url = "https://hurriyat.net/api/radio-programs/$languageid";

//     String url1 =
//         "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=8eb940539c874fa98a2050d4afde5d5b";
//     var response = await http.get(Uri.parse(url));

//     var jsonData = jsonDecode(response.body);

//     // if (jsonData['status'] == 'ok') {
//     jsonData["data"].forEach((json) {
//       // if (element["image"] != null && element['title'] != null)
//       // {
//       Data radioprogram = Data(
//         // title: element["title"],
//         // description: element["title"],
//         // url: element["id"].toString(),
//         // urlToImage: element["image"],
//         // content: element["category_name"],
//         // author: element["user"],
//         // languageId: element["language_id"],
//             id : json['id'],
//     title : json['title'],
//     createdAt : json['created_at'],
//     user : json['user'],
//     image : json['image'],
//     content : json['content'],
//     views : json['views'],

//         // title: element['title'],
//         // // description: element['description'],
//         // image: element['image'],
//         // // url: element['url'],
//         // user: element['user'],
//         // categoryName: element['category_name']
//       );
//     radioprograms.add(radioprogram);
//       // }
//     });
//     // }
//   }
// }
import 'dart:convert';


import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:hurriyat/models/analysis/Data.dart';
import 'package:hurriyat/models/analysis/Analysis.dart';
import 'package:hurriyat/utils/constants/config.dart';

class AnalysisDio {
  // List<Data> latestradioprograms = [];
  late Dio _dio;
   AnalysisDio() {
    _dio = Dio();
  }
  Future<List<Data>?> getAnalyisDio(int languageid) async {
    // var isCacheExist = await DioCacheManager(CacheConfig());
    // if (!isCacheExist) {
    // print("online data");
    try {
      String url = "https://hurriyat.net/api/analysis/$languageid";
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      Options options =
          buildCacheOptions(const Duration(seconds: 3), forceRefresh: true,maxStale: Duration(days: 7));
      _dio.interceptors.add(dioCacheManager.interceptor);

      Response response = await _dio.get(url, options: options);
      Analysis newresponse =
         Analysis.fromJson(response.data);
      // APICacheDBModel dbModel =
      //     new APICacheDBModel(key: "of", syncData: response.data);
      // await APICacheManager().addCacheData(dbModel);
      return newresponse.data;
    } on DioError catch (e) {
      print(e.error);
      return null!;
    }
    // final response = await http
    //     .get(Uri.parse('https://hurriyat.net/api/latest-radio-programs/2'));
    // var data = jsonDecode(response.body.toString());

    // if (response.statusCode == 200) {
    //   return LatestRadioProgramm.fromJson(data).data?.toList();
    // } else {
    //   return LatestRadioProgramm.fromJson(data).data?.toList();
    // }
    // } else {
    //   print("offline data");
    //   var cacheData = await APICacheManager().getCacheData("of");
    //   LatestRadioProgramm newresponse = LatestRadioProgramm.fromJson(cacheData);
    //   return newresponse.data;
    // }
  }
}
