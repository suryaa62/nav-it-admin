part of 'add_node_bloc.dart';

abstract class AddNodeEvent extends Equatable {
  const AddNodeEvent();

  @override
  List<Object> get props => [];
}

class LabelTextChanged extends AddNodeEvent {
  const LabelTextChanged({required this.label});

  final String label;
}

class DescTextChanged extends AddNodeEvent {
  const DescTextChanged({required this.desc});

  final String desc;
}

class NodeTypeChanged extends AddNodeEvent {
  const NodeTypeChanged({required this.type});

  final NodeType type;
}

class SubmitNewNode extends AddNodeEvent {
  
}
