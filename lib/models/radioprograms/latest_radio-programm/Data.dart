class Data {
  Data({
      this.id, 
      this.title, 
      this.host, 
      this.user, 
      this.image, 
      this.views,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    host = json['host'];
    user = json['user'];
    image = json['image'];
    views = json['views'];
  }
  int ?id;
  String? title;
  String? host;
  String? user;
  String? image;
  int ?views;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['host'] = host;
    map['user'] = user;
    map['image'] = image;
    map['views'] = views;
    return map;
  }

}