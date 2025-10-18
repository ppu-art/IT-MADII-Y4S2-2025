class News {
  String? id;
  String? title;
  String? content;

  News({this.id, this.title, this.content});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'content': content};
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(id: map['id'], title: map['title'], content: map['content']);
  }
}
