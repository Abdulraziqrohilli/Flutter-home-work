class ShowCategoryModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;
  String? createAt;

  ShowCategoryModel(
      {this.author,
      this.content,
      this.description,
      this.title,
      this.url,
      this.urlToImage,
      this.createAt});
  ShowCategoryModel.fromJson(dynamic element) {
    // author = json['id'];
    // title = json['title'];
    // description = json['content'];
    // url = json['id'].toString();
    // urlToImage = json['image'];
    // // content = json['views'];
    title=
    element["title"];
    description=
    element["category_name"];
    url=    element["id"].toString();
    urlToImage=
    element["image"];
    content=
    element["content"];
    author=
    element["author"];
    createAt=
    element["created_at"];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = url;
    map['title'] = title;
    map['image'] = urlToImage;
    map['content'] = description;
    return map;
  }
}
