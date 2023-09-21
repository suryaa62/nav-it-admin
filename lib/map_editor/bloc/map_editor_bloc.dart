import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navi_repository/navi_repository.dart';
import 'package:navi_repository/src/models/models.dart';

part 'map_editor_event.dart';
part 'map_editor_state.dart';

class MapEditorBloc extends Bloc<MapEditorEvent, MapEditorState> {
  MapEditorBloc(
      {required this.naviRepository,
      required String floorId,
      required String imageId})
      : super(MapEditorState(floorId: floorId, imageId: imageId)) {
    on<ToggleCanAddTo>((event, emit) => _onToggleCanAddTo(event, emit));
    on<ToggleCanAddLinkTo>((event, emit) => _onToggleCanAddLinkTo(event, emit));
    on<ShowBottamSheet>(((event, emit) => _onShowBottomSheet(event, emit)));
    on<TappedOnXY>(((event, emit) => _onTappedOnXY(event, emit)));
    on<CloseBottomSheet>(((event, emit) => _onCloseBottomSheet(event, emit)));
    on<ClickedOnANode>(((event, emit) => _onClickedOnANode(event, emit)));
    on<Refresh>(((event, emit) => _onRefresh(event, emit)));
  }

  final NaviRepository naviRepository;

  void _onToggleCanAddTo(ToggleCanAddTo event, Emitter<MapEditorState> emit) {
    emit(state.copyWith(canAdd: event.to));
  }

  void _onToggleCanAddLinkTo(
      ToggleCanAddLinkTo event, Emitter<MapEditorState> emit) {
    emit(state.copyWith(canAddLink: event.to, node1Id: ""));
  }

  void _onShowBottomSheet(ShowBottamSheet event, Emitter<MapEditorState> emit) {
    emit(state.copyWith(status: MapEditorStatus.bottomSheet));
  }

  void _onTappedOnXY(TappedOnXY event, Emitter<MapEditorState> emit) {
    emit(state.copyWith(x: event.x, y: event.y));
    print("bloc : ${event.x} , ${event.y}");
    print("state : ${state.copyWith(x: event.x).x}");
  }

  void _onCloseBottomSheet(
      CloseBottomSheet event, Emitter<MapEditorState> emit) {
    emit(state.copyWith(status: MapEditorStatus.map));
  }

  void _onRefresh(Refresh event, Emitter<MapEditorState> emit) async {
    emit(state.copyWith(status: MapEditorStatus.refresh));
    await Future.delayed(Duration(seconds: 2),
        () => emit(state.copyWith(status: MapEditorStatus.map)));
  }

  void _onClickedOnANode(
      ClickedOnANode event, Emitter<MapEditorState> emit) async {
    if (state.canAddLink) {
      if (state.node1Id == "") {
        emit(state.copyWith(node1Id: event.id));
      } else {
        try {
          print("here");
          emit(state.copyWith(status: MapEditorStatus.busy));
          await naviRepository.addLink(
              link: Link(
                  id: "",
                  floorId: state.floorId,
                  link1Id: state.node1Id,
                  link2Id: event.id));

          print("success");
          emit(state.copyWith(status: MapEditorStatus.notBusy, node1Id: ""));
          add(Refresh());
        } catch (e) {
          //Error
          print(e);
        }
        // print("Connected: ${state.node1Id} & ${state.node2Id}");
        // emit(state.copyWith(node1Id: "", node2Id: ""));
      }
    }
    // emit(state.copyWith(status: MapEditorStatus.map));
  }
}
