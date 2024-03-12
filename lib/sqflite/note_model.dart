class Detailss {
  int? newsId;
  String? title;
  String? description;
  int? userId;
  String? createdAt;
  String? user;
  String? source;
  String? image;
  int? languageId;
  String? views;
  String? category;

  Detailss(
      {this.newsId,
      required this.title,
      required this.description,
      required this.userId,
      required this.createdAt,
      required this.user,
      required this.source,
      required this.image,
      required this.languageId,
      required this.views,
      required this.category,
      
      });

  factory Detailss.fromMap(Map<String, dynamic> json) => Detailss(
        newsId: json['newsId'],
        title: json['title'],
        description: json['description'],
        userId: json['userId'],
        createdAt: json['createdAt'],
        user: json['user'],
        source: json['source'],
        image: json['image'],
        languageId: json['languageId'],
        views: json['views'],
        category: json['category'],

      );

  Map<String, dynamic> toMap() {
    return {
      'newsId': newsId,
      'title': title,
      'description': description,
      'userId': userId,
      'createdAt': createdAt,
      'user': user,
      'source': source,
      'image': image,
      'languageId': languageId,
      'views': views,
      'category': category,

    };
  }
}
