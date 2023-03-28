import 'package:json_annotation/json_annotation.dart';

part 'node.g.dart';

@JsonSerializable()
class Node {
  Node(
      {required this.x,
      required this.y,
      required this.id,
      required this.description,
      required this.floorId,
      required this.iconId,
      required this.searchTags,
      required this.showText,
      required this.type,
      this.ssid});

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);

  Map<String, dynamic> toJson() => _$NodeToJson(this);

  final double x;
  final double y;
  final String id;
  final String type;
  final String floorId;
  final String showText;
  final String description;
  final String searchTags;
  final String iconId;
  String? ssid;
}
