part of 'map_drawer_bloc.dart';

class MapDrawerState extends Equatable {
  MapDrawerState(
      {required this.floorId, this.nodes = const [], this.links = const []});

  final List<Node> nodes;
  final List<Link> links;
  final String floorId;

  MapDrawerState copyWith({List<Node>? nodes, List<Link>? links}) {
    return MapDrawerState(
        floorId: floorId,
        nodes: nodes ?? this.nodes,
        links: links ?? this.links);
  }

  @override
  List<Object> get props => [nodes, links];
}
