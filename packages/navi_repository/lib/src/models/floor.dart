import 'package:cross_file/cross_file.dart';
import 'package:equatable/equatable.dart';

class Floor extends Equatable {
  const Floor(
      {this.id,
      this.imageFile,
      required this.buildingId,
      this.imageId,
      required this.level});

  @override
  String toString() {
    return "id : $id , imageId : ${imageFile?.name}, name : $level";
  }

  final String? id;
  final String buildingId;
  final XFile? imageFile;
  final String? imageId;
  final int level;

  @override
  List<Object?> get props => [id, buildingId, imageFile, imageId, level];
}
