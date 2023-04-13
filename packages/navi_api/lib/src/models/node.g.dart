// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Node _$NodeFromJson(Map<String, dynamic> json) => Node(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      id: json['_id'] as String,
      desc: json['desc'] as String,
      floorId: json['floorId'] as String,
      label: json['label'] as String,
      type: json['type'] as String,
      ssid: json['ssid'] as String?,
    );

Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      '_id': instance.id,
      'type': instance.type,
      'floorId': instance.floorId,
      'label': instance.label,
      'desc': instance.desc,
      'ssid': instance.ssid,
    };
