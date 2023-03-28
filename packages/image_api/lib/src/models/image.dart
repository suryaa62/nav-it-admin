import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class ImageModel {
  ImageModel(
      {this.id,
      required this.image,
      required this.mime_type,
      required this.name});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);

  @JsonKey(name: "_id")
  final String? id;
  final String mime_type;
  final String image;
  final String name;
}
