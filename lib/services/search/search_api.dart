import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hurriyat/models/article_model.dart';

class SearchApi {
  static Future<List<ArticleModel>> getNews(String query,int languageid) async {

    final url = Uri.parse("https://hurriyat.net/api/news/$languageid");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List news = json.decode(response.body);

      return news.map((json) => ArticleModel.fromJson(json)).where((newss) {
        final titleLower = newss.title!.toLowerCase();
        final authorLower = newss.description!.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
