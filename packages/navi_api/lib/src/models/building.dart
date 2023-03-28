import 'package:json_annotation/json_annotation.dart';

part 'building.g.dart';

@JsonSerializable()
class Building {
  Building({this.id, required this.imageId, required this.name});

  factory Building.fromJson(Map<String, dynamic> json) =>
      _$BuildingFromJson(json);

  Map<String, dynamic> toJson() => _$BuildingToJson(this);

  @override
  String toString() {
    return "id : $id , imageId : $imageId , name : $name";
  }

  @JsonKey(name: "_id")
  String? id;
  final String name;
  final String imageId;
}
