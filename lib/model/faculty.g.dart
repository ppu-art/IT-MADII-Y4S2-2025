// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faculty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Faculty _$FacultyFromJson(Map<String, dynamic> json) => Faculty(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  nameKh: json['nameKh'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$FacultyToJson(Faculty instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'nameKh': instance.nameKh,
  'email': instance.email,
  'phone': instance.phone,
};
