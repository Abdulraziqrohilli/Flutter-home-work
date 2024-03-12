import 'Data.dart';

class Reports {
  Reports({
     required this.data, 
      this.currentPage,});

  Reports.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    currentPage = json['current_page'];
  }
 late List<Data> data;
  int ?currentPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    map['current_page'] = currentPage;
    return map;
  }

}