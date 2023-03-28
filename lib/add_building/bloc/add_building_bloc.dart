import 'package:bloc/bloc.dart';
import 'package:cross_file/cross_file.dart';
import 'package:equatable/equatable.dart';
import 'package:navi_repository/navi_repository.dart';

part 'add_building_event.dart';
part 'add_building_state.dart';

class AddBuildingBloc extends Bloc<AddBuildingEvent, AddBuildingState> {
  AddBuildingBloc({required this.naviRepository})
      : super(const AddBuildingState(status: AddBuildingStatus.fill)) {
    on<BuildingNameChanged>(_onBuildingNameChanged);
    on<BuildingImageChanged>(_onBuildingImageChanged);
    on<BuildingSubmitted>(_onBuildingSubmitted);
  }

  NaviRepository naviRepository;

  void _onBuildingNameChanged(
      BuildingNameChanged event, Emitter<AddBuildingState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onBuildingImageChanged(
      BuildingImageChanged event, Emitter<AddBuildingState> emit) {
    emit(state.copyWith(image: event.image));
  }

  Future<void> _onBuildingSubmitted(
      BuildingSubmitted event, Emitter<AddBuildingState> emit) async {
    try {
      emit(state.copyWith(status: AddBuildingStatus.loading));
      await naviRepository.addBuilding(
          building: Building(imageFile: state.image!, name: state.name!));
      emit(state.copyWith(status: AddBuildingStatus.success));
    } catch (e) {
      print(":::::::::::::::::::>");
      print(e);
      emit(state.copyWith(status: AddBuildingStatus.error));
    }
  }
}
