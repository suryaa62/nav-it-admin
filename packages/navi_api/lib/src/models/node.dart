import 'package:json_annotation/json_annotation.dart';

part 'node.g.dart';

@JsonSerializable()
class Node {
  Node(
      {required this.x,
      required this.y,
      required this.id,
      required this.desc,
      required this.floorId,
      required this.label,
      required this.type,
      this.ssid});

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);

  Map<String, dynamic> toJson() => _$NodeToJson(this);

  final double x;
  final double y;
  @JsonKey(name: "_id")
  final String id;
  final String type;
  final String floorId;
  final String label;
  final String desc;
  String? ssid;
}
