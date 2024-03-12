import 'Data.dart';
import 'Filters.dart';

class Search {
  Search({
      this.data, 
      this.currentPage, 
      this.total, 
      this.filters,});

  Search.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    total = json['total'];
    filters = json['filters'] != null ? Filters.fromJson(json['filters']) : null;
  }
  List<Data>? data;
  int? currentPage;
  int? total;
  Filters? filters;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    map['current_page'] = currentPage;
    map['total'] = total;
    if (filters != null) {
      map['filters'] = filters!.toJson();
    }
    return map;
  }

}