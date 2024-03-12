class Data {
  Data({
      this.id, 
      this.caption, 
      this.location, 
      this.languageId, 
      this.createdAt, 
      this.user, 
      this.image, 
      this.photographer,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    caption = json['caption'];
    location = json['location'];
    languageId = json['language_id'];
    createdAt = json['created_at'];
    user = json['user'];
    image = json['image'];
    photographer = json['photographer'];
  }
  int ?id;
  String? caption;
  String ?location;
  int ?languageId;
  String? createdAt;
  String? user;
  String? image;
  String? photographer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['caption'] = caption;
    map['location'] = location;
    map['language_id'] = languageId;
    map['created_at'] = createdAt;
    map['user'] = user;
    map['image'] = image;
    map['photographer'] = photographer;
    return map;
  }

}