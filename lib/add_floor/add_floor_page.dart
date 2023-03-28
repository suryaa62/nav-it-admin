import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navi/add_floor/bloc/add_floor_bloc.dart';

import 'package:navi_repository/navi_repository.dart';

class AddFloorPage extends StatelessWidget {
  const AddFloorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFloorBloc(
        naviRepository: context.read<NaviRepository>(),
      )..add(GetBuildingList()),
      child: const AddFloorView(),
    );
  }
}

class AddFloorView extends StatelessWidget {
  const AddFloorView({super.key});

  void _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    //TODO: add try catch here
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // ignore: use_build_context_synchronously
      context.read<AddFloorBloc>().add(FloorImageChanged(image));
    }
  }

  Future<void> _showMyDialog(BuildContext context, final String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Floor")),
      body: BlocConsumer<AddFloorBloc, AddFloorState>(
        listener: (context, state) {
          if (state.status == AddFloorStatus.error) {
            _showMyDialog(context, "Error Occured");
          }

          if (state.status == AddFloorStatus.success) {
            _showMyDialog(context, "Added Succesfully")
                .then((value) => Navigator.of(context).pop());
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              DropdownButton(
                value: (state.currValue == "")? null : state.currValue,
                  onChanged: (value) {
                    context
                        .read<AddFloorBloc>()
                        .add(BuildingIndexChanged(value ?? ""));
                  },
                  items: state.buildings
                      .map((e) => DropdownMenuItem(
                            child: Text(e["name"]!),
                            value: e["id"]!,
                          ))
                      .toList()),
              TextField(
                onChanged: (value) {
                  context
                      .read<AddFloorBloc>()
                      .add(FloorLevelChanged(int.parse(value)));
                },
              ),
              if (state.image == null)
                const Text("Please Select Image")
              else
                Image.file(File(state.image!.path), height: 300),
              ElevatedButton(
                child: const Text("Choose Image"),
                onPressed: () {
                  _pickImage(context);
                },
              ),
              ElevatedButton(
                onPressed: (state.level == null ||
                        state.image == null ||
                        state.status == AddFloorStatus.busy)
                    ? null
                    : () {
                        context
                            .read<AddFloorBloc>()
                            .add(const FloorSubmitted());
                      },
                child: (state.status == AddFloorStatus.busy)
                    ? const CircularProgressIndicator()
                    : const Text("Add Floor"),
              ),
            ],
          );
        },
      ),
    );
  }
}
