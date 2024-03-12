import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:hurriyat/models/gallery/latest_gallery/Data.dart';
import 'package:hurriyat/models/gallery/latest_gallery/Latest_galley.dart';

class LatestGalleryDio {
  late Dio _dio;
  LatestGalleryDio() {
    _dio = Dio();
  }
  Future<List<Data>?> getLatestGalleryDio(int languageid) async {
    try {
      String url = "https://hurriyat.net/api/latest-gallery/$languageid";
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      Options options =
          buildCacheOptions(const Duration(hours: 6), forceRefresh: false);
      _dio.interceptors.add(dioCacheManager.interceptor);

      Response response = await _dio.get(url, options: options);
      LatestGalley newresponse = LatestGalley.fromJson(response.data);
      return newresponse.data;
    } on DioError catch (e) {
      print(e.error);
      return null!;
    }
  
  }
}
