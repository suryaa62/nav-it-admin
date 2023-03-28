part of 'view_maps_bloc.dart';

abstract class ViewMapsEvent extends Equatable {
  const ViewMapsEvent();

  @override
  List<Object?> get props => [];
}

class GetBuildingList extends ViewMapsEvent {
  const GetBuildingList();
}


class BuildingIndexChanged extends ViewMapsEvent {
  const BuildingIndexChanged(this.index);

  final int? index;

  @override
  List<Object?> get props => [index];
}

class GetFloorList extends ViewMapsEvent {
  const GetFloorList();
}


class FloorIndexChanged extends ViewMapsEvent {
  const FloorIndexChanged(this.index);

  final int? index;

  @override
  List<Object?> get props => [index];
}





//make more events , Buildingfetched , floorfetched , reloadBuilding , reloadFloor