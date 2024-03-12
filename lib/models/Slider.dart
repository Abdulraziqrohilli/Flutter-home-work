import 'package:hurriyat/models/article_model.dart';
import 'package:hurriyat/models/slider_model.dart';


class SliderNews {
  SliderNews({
      required this.data,
      });

  SliderNews.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(SliderModel.fromJson(v));
      });
    }
  }
 late List<SliderModel> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}