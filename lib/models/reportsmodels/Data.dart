class Data {
  Data({
      this.id, 
      this.title, 
      this.categoryName, 
      this.createdAt, 
      this.user, 
      this.image, 
      this.content, 
      this.views,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    categoryName = json['category_name'];
    createdAt = json['created_at'];
    user = json['user'];
    image = json['image'];
    content = json['content'];
    views = json['views'];
  }
  int? id;
  String? title;
  String ?categoryName;
  String ?createdAt;
  String ?user;
  String ?image;
  String ?content;
  int ?views;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['category_name'] = categoryName;
    map['created_at'] = createdAt;
    map['user'] = user;
    map['image'] = image;
    map['content'] = content;
    map['views'] = views;
    return map;
  }

}