class ArticleModel {
  // String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;
  String? created_at;


  ArticleModel({
    //   this.author,
    this.content,
    this.description,
    this.title,
    this.url,
    this.urlToImage,
    this.created_at,
  });
  ArticleModel.fromJson(dynamic json) {
    // author = json['id'];
    title = json['title'];
    description = json['content'];
    url = json['id'].toString();
    urlToImage = json['image'];
    content = json['category_name'];
    created_at = json['created_at'];

    // content = json['views'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = url;
    map['title'] = title;
    map['image'] = urlToImage;
    map['content'] = description;
    map['category_name'] = content;
    map['created_at'] = created_at;
    

    return map;
  }
}
// class Data {
//   Data({
//       this.id, 
//       this.title, 
//       this.host, 
//       this.user, 
//       this.image, 
//       this.views,});

//   Data.fromJson(dynamic json) {
//     id = json['id'];
//     title = json['title'];
//     host = json['host'];
//     user = json['user'];
//     image = json['image'];
//     views = json['views'];
//   }
//   int ?id;
//   String? title;
//   String? host;
//   String? user;
//   String? image;
//   int ?views;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['title'] = title;
//     map['host'] = host;
//     map['user'] = user;
//     map['image'] = image;
//     map['views'] = views;
//     return map;
//   }
