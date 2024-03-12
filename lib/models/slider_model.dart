class SliderModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;
  // String? category;

  int? languageId;

  SliderModel(
      {
        this.author,
      this.content,
      this.description,
      this.title,
      this.url,
      this.urlToImage,
      this.languageId,
      // this.category
      });
       SliderModel.fromJson(dynamic json) {
    author = json['user'];
    title = json['title'];
    description = json['content'];
    url = json['id'].toString();
    urlToImage = json['image'];
    content = json['category_name'];
    languageId = json['language_id'];

  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = url;
    map['title'] = title;
    map['image'] = urlToImage;
    map['content'] = description;
    map['category_name'] = content;
    map['language_id'] = languageId;
    map['user'] = author;

    return map;
  }
}
