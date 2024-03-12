class Filters {
  Filters({
      this.search,});

  Filters.fromJson(dynamic json) {
    search = json['search'];
  }
  String? search;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['search'] = search;
    return map;
  }

}