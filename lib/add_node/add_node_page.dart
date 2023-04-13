import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi/add_node/bloc/add_node_bloc.dart';
import 'package:navi/widgets/myAlertDialog.dart';

import 'package:navi_repository/navi_repository.dart';

class AddNodePage extends StatelessWidget {
  const AddNodePage(
      {super.key, required this.x, required this.y, required this.floorId});

  final double x;
  final double y;
  final String floorId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNodeBloc(
        x: x,
        y: y,
        floorId: floorId,
        naviRepository: context.read<NaviRepository>(),
      ),
      child: const AddNodeView(),
    );
  }
}

class AddNodeView extends StatelessWidget {
  const AddNodeView({super.key});
 Future<void> _showMyDialog(
      BuildContext context, final String message, final String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return MyAlertDialog(
          content: content,
          message: message,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Node")),
      body: BlocConsumer<AddNodeBloc, AddNodeState>(
        listener: (context, state) {
          print(state.status);
          if (state.status == AddNodeStatus.error) {
             _showMyDialog(context, "Error", "Oops! There was an error.");
          }

          if (state.status == AddNodeStatus.success) {
           _showMyDialog(context, "Success", "New building has been added")
                .then((value) => Navigator.of(context).pop());
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            child: Column(
              children: [
                DropdownButtonFormField<NodeType>(
                    decoration: InputDecoration(label: Text("Type")),
                    isExpanded: true,
                    value: state.nodeType,
                    onChanged: (value) {
                      context.read<AddNodeBloc>().add(
                          NodeTypeChanged(type: value ?? NodeType.classroom));
                    },
                    items: NodeType.values
                        .map((e) => DropdownMenuItem<NodeType>(
                              child: Text(e.name),
                              value: e,
                            ))
                        .toList()),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextField(
                    decoration: InputDecoration(label: Text("Label")),
                    onChanged: (value) {
                      context
                          .read<AddNodeBloc>()
                          .add(LabelTextChanged(label: value));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextField(
                    decoration: InputDecoration(label: Text("Description")),
                    maxLines: null,
                    onChanged: (value) {
                      context
                          .read<AddNodeBloc>()
                          .add(DescTextChanged(desc: value));
                    },
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (state.label == "" ||
                            state.desc == "" ||
                            state.status == AddNodeStatus.busy)
                        ? null
                        : () {
                            context.read<AddNodeBloc>().add(SubmitNewNode());
                          },
                    child: (state.status == AddNodeStatus.busy)
                        ? const CircularProgressIndicator()
                        : const Text("Add Node"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
