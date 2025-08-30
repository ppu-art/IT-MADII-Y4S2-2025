import 'package:json_annotation/json_annotation.dart';

part 'faculty.g.dart';

@JsonSerializable(explicitToJson: true)
class Faculty {
  int? id;
  String? name;
  String? nameKh;
  @JsonKey(name: "user_email")
  String? email;
  String? phone;

  Faculty({this.id, this.name, this.nameKh, this.email, this.phone});

  // Serialization
  Map<String, dynamic> toJson() => _$FacultyToJson(this);

  // Deserialization
  factory Faculty.fromMap(Map<String, dynamic> json) => _$FacultyFromJson(json);
}
