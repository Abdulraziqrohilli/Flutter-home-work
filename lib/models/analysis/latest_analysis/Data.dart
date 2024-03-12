class Data {
  Data({
      this.id, 
      this.title, 
      this.user, 
      this.image, 
      this.views,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    user = json['user'];
    image = json['image'];
    views = json['views'];
  }
  int ?id;
  String? title;
  String? user;
  String? image;
  int ?views;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['user'] = user;
    map['image'] = image;
    map['views'] = views;
    return map;
  }

}