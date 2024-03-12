import 'dart:convert';
/// id : 1
/// title : "حکومتي مسؤلین د چمن له لارې راستانه شوي کډوال خپلو سیمو ته انتقالوي"
/// description : "<p dir=\"rtl\">حکومتي مسؤلین د چمن له لارې راستانه شوي کډوال خپلو سیمو ته انتقالوي<br><br>کندهار ته له پاکستان تازه راغلي افغانان د حکومتي مسؤلینو او ځايي سوداګرو له لوري د ثبت او بایو میټریک وروسته په وړیا ډول خپلو سیمو ته انتقال کېږي، چې نن او تېره ورځ ۳۰۷ کورنۍ چې ۲۱۳۸ کسان کېږي؛ خپلو مېنو ته انتقال شوي دي.<br>یوټيوب لېنک: <a href=\"https://youtu.be/_8dc8PQ96os\">https://youtu.be/_8dc8PQ96os</a></p>"
/// created_at : "2023-11-07T10:46:24.000000Z"
/// user : "Humayoon"
/// report_category : "Afghanistan"
/// source : "حریت راډيو"
/// main_image : "https://hurriyat.net/storage/news_images/report-بولدک کډوال.png"
/// language_id : 2
/// views : 10

ReportsDetails reportsDetailsFromJson(String str) => ReportsDetails.fromJson(json.decode(str));
String reportsDetailsToJson(ReportsDetails data) => json.encode(data.toJson());
class ReportsDetails {
  ReportsDetails({
      num? id, 
      String? title, 
      String? description, 
      String? createdAt, 
      String? user, 
      String? reportCategory, 
      String? source, 
      String? mainImage, 
      num? languageId, 
      num? views,}){
    _id = id;
    _title = title;
    _description = description;
    _createdAt = createdAt;
    _user = user;
    _reportCategory = reportCategory;
    _source = source;
    _mainImage = mainImage;
    _languageId = languageId;
    _views = views;
}

  ReportsDetails.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _user = json['user'];
    _reportCategory = json['report_category'];
    _source = json['source'];
    _mainImage = json['main_image'];
    _languageId = json['language_id'];
    _views = json['views'];
  }
  num? _id;
  String? _title;
  String? _description;
  String? _createdAt;
  String? _user;
  String? _reportCategory;
  String? _source;
  String? _mainImage;
  num? _languageId;
  num? _views;
ReportsDetails copyWith({  num? id,
  String? title,
  String? description,
  String? createdAt,
  String? user,
  String? reportCategory,
  String? source,
  String? mainImage,
  num? languageId,
  num? views,
}) => ReportsDetails(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  user: user ?? _user,
  reportCategory: reportCategory ?? _reportCategory,
  source: source ?? _source,
  mainImage: mainImage ?? _mainImage,
  languageId: languageId ?? _languageId,
  views: views ?? _views,
);
  num? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get user => _user;
  String? get reportCategory => _reportCategory;
  String? get source => _source;
  String? get mainImage => _mainImage;
  num? get languageId => _languageId;
  num? get views => _views;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['user'] = _user;
    map['report_category'] = _reportCategory;
    map['source'] = _source;
    map['main_image'] = _mainImage;
    map['language_id'] = _languageId;
    map['views'] = _views;
    return map;
  }

}