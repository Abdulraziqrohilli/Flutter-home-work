import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:hurriyat/models/Videos/Data.dart';
import 'package:hurriyat/models/Videos/Videos.dart';

class VideoDio {
  // List<Data> latestradioprograms = [];
  late Dio _dio;
  VideoDio() {
    _dio = Dio();
  }
  Future<List<Data>?> getVideosDio(int? videotype, int languageid) async {
    // var isCacheExist = await DioCacheManager(CacheConfig());
    // if (!isCacheExist) {
    // print("online data");
    try {
      String url = "https://hurriyat.net/api/videos/$videotype/$languageid";
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      Options options =
          buildCacheOptions(const Duration(hours: 6), forceRefresh: false);
      _dio.interceptors.add(dioCacheManager.interceptor);

      Response response = await _dio.get(url, options: options);
      Videos newresponse = Videos.fromJson(response.data);
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
