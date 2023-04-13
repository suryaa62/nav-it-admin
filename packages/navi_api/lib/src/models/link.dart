import 'package:json_annotation/json_annotation.dart';

part 'link.g.dart';

@JsonSerializable()
class Link {
  Link(
      {required this.floorId,
      required this.linkId1,
      required this.id,
      required this.linkId2});

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToJson(this);

  @JsonKey(name: "_id")
  final String id;
  final String floorId;
  final String linkId1;
  final String linkId2;
}
