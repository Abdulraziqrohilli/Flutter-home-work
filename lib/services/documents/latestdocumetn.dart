import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:hurriyat/models/documentsmodels/latest_documentaries/Data.dart';
import 'package:hurriyat/models/documentsmodels/latest_documentaries/Latest_documentaris.dart';

class LatestDocumentDio {
  late Dio _dio;
  LatestDocumentDio() {
    _dio = Dio();
  }
  Future<List<Data>?> getLatestDocumentDio(int languageid) async {
    try {
      String url = "https://hurriyat.net/api/latest-documentaries/$languageid";
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      Options options =
          buildCacheOptions(const Duration(seconds: 3), forceRefresh: true,maxStale: Duration(days: 7));
      _dio.interceptors.add(dioCacheManager.interceptor);

      Response response = await _dio.get(url, options: options);
      LatestDocumentaris newresponse = LatestDocumentaris.fromJson(response.data);
      return newresponse.data;
    } on DioError catch (e) {
      print(e.error);
      return null!;
    }
  
  }
}
