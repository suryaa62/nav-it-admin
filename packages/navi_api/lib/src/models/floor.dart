import 'package:json_annotation/json_annotation.dart';

part 'floor.g.dart';

@JsonSerializable()
class Floor {
  Floor({required this.floorId, required this.buildingId, required this.level, required this.imageId});

  factory Floor.fromJson(Map<String, dynamic> json) => _$FloorFromJson(json);

  Map<String, dynamic> toJson() => _$FloorToJson(this);

  @JsonKey(name: "_id")
  final String floorId;
  final String buildingId;
  final int level;
  final String imageId;
}
