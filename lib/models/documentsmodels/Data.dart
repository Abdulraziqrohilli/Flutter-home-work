class Data {
  Data({
      this.id, 
      this.title, 
      this.content, 
      this.journalist, 
      this.user, 
      this.image, 
      this.createdAt, 
      this.views,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    journalist = json['journalist'];
    user = json['user'];
    image = json['image'];
    createdAt = json['created_at'];
    views = json['views'];
  }
  int ?id;
  String ?title;
  String ?content;
  String ?journalist;
  String ?user;
  String ?image;
  String ?createdAt;
  int? views;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['content'] = content;
    map['journalist'] = journalist;
    map['user'] = user;
    map['image'] = image;
    map['created_at'] = createdAt;
    map['views'] = views;
    return map;
  }

}