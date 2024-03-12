
// https://hurriyat.net/api/videos/2/2
class Data {
  Data({
      this.id, 
      this.title, 
      this.videoType, 
      this.videoId, 
      this.createdAt, 
      this.user, 
      this.image, 
      this.content, 
      this.views,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    videoType = json['video_type'];
    videoId = json['video_id'];
    createdAt = json['created_at'];
    user = json['user'];
    image = json['image'];
    content = json['content'];
    views = json['views'];
  }
  int? id;
  String? title;
  int ?videoType;
  String? videoId;
  String? createdAt;
  String? user;
  String? image;
  String? content;
  int ?views;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['video_type'] = videoType;
    map['video_id'] = videoId;
    map['created_at'] = createdAt;
    map['user'] = user;
    map['image'] = image;
    map['content'] = content;
    map['views'] = views;
    return map;
  }

}