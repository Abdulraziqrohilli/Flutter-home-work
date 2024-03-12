import 'dart:convert';

/// id : 1
/// title : "اميرخان متقي استانبول کې افغان قونسلګرۍ څخه لیدنه کړې"
/// description : "<p dir=\"rtl\"><strong>د افغانستان بهرنیو چارو وزیر مولوي امیرخان متقي د ترکیې استانبول ښار کې د افغانستان قونسلګرۍ څخه لیدنه کړې ده.</strong><br><br>د بهرنیو چارو وزارت ویاند عبدالقهار بلخي وايي، چې ښاغلي وزیر د قونسلګرۍ ډیپلوماټانو او کارمندانو ته د لا ښه خدمت ترسره کولو سپارښتنې وکړې او دوی ته یې په ټینګار وویل، « چې موږ د ټول افغان کړېدلي ولس خادمان يو، نو پکار ده چې له هېواده بهر خپلو وطنوالو او مراجعینو ته له هر ډول توپیر پرته خدمات په ډېر ښه او شفاف ډول وړاندې کړو ترڅو مو خپله ديني او ملي وجيبه ترسره کړې وي.»<br><br>بلخي زیاتوي، د قونسلګرۍ مسؤلینو دې کتنه کې ژمنه وکړه، چې پرې شوی باور به ساتي او خپله ټوله انرژي او شته مسلکي بشري ځواک به د هېوادوالو د خدمت او وطن د ترقۍ لپاره مصرفوي.<br><br>یاده دې وي، چې بهرنیو چارو وزارت تېره ورځ ترکیې ته د مولوي امیرخان متقي د سفر خبر ورکړی و.</p>"
/// created_at : "2023-10-29T06:33:47.000000Z"
/// user : "Humayoon"
/// news_category : "Afghanistan"
/// news_type : 1
/// source : null
/// main_image : "news-F9h8Cv3XoAAQBaO.jpeg"
/// caption : "مولوي امیرخان متقي استانبول کې د افغانستان قونسلګرۍ ډیپلوماټانو سره د لیدنې پر مهال"
/// language_id : 2
/// tags : ["#افغانستان","#ترکیه","#ډیپلوماتیکې اړیکې"]
/// views : 7

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));
String detailsToJson(Details data) => json.encode(data.toJson());

class Details {
  Details({
    int? id,
    String? title,
    String? description,
    String? createdAt,
    String? user,
    String? newsCategory,
    num? newsType,
    dynamic source,
    String? mainImage,
    String? caption,
    num? languageId,
    List<String>? tags,
    num? views,
  }) {
    _id = id;
    _title = title;
    _description = description;
    _createdAt = createdAt;
    _user = user;
    _newsCategory = newsCategory;
    _newsType = newsType;
    _source = source;
    _mainImage = mainImage;
    _caption = caption;
    _languageId = languageId;
    _tags = tags;
    _views = views;
  }

  Details.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _user = json['user'];
    _newsCategory = json['news_category'];
    _newsType = json['news_type'];
    _source = json['source'];
    _mainImage = json['main_image'];
    _caption = json['caption'];
    _languageId = json['language_id'];
    _tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    _views = json['views'];
  }
  int? _id;
  String? _title;
  String? _description;
  String? _createdAt;
  String? _user;
  String? _newsCategory;
  num? _newsType;
  dynamic _source;
  String? _mainImage;
  String? _caption;
  num? _languageId;
  List<String>? _tags;
  num? _views;
  Details copyWith({
    int? id,
    String? title,
    String? description,
    String? createdAt,
    String? user,
    String? newsCategory,
    num? newsType,
    dynamic source,
    String? mainImage,
    String? caption,
    num? languageId,
    List<String>? tags,
    num? views,
  }) =>
      Details(
        id: id ?? _id,
        title: title ?? _title,
        description: description ?? _description,
        createdAt: createdAt ?? _createdAt,
        user: user ?? _user,
        newsCategory: newsCategory ?? _newsCategory,
        newsType: newsType ?? _newsType,
        source: source ?? _source,
        mainImage: mainImage ?? _mainImage,
        caption: caption ?? _caption,
        languageId: languageId ?? _languageId,
        tags: tags ?? _tags,
        views: views ?? _views,
      );
  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get user => _user;
  String? get newsCategory => _newsCategory;
  num? get newsType => _newsType;
  dynamic get source => _source;
  String? get mainImage => _mainImage;
  String? get caption => _caption;
  num? get languageId => _languageId;
  List<String>? get tags => _tags;
  num? get views => _views;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['user'] = _user;
    map['news_category'] = _newsCategory;
    map['news_type'] = _newsType;
    map['source'] = _source;
    map['main_image'] = _mainImage;
    map['caption'] = _caption;
    map['language_id'] = _languageId;
    map['tags'] = _tags;
    map['views'] = _views;
    return map;
  }
}
