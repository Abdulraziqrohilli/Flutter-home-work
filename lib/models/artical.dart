import 'package:hurriyat/models/article_model.dart';


class ArticalNews {
  ArticalNews({
      required this.data,
      });

  ArticalNews.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(ArticleModel.fromJson(v));
      });
    }
  }
 late List<ArticleModel> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}