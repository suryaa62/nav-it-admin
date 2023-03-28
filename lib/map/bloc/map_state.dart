part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class NoMapSelectedState extends MapState {}

class MapLoading extends MapState {}

class MapDataState extends MapState {
  MapDataState({required this.imageBuffer, required this.floorId , required this.imageId});

  final String floorId;
  final String imageId;
  final Uint8List imageBuffer;

  @override
  List<Object> get props => [imageBuffer];
}
