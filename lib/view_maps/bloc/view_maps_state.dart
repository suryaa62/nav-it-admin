part of 'view_maps_bloc.dart';

enum ViewMapsStatus {
  busy,
  error,
  success,
  notBusy,
}

class ViewMapsState extends Equatable {
  const ViewMapsState(
      {required this.buildings,
      this.currBuilding,
      this.currFloor,
      required this.floors,
      required this.status,
      this.imageId});

  final List<Map<String, String>> buildings;
  final List<Floor> floors;
  final int? currBuilding;
  final int? currFloor;
  final String? imageId;
  final ViewMapsStatus status;

  ViewMapsState copyWith(
      {List<Map<String, String>>? buildings,
      List<Floor>? floors,
      int? currBuilding,
      int? currFloor,
      String? imageId,
      ViewMapsStatus? status}) {
    return ViewMapsState(
        buildings: buildings ?? this.buildings,
        currBuilding: currBuilding ?? this.currBuilding,
        floors: floors ?? this.floors,
        currFloor: currFloor ?? this.currFloor,
        imageId: imageId ?? this.imageId,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props =>
      [buildings, currBuilding, floors, currFloor, imageId];
}


// floorbusy and buildingbusy
