class Menu {
  int? id;
  String? title;
  String? description;

  Menu({this.id, this.title, this.description});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'description': description};
  }

  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}
