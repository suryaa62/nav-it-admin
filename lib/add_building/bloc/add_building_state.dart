part of 'add_building_bloc.dart';

enum AddBuildingStatus {
  loading,
  fill,
  success,
  error,
}

class AddBuildingState extends Equatable {
  const AddBuildingState({required this.status , this.name, this.image, });

  final String? name;
  final XFile? image;
  final AddBuildingStatus status;

  AddBuildingState copyWith({
    String? name,
    XFile? image,
    
    AddBuildingStatus? status,
  }) {
    return AddBuildingState(
        name: name ?? this.name, image: image ?? this.image , status: status ?? this.status);
  }

  @override
  List<Object> get props => [name ?? "", image ?? "" , status];
}
