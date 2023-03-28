import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:navi_repository/navi_repository.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc({required this.naviRepository}) : super(NoMapSelectedState()) {
    on<getNewMap>((event, emit) => _onGetNewMap(event, emit));
  }

  final NaviRepository naviRepository;

  Future<void> _onGetNewMap(getNewMap event, Emitter<MapState> emit) async {
    try {
      emit(MapLoading());
      Uint8List imageBuffer =
          await naviRepository.getImageAsBuffer(event.imageId);
      emit(MapDataState(imageBuffer: imageBuffer, floorId: event.floorId , imageId: event.imageId));
    } catch (e) {
      print(e);
    }
  }
}
