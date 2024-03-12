// import 'package:hurriyat/models/radioprograms/latest_radio-programm/Data.dart';

// class Documentaries {
//   Documentaries({
//       this.data, 
//       this.currentPage,});

//   Documentaries.fromJson(dynamic json) {
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data!.add(v.fromJson(v));
//       });
//     }
//     currentPage = json['current_page'];
//   }
//   List<Data>? data;
//   int? currentPage;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (data != null) {
//       map['data'] = data!.map((v) => v.toJson()).toList();
//     }
//     map['current_page'] = currentPage;
//     return map;
//   }

// }
import 'Data.dart';

class Documentaries {
  Documentaries({
      this.data,
      this.currentPage});

  Documentaries.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    currentPage = json['current_page'];

  }
  List<Data>? data;
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