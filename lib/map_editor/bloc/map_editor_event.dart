part of 'map_editor_bloc.dart';

abstract class MapEditorEvent extends Equatable {
  const MapEditorEvent();

  @override
  List<Object> get props => [];
}

class ToggleCanAddTo extends MapEditorEvent {
  ToggleCanAddTo(this.to);

  bool to;

  @override
  List<Object> get props => [to];
}

class ToggleCanAddLinkTo extends MapEditorEvent {
  ToggleCanAddLinkTo(this.to);

  bool to;

  @override
  List<Object> get props => [to];
}

class ClickedOnANode extends MapEditorEvent {
  ClickedOnANode({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}

class ShowBottamSheet extends MapEditorEvent {}

class TappedOnXY extends MapEditorEvent {
  TappedOnXY({required this.x, required this.y});

  double x;
  double y;

  @override
  List<Object> get props => [x, y];
}

class CloseBottomSheet extends MapEditorEvent {}

class Refresh extends MapEditorEvent {}
