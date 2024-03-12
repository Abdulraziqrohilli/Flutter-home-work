class AnalysisDetails {
  AnalysisDetails({
      this.id, 
      this.title, 
      this.description, 
      this.createdAt, 
      this.writer, 
      this.user, 
      this.source, 
      this.mainImage, 
      this.languageId, 
      this.views,});

  AnalysisDetails.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    writer = json['writer'];
    user = json['user'];
    source = json['source'];
    mainImage = json['main_image'];
    languageId = json['language_id'];
    views = json['views'];
  }
  int ?id;
  String? title;
  String? description;
  String? createdAt;
  String? writer;
  String? user;
  String ?source;
  String ?mainImage;
  int ?languageId;
  int ?views;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['created_at'] = createdAt;
    map['writer'] = writer;
    map['user'] = user;
    map['source'] = source;
    map['main_image'] = mainImage;
    map['language_id'] = languageId;
    map['views'] = views;
    return map;
  }

}