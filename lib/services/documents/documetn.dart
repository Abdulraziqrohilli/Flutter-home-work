import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:hurriyat/models/documentsmodels/Data.dart';
import 'package:hurriyat/models/documentsmodels/Documentaries.dart';

class DocumentDio {
  late Dio _dio;
  DocumentDio() {
    _dio = Dio();
  }
  Future<List<Data>?> getDocumentDio(int languageid) async {
    try {
      String url = "https://hurriyat.net/api/documentaries/$languageid";
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      Options options =
          buildCacheOptions(const Duration(seconds: 3), forceRefresh: true,maxStale: Duration(days: 7));
      _dio.interceptors.add(dioCacheManager.interceptor);

      Response response = await _dio.get(url, options: options);
      Documentaries newresponse = Documentaries.fromJson(response.data);
      return newresponse.data;
    } on DioError catch (e) {
      print(e.error);
      return null!;
    }
  
  }
}
