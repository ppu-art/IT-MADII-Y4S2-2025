import 'package:json_annotation/json_annotation.dart';

part 'faculty.g.dart';

@JsonSerializable(explicitToJson: true)
class Faculty {
  String? id;
  @JsonKey(name: "nameEn")
  String? name;
  @JsonKey(name: "nameKh")
  String? nameKh;

  Faculty({this.id, this.name, this.nameKh});

  // Serialization
  Map<String, dynamic> toJson() => _$FacultyToJson(this);

  // Deserialization
  factory Faculty.fromMap(Map<String, dynamic> json) => _$FacultyFromJson(json);
}
