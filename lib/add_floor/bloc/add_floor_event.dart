part of 'add_floor_bloc.dart';

abstract class AddFloorEvent extends Equatable {
  const AddFloorEvent();

  @override
  List<Object> get props => [];
}

class GetBuildingList extends AddFloorEvent {
  const GetBuildingList();
}


class BuildingIndexChanged extends AddFloorEvent {
  const BuildingIndexChanged(this.index);

  final String index;

  @override
  List<Object> get props => [index];
}

class FloorLevelChanged extends AddFloorEvent {
  const FloorLevelChanged(this.level);

  final int level;

  @override
  List<Object> get props => [level];
}

class FloorImageChanged extends AddFloorEvent {
  const FloorImageChanged(this.image);

  final XFile image;

  @override
  List<Object> get props => [image];
}

class FloorAddedSuccesfully extends AddFloorEvent {
  const FloorAddedSuccesfully();
}

class ErrorOcured extends AddFloorEvent {
  const ErrorOcured();
}

class Loading extends AddFloorEvent {
  const Loading();
}

class FloorSubmitted extends AddFloorEvent {
  const FloorSubmitted();
}
