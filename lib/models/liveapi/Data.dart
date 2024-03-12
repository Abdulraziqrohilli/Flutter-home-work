class Data {
  Data({
      this.id, 
      this.title, 
      this.videoId, 
      this.createdAt, 
      this.updatedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    videoId = json['video_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? title;
  String? videoId;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['video_id'] = videoId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}