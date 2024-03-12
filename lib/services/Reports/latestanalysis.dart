import 'dart:convert';


import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
// import 'package:hurriyat/models/reportsmodels/Data.dart';
import 'package:hurriyat/models/reportsmodels/latest_report.dart';
import 'package:hurriyat/utils/constants/config.dart';

class LatestReportsDio {
  // List<Data> latestradioprograms = [];
  late Dio _dio;
  LatestReportsDio() {
    _dio = Dio();
  }
  Future<List<Data>?> getLatestReportDio(int languageid) async {
    // var isCacheExist = await DioCacheManager(CacheConfig());
    // if (!isCacheExist) {
    // print("online data");
    try {
      String url = "https://hurriyat.net/api/latest-reports/$languageid";
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      Options options =
          buildCacheOptions(const Duration(seconds: 6), forceRefresh: true);
      _dio.interceptors.add(dioCacheManager.interceptor);

      Response response = await _dio.get(url, options: options);
      LatestReport newresponse = LatestReport.fromJson(response.data);
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
