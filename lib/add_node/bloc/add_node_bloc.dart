import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navi_repository/navi_repository.dart';

part 'add_node_event.dart';
part 'add_node_state.dart';

class AddNodeBloc extends Bloc<AddNodeEvent, AddNodeState> {
  AddNodeBloc(
      {required double x,
      required double y,
      required String floorId,
      required this.naviRepository})
      : super(AddNodeState(
            x: x, y: y, floorId: floorId, status: AddNodeStatus.free)) {
    on<LabelTextChanged>((event, emit) => _onLabelTextChanged(event, emit));
    on<DescTextChanged>((event, emit) => _onDescTextChanged(event, emit));
    on<NodeTypeChanged>((event, emit) => _onNodeTypeChanged(event, emit));
    on<SubmitNewNode>((event, emit) => _onSubmitNewNode(event, emit));
  }

  final NaviRepository naviRepository;

  void _onLabelTextChanged(LabelTextChanged event, Emitter<AddNodeState> emit) {
    emit(state.copyWith(label: event.label));
  }

  void _onDescTextChanged(DescTextChanged event, Emitter<AddNodeState> emit) {
    emit(state.copyWith(desc: event.desc));
  }

  void _onNodeTypeChanged(NodeTypeChanged event, Emitter<AddNodeState> emit) {
    emit(state.copyWith(nodeType: event.type));
  }

  void _onSubmitNewNode(SubmitNewNode event, Emitter<AddNodeState> emit) async {
    try {
      emit(state.copyWith(status: AddNodeStatus.busy));
      Node node = Node(
          x: state.x,
          desc: state.desc,
          floorId: state.floorId,
          label: state.label,
          type: state.nodeType.name,
          y: state.y);
      await naviRepository.addNode(node: node);
      emit(state.copyWith(status: AddNodeStatus.success));
    } catch (e) {
      print("Bloc Error: $e");
      emit(state.copyWith(status: AddNodeStatus.error));
    }
  }
}
