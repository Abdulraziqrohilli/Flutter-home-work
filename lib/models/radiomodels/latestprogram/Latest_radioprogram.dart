import 'Data.dart';

class LatestRadioprogram {
  LatestRadioprogram({
    required  this.data,});

  LatestRadioprogram.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(LData.fromJson(v));
      });
    }
  }
late  List<LData> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}