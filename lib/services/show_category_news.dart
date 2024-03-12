import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hurriyat/models/show_category.dart';
import 'package:hurriyat/models/slider_model.dart';

class ShowCategoryNews {
  List<ShowCategoryModel> categories = [];

  Future<void> getCategoriesNews(String category, int languageid) async {
    String url = "https://hurriyat.net/api/news/category/$category/$languageid";
    String url1 =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=54145bc9681c42de9a6cc831aa90502b";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    // if (jsonData['status'] == 'ok') {
    jsonData["data"].forEach((element) {
      // if (element["urlToImage"] != null && element['description'] != null) {
      ShowCategoryModel categoryModel = ShowCategoryModel(
        title: element["title"],
        description: element["category_name"],
        url: element["id"].toString(),
        urlToImage: element["image"],
        content: element["content"],
        author: element["author"],
        createAt: element["created_at"],
      );
      categories.add(categoryModel);
      // }
    });
    // }
  }
}
