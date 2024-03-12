import 'Data.dart';

class RaidoPrograms {
  RaidoPrograms({
    required  this.data, 
      this.currentPage,});

  RaidoPrograms.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Datar.fromJson(v));
      });
    }
    currentPage = json['current_page'];
  }
   late List<Datar> data;
  int? currentPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    map['current_page'] = currentPage;
    return map;
  }

}