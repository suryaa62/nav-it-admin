import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navi_repository/navi_repository.dart';

part 'map_drawer_event.dart';
part 'map_drawer_state.dart';

class MapDrawerBloc extends Bloc<MapDrawerEvent, MapDrawerState> {
  MapDrawerBloc({required String floorId, required this.naviRepository})
      : super(MapDrawerState(floorId: floorId)) {
    on<GetNodes>((event, emit) => _onGetNodes(event, emit));
    on<GetLinks>((event, emit) => _onGetLinks(event, emit));
  }

  final NaviRepository naviRepository;

  void _onGetNodes(GetNodes event, Emitter<MapDrawerState> emit) async {
    try {
      List<Node> nodes =
          await naviRepository.getAllNodes(floorId: state.floorId);
      emit(state.copyWith(nodes: nodes));
      
      if (event.canEdit) {
        add(GetLinks());
      }
    } catch (e) {
      print(e);
    }
  }

  void _onGetLinks(GetLinks event, Emitter<MapDrawerState> emit) async {
    try {
      List<Link> links =
          await naviRepository.getAllLinks(floorId: state.floorId);
      emit(state.copyWith(links: links));
    } catch (e) {
      print(e);
    }
  }
}
