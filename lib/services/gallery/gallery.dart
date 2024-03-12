import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:hurriyat/models/gallery/Data.dart';
import 'package:hurriyat/models/gallery/Gallery.dart';

class GalleryDio {
  late Dio _dio;
  GalleryDio() {
    _dio = Dio();
  }
  Future<List<Data>?> getGalleryDio(int languageid) async {
    try {
      String url = "https://hurriyat.net/api/gallery/$languageid";
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      Options options =
          buildCacheOptions(const Duration(hours: 6), forceRefresh: false);
      _dio.interceptors.add(dioCacheManager.interceptor);

      Response response = await _dio.get(url, options: options);
      Gallery newresponse = Gallery.fromJson(response.data);
      return newresponse.data;
    } on DioError catch (e) {
      print(e.error);
      return null!;
    }
  
  }
}
