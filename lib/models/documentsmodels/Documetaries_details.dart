class DocumetariesDetails {
  DocumetariesDetails({
      this.id, 
      this.title, 
      this.content, 
      this.writer, 
      this.editor, 
      this.journalist, 
      this.source, 
      this.user, 
      this.image, 
      this.createdAt, 
      this.views,});

  DocumetariesDetails.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    writer = json['writer'];
    editor = json['editor'];
    journalist = json['journalist'];
    source = json['source'];
    user = json['user'];
    image = json['image'];
    createdAt = json['created_at'];
    views = json['views'];
  }
  int ?id;
  String? title;
  String ?content;
  String ?writer;
  String ?editor;
  String ?journalist;
  dynamic? source;
  String ?user;
  String ?image;
  String ?createdAt;
  int ?views;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['content'] = content;
    map['writer'] = writer;
    map['editor'] = editor;
    map['journalist'] = journalist;
    map['source'] = source;
    map['user'] = user;
    map['image'] = image;
    map['created_at'] = createdAt;
    map['views'] = views;
    return map;
  }

}