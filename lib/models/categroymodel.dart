import 'package:hurriyat/models/show_category.dart';


class CategoryModel {
  CategoryModel({
      required this.data,
      });

  CategoryModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(ShowCategoryModel.fromJson(v));
      });
    }
  }
 late List<ShowCategoryModel> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}