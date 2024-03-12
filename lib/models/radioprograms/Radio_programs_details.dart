class RadioProgramsDetails {
  RadioProgramsDetails({
      this.id, 
      this.title, 
      this.description, 
      this.createdAt, 
      this.user, 
      this.host, 
      this.videoLink, 
      this.mainImage, 
      this.languageId, 
      this.views,});

  RadioProgramsDetails.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    user = json['user'];
    host = json['host'];
    videoLink = json['video_link'];
    mainImage = json['main_image'];
    languageId = json['language_id'];
    views = json['views'];
  }
  int? id;
  String? title;
  String ?description;
  String ?createdAt;
  String ?user;
  String ?host;
  String ?videoLink;
  String ?mainImage;
  int ?languageId;
  int ?views;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['created_at'] = createdAt;
    map['user'] = user;
    map['host'] = host;
    map['video_link'] = videoLink;
    map['main_image'] = mainImage;
    map['language_id'] = languageId;
    map['views'] = views;
    return map;
  }

}