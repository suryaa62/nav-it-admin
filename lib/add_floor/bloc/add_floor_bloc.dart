import 'package:bloc/bloc.dart';
import 'package:cross_file/cross_file.dart';
import 'package:equatable/equatable.dart';
import 'package:navi_repository/navi_repository.dart';

part 'add_floor_event.dart';
part 'add_floor_state.dart';

class AddFloorBloc extends Bloc<AddFloorEvent, AddFloorState> {
  AddFloorBloc({required this.naviRepository})
      : super(AddFloorState(
            buildings: [], currValue: "", status: AddFloorStatus.busy)) {
    on<FloorLevelChanged>((event, emit) => _onFloorLevelChanged(event, emit));
    on<FloorImageChanged>((event, emit) => _onFloorImageChanged(event, emit));
    on<BuildingIndexChanged>(
        (event, emit) => _onBuildingIndexChanged(event, emit));
    on<GetBuildingList>((event, emit) => _onGetBuildingList(event, emit));
    on<FloorSubmitted>((event, emit) => _onFloorSubmitted(event, emit));
  }

  NaviRepository naviRepository;

  void _onFloorLevelChanged(
      FloorLevelChanged event, Emitter<AddFloorState> emit) {
    emit(state.copyWith(level: event.level));
  }

  void _onFloorImageChanged(
      FloorImageChanged event, Emitter<AddFloorState> emit) {
    emit(state.copyWith(image: event.image));
  }

  void _onBuildingIndexChanged(
      BuildingIndexChanged event, Emitter<AddFloorState> emit) {
    print(event.index);
    emit(state.copyWith(currIndex: event.index));
  }

  void _onGetBuildingList(
      GetBuildingList event, Emitter<AddFloorState> emit) async {
    List<Map<String, String>> buildings;

    try {
      emit(state.copyWith(status: AddFloorStatus.busy));
      buildings = await naviRepository.getAllBuildingsName();
      emit(
          state.copyWith(buildings: buildings, status: AddFloorStatus.notBusy));
    } catch (e) {
      print(e);
    }
  }

  void _onFloorSubmitted(
      FloorSubmitted event, Emitter<AddFloorState> emit) async {
    try {
      emit(state.copyWith(status: AddFloorStatus.busy));
      if (state.level == null && state.image == null) {
        throw Exception("Please fill all the fields");
      }

      await naviRepository.addFloor(
          floor: Floor(
              buildingId: state.currValue,
              level: state.level!,
              imageFile: state.image));
      emit(state.copyWith(status: AddFloorStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AddFloorStatus.error));
      print(e);
    }
  }
}
