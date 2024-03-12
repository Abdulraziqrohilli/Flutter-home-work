import 'dart:convert';
/// data : [{"id":36,"title":"راتلونکي کال کې به ۲۰ زره ځوانان د فریلانسېنګ په برخه کې وروزل شي","category_name":"Technology","user":"Nasim","image":"https://hurriyat.net/storage/news_images//CVEMWuDSFZaDmBLRJ4nFfzgtgOikBZ-meta27LbsCDYstix2Ycg2oHZiNin2YbYp9mGINivINmB2LHbjNmE2KfZhtiz25DZhtqrINm+2Ycg2KjYsdiu2Ycg2qnbkCDZiNix2YjYstmEINqp25DaltmKLmpwZw==-.webp","views":3},{"id":35,"title":"ننګرهار ښار کې د امنيتي کیمرو په لګولو سره د جرمونو کچه هم راټيټه شوې ","category_name":"Afghanistan","user":"Nasim","image":"https://hurriyat.net/storage/news_images//NT3dPiorp4GH2pW9pY4XfUsvV6n6Ya-meta2YbZhtqr2LHZh9in2LEg2prYp9ixINqp25Ag2K8g2KfZhdmG2YrYqtmKINqp24zZhdix2Ygg2b7ZhyDZhNqr2YjZhNmIINiz2LHZhyDYryDYrNix2YXZiNmG2Ygg2qnahtmHINmH2YUg2LHYp9m82YrZvNmHINi02YjbkC5qcGc=-.webp","views":2},{"id":33,"title":"د سالنګ لویې لارې له خلاصیدو سره به په صادراتو او واریداتو کې د پام وړ زیاتوالی راشي","category_name":"Development","user":"Nasim","image":"https://hurriyat.net/storage/news_images//y44KWsn87aVVBnHxK9WDvH1q12yH9y-meta2K8g2LPYp9mE2YbaqyDZhNmI24zbkCDZhNin2LHbkCDZhNmHINiu2YTYp9i124zYr9mIINiz2LHZhyDYqNmHINm+2Ycg2LXYp9iv2LHYp9iq2Ygg2KfZiCDZiNin2LHbjNiv2KfYqtmIINqp25Ag2K8g2b7Yp9mFINmI2pMg2LLbjNin2KrZiNin2YTbjCDYsdin2LTZii5qcGc=-.webp","views":1},{"id":31,"title":"د تورخم عمري پنډ غالي کې ټولې اسانتیاوې برابري شوې دي","category_name":"Afghanistan","user":"Nasim","image":"https://hurriyat.net/storage/news_images//gcYlLVUUYZABon32rdBdgOuayQzfPj-meta2K8g2KrZiNix2K7ZhSDYudmF2LHZiiDZvtmG2okg2LrYp9mE2Yog2qnbkCDZvNmI2YTbkCDYp9iz2KfZhtiq24zYp9mI25Ag2KjYsdin2KjYsdmKINi02YjbkCDYr9mKLmpwZw==-.webp","views":3},{"id":30,"title":"کندهار کې ۵۰۰ کروندګرو ته د زعفرانو اصلاح شوي تخمونه و وېشل شول","category_name":"Afghanistan","user":"Nasim","image":"https://hurriyat.net/storage/news_images//q30IgsbVCk0k3V9sSZUrBPtpIDsnhl-meta2qnZhtiv2YfYp9ixINqp25Ag27XbsNuwINqp2LHZiNmG2K_aq9ix2Ygg2KrZhyDYryDYsti52YHYsdin2YbZiCDYp9i12YTYp9itINi02YjZiiDYqtiu2YXZiNmG2Ycg2Ygg2YjbkNi02YQg2LTZiNmELmpwZw==-.webp","views":1},{"id":29,"title":"د ننګرهار په هسکې مېنې ولسوالۍ کې د روغتون جوړولو چارې پیل شوې","category_name":"Health","user":"Nasim","image":"https://hurriyat.net/storage/news_images//VOSmk4APB8ZdmdJcUwgDCcXLxZXFKn-meta2K8g2YbZhtqr2LHZh9in2LEg2b7ZhyDZh9iz2qnbkCDZhduQ2YbbkCDZiNmE2LPZiNin2YTbjSDaqduQINivINix2YjYutiq2YjZhiDYrNmI2pPZiNmE2Ygg2obYp9ix25Ag2b7bjNmEINi02YjbkC5qcGc=-.webp","views":2}]

LatestReport latestReportFromJson(String str) => LatestReport.fromJson(json.decode(str));
String latestReportToJson(LatestReport data) => json.encode(data.toJson());
class LatestReport {
  LatestReport({
      List<Data>? data,}){
    _data = data;
}

  LatestReport.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? _data;
LatestReport copyWith({  List<Data>? data,
}) => LatestReport(  data: data ?? _data,
);
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 36
/// title : "راتلونکي کال کې به ۲۰ زره ځوانان د فریلانسېنګ په برخه کې وروزل شي"
/// category_name : "Technology"
/// user : "Nasim"
/// image : "https://hurriyat.net/storage/news_images//CVEMWuDSFZaDmBLRJ4nFfzgtgOikBZ-meta27LbsCDYstix2Ycg2oHZiNin2YbYp9mGINivINmB2LHbjNmE2KfZhtiz25DZhtqrINm+2Ycg2KjYsdiu2Ycg2qnbkCDZiNix2YjYstmEINqp25DaltmKLmpwZw==-.webp"
/// views : 3

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      String? title, 
      String? categoryName, 
      String? user, 
      String? image, 
      num? views,}){
    _id = id;
    _title = title;
    _categoryName = categoryName;
    _user = user;
    _image = image;
    _views = views;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _categoryName = json['category_name'];
    _user = json['user'];
    _image = json['image'];
    _views = json['views'];
  }
  num? _id;
  String? _title;
  String? _categoryName;
  String? _user;
  String? _image;
  num? _views;
Data copyWith({  num? id,
  String? title,
  String? categoryName,
  String? user,
  String? image,
  num? views,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  categoryName: categoryName ?? _categoryName,
  user: user ?? _user,
  image: image ?? _image,
  views: views ?? _views,
);
  num? get id => _id;
  String? get title => _title;
  String? get categoryName => _categoryName;
  String? get user => _user;
  String? get image => _image;
  num? get views => _views;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['category_name'] = _categoryName;
    map['user'] = _user;
    map['image'] = _image;
    map['views'] = _views;
    return map;
  }

}