// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      floorId: json['floorId'] as String,
      linkId1: json['linkId1'] as String,
      id: json['_id'] as String,
      linkId2: json['linkId2'] as String,
    );

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      '_id': instance.id,
      'floorId': instance.floorId,
      'linkId1': instance.linkId1,
      'linkId2': instance.linkId2,
    };
