part of 'add_node_bloc.dart';

enum NodeType {
  canteen,
  classroom,
  elevator,
  exit,
  fire_extinguisher,
  labs,
  mens_room,
  shops,
  smart_class,
  staff_room,
  staircase,
  stationery,
  water_cooler,
  path,
  womens_room,
  office,
}

//TODO: Addmore

enum AddNodeStatus {
  busy,
  error,
  success,
  free,
}

extension ParseToString on NodeType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class AddNodeState extends Equatable {
  const AddNodeState(
      {required this.x,
      required this.y,
      this.desc = "",
      required this.floorId,
      this.nodeType = NodeType.classroom,
      this.label = "",
      required this.status});

  final double x;
  final double y;
  final String desc;
  final String label;
  final String floorId;
  final NodeType nodeType;
  final AddNodeStatus status;

  AddNodeState copyWith(
      {NodeType? nodeType,
      String? label,
      String? desc,
      AddNodeStatus? status}) {
    return AddNodeState(
        x: x,
        y: y,
        status: status ?? this.status,
        floorId: floorId,
        nodeType: nodeType ?? this.nodeType,
        label: label ?? this.label,
        desc: desc ?? this.desc);
  }

  @override
  List<Object> get props => [x, y, desc, label, floorId, nodeType, status];
}
