part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class getNewMap extends MapEvent {
  getNewMap({required this.imageId , required this.floorId}) {
  }

  final String imageId;
  final String floorId;
}
