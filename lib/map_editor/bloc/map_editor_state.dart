part of 'map_editor_bloc.dart';

enum MapEditorStatus {
  map,
  bottomSheet,
  busy,
  notBusy,
  success,
  error,
  refresh,
}

class MapEditorState extends Equatable {
  const MapEditorState({
    this.canAdd = false,
    this.canAddLink = false,
    required this.floorId,
    required this.imageId,
    this.status = MapEditorStatus.map,
    this.x,
    this.y,
    this.node1Id = "",
    this.refresh = 0,
  });

  final bool canAdd;
  final String floorId;
  final String imageId;
  final MapEditorStatus status;
  final double? x;
  final double? y;
  final bool canAddLink;
  final String node1Id;
  final int refresh;

  MapEditorState copyWith({
    bool? canAdd,
    bool? canAddLink,
    MapEditorStatus? status,
    double? x,
    double? y,
    String? node1Id,
    int? refresh,
  }) {
    return MapEditorState(
        status: status ?? this.status,
        canAdd: canAdd ?? this.canAdd,
        x: x ?? this.x,
        y: y ?? this.y,
        canAddLink: canAddLink ?? this.canAddLink,
        floorId: floorId,
        imageId: imageId,
        node1Id: node1Id ?? this.node1Id,
        refresh: refresh ?? this.refresh);
  }

  @override
  List<Object?> get props => [canAdd, status, x, y, canAddLink, node1Id , refresh];
}
