import 'Data.dart';

class Radioprogram {
  Radioprogram({
    required  this.data, 
      this.currentPage,});

  Radioprogram.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
    currentPage = json['current_page'];
  }
 late List<Data> data;
 late int? currentPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    map['current_page'] = currentPage;
    return map;
  }

}