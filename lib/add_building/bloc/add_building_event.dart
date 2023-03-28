part of 'add_building_bloc.dart';

abstract class AddBuildingEvent extends Equatable {
  const AddBuildingEvent();

  @override
  List<Object> get props => [];
}

class BuildingNameChanged extends AddBuildingEvent {
  const BuildingNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class BuildingImageChanged extends AddBuildingEvent {
  const BuildingImageChanged(this.image);

  final XFile image;

  @override
  List<Object> get props => [image];
}

class BuildingAddedSuccesfully extends AddBuildingEvent {
  const BuildingAddedSuccesfully();
}

class ErrorOcured extends AddBuildingEvent {
  const ErrorOcured();
}

class Loading extends AddBuildingEvent {
  const Loading();
}

class BuildingSubmitted extends AddBuildingEvent {
  const BuildingSubmitted();
}
