import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hurriyat/models/search/Data.dart';

class SearchNews {
  List<Data> categories = [];

  Future<void> getCategoriesNews(String search, int languageid) async {
    String url = "https://hurriyat.net/api/search?query=$search&language_id=$languageid";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    // if (jsonData['status'] == 'ok') {
    jsonData["data"].forEach((json) {
      // if (element["urlToImage"] != null && element['description'] != null) {
      Data categoryModel = Data(
       
        id :jsonData['id'],
    title : json['title'],
    categoryName : json['category_name'],
    createdAt : json['created_at'],
    user : json['user'],
    image : json['image'],
    content : json['content'],
    views : json['views'],
      );
      categories.add(categoryModel);
      // }
    });
    // }
  }
}
