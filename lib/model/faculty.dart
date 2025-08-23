class Faculty {
  String? title;
  String? titleKm;

  Faculty({this.title, this.titleKm});

  Map<String, dynamic> toMap() {
    return {'title': title, 'titleKm': titleKm};
  }

  factory Faculty.fromMap(Map<String, dynamic> map) {
    String title = map["title"] ?? "";
    String titleKm = map["title_km"] ?? "";
    return Faculty(title: title, titleKm: titleKm);
  }
}
