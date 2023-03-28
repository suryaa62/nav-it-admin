import 'package:cross_file/cross_file.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Building  extends Equatable{
  const Building({this.id, required this.imageFile, required this.name});

  @override
  String toString() {
    return "id : $id , imageId : ${imageFile.name}, name : $name";
  }

  final String? id;
  final String name;
  final XFile imageFile;
  
  @override
  List<Object?> get props => throw [id , name , imageFile];
}
