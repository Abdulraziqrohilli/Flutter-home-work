
import 'dart:convert';


import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:hurriyat/models/analysis/latest_analysis/Data.dart';
import 'package:hurriyat/models/analysis/latest_analysis/Latest_analsis.dart';
import 'package:hurriyat/utils/constants/config.dart';

class LatestAnalysisDio {
  // List<Data> latestradioprograms = [];
  late Dio _dio;
   LatestAnalysisDio() {
    _dio = Dio();
  }
  Future<List<Data>?> getLatestAnalyisDio(int languageid) async {
    // var isCacheExist = await DioCacheManager(CacheConfig());
    // if (!isCacheExist) {
    // print("online data");
    try {
      String url = "https://hurriyat.net/api/latest-analysis/$languageid";
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      Options options =
          buildCacheOptions(const Duration(seconds: 3), forceRefresh: true,maxStale: Duration(days: 7));
      _dio.interceptors.add(dioCacheManager.interceptor);

      Response response = await _dio.get(url, options: options);
      LatestAnalsis newresponse =
         LatestAnalsis.fromJson(response.data);
      // APICacheDBModel dbModel =
      //     new APICacheDBModel(key: "of", syncData: response.data);
      // await APICacheManager().addCacheData(dbModel);
      return newresponse.data;
    } on DioError catch (e) {
      print(e.error);
      return null!;
    }

  }
}
