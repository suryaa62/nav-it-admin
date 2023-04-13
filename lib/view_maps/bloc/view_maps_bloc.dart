import 'package:bloc/bloc.dart';
import 'package:cross_file/cross_file.dart';
import 'package:equatable/equatable.dart';
import 'package:navi_repository/navi_repository.dart';

part 'view_maps_event.dart';
part 'view_maps_state.dart';

class ViewMapsBloc extends Bloc<ViewMapsEvent, ViewMapsState> {
  ViewMapsBloc({required this.naviRepository})
      : super(ViewMapsState(
            buildings: [], floors: [], status: ViewMapsStatus.busy)) {
    on<GetBuildingList>((event, emit) => _onGetBuildingList(event, emit));
    on<GetFloorList>((event, emit) => _onGetFloorList(event, emit));
    on<BuildingIndexChanged>(
        (event, emit) => _onBuildingIndexChanged(event, emit));
    on<FloorIndexChanged>((event, emit) => _onFloorIndexChanged(event, emit));
  }

  final NaviRepository naviRepository;

  void _onGetBuildingList(
      GetBuildingList event, Emitter<ViewMapsState> emit) async {
    List<Map<String, String>> buildings;

    try {
      emit(state.copyWith(status: ViewMapsStatus.busy));
      buildings = await naviRepository.getAllBuildingsName();
      emit(state.copyWith(
        buildings: buildings,
        status: ViewMapsStatus.notBusy,
      ));
    } catch (e) {
      print(e);
    }
  }

  void _onBuildingIndexChanged(
      BuildingIndexChanged event, Emitter<ViewMapsState> emit) {
    print(event.index);
    emit(state.copyWith(currBuilding: event.index));
    add(GetFloorList());
  }

  void _onGetFloorList(GetFloorList event, Emitter<ViewMapsState> emit) async {
    List<Floor> floors;

    try {
      emit(state.copyWith(status: ViewMapsStatus.busy));
      floors = await naviRepository.getAllFloorsOfBuildingId(
          state.buildings[state.currBuilding!]["id"]!);
      emit(state.copyWith(floors: floors, status: ViewMapsStatus.notBusy));
    } catch (e) {
      print(e);
    }
  }

  void _onFloorIndexChanged(
      FloorIndexChanged event, Emitter<ViewMapsState> emit) {
    print(event.index);
    emit(state.copyWith(currFloor: event.index));
  }
}
