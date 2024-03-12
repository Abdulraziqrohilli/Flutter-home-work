import 'package:hurriyat/models/details/details.dart';

class DetailsModel {
  DetailsModel({
      required this.data,
      });

  DetailsModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Details.fromJson(v));
      });
    }
  }
 late List<
 Details> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}