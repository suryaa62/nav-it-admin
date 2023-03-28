part of 'add_floor_bloc.dart';

enum AddFloorStatus {
  busy,
  error,
  success,
  notBusy,
}

class AddFloorState extends Equatable {
  const AddFloorState(
      {required this.buildings,
      required this.currValue,
      this.level,
      required this.status,
      this.image});

  final List<Map<String, String>> buildings;
  final String currValue;
  final AddFloorStatus status;
  final int? level;
  final XFile? image;

  AddFloorState copyWith({
    List<Map<String, String>>? buildings,
    String? currIndex,
    AddFloorStatus? status,
    int? level,
    XFile? image,
  }) {
    return AddFloorState(
        buildings: buildings ?? this.buildings,
        currValue: currIndex ?? this.currValue,
        status: status ?? this.status,
        level: level ?? this.level,
        image: image ?? this.image);
  }

  @override
  List<Object?> get props => [buildings, currValue, status, level, image];
}
