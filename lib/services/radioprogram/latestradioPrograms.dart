import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hurriyat/models/radioprograms/latest_radio-programm/Data.dart';

class LatestRadioProgram {
  List<Data> latestradioprograms = [];

  Future<void> getlatestradioprogram(int languageid) async {
    String url = "https://hurriyat.net/api/latest-radio-programs/$languageid";

    String url1 =
        "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=8eb940539c874fa98a2050d4afde5d5b";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    // if (jsonData['status'] == 'ok') {
    jsonData["data"].forEach((json) {
      // if (element["image"] != null && element['title'] != null)
      // {
      Data latestradioprogram = Data(
        // title: element["title"],
        // description: element["title"],
        // url: element["id"].toString(),
        // urlToImage: element["image"],
        // content: element["category_name"],
        // author: element["user"],
        // languageId: element["language_id"],
            id : json['id'],
    title : json['title'],
    host : json['host'],
    user : json['user'],
    image : json['image'],
    views : json['views'],

        // title: element['title'],
        // // description: element['description'],
        // image: element['image'],
        // // url: element['url'],
        // user: element['user'],
        // categoryName: element['category_name']
      );
    latestradioprograms.add(latestradioprogram);
      // }
    });
    // }
  }
}
