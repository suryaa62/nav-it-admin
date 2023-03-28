// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Node _$NodeFromJson(Map<String, dynamic> json) => Node(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      id: json['id'] as String,
      description: json['description'] as String,
      floorId: json['floorId'] as String,
      iconId: json['iconId'] as String,
      searchTags: json['searchTags'] as String,
      showText: json['showText'] as String,
      type: json['type'] as String,
      ssid: json['ssid'] as String?,
    );

Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'id': instance.id,
      'type': instance.type,
      'floorId': instance.floorId,
      'showText': instance.showText,
      'description': instance.description,
      'searchTags': instance.searchTags,
      'iconId': instance.iconId,
      'ssid': instance.ssid,
    };
