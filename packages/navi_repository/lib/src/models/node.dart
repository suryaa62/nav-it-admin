import 'package:equatable/equatable.dart';

class Node extends Equatable {
  Node(
      {required this.x,
      required this.desc,
      required this.floorId,
      required this.label,
      required this.type,
      required this.y,
      this.id,
      this.ssid});

  double x;
  double y;
  String label;
  String desc;
  String type;
  String floorId;
  String? id;
  String? ssid;

  @override
  List<Object?> get props => [x, y, desc, label, type, floorId, id , ssid];
}
