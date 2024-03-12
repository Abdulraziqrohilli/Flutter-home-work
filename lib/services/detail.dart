import 'dart:convert';

import 'package:hurriyat/models/article_model.dart';
import 'package:hurriyat/models/details/Details.dart' as m;
import 'package:http/http.dart' as http;

class Details {
  List<m.Details> details = [];

  Future<void> getNews(int postid) async {
    String url = " https://hurriyat.net/api/news-details/$postid";
    // String url =
    //     "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=54145bc9681c42de9a6cc831aa90502b";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((json) {
        if (json["main_image"] != null && json['description'] != null) {
          m.Details articleModel = m.Details(
    id : json['id'],
    title : json['title'],
    description : json['description'],
    createdAt : json['created_at'],
    user : json['user'],
    newsCategory : json['news_category'],
    newsType : json['news_type'],
    source : json['source'],
    mainImage : json['main_image'],
    caption : json['caption'],
    languageId : json['language_id'],
    tags : json['tags'] != null ? json['tags'].cast<String>() : [], 
          );
          details.add(articleModel);
        }
      });
    }
  }
}
