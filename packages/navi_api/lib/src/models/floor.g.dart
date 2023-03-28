// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Floor _$FloorFromJson(Map<String, dynamic> json) => Floor(
      floorId: json['_id'] as String,
      buildingId: json['buildingId'] as String,
      level: json['level'] as int,
      imageId: json['imageId'] as String,
    );

Map<String, dynamic> _$FloorToJson(Floor instance) => <String, dynamic>{
      '_id': instance.floorId,
      'buildingId': instance.buildingId,
      'level': instance.level,
      'imageId': instance.imageId,
    };
