// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      id: json['_id'] as String?,
      image: json['image'] as String,
      mime_type: json['mime_type'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'mime_type': instance.mime_type,
      'image': instance.image,
      'name': instance.name,
    };
