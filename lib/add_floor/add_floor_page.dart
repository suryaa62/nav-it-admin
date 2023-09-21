import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navi/add_floor/bloc/add_floor_bloc.dart';
import 'package:navi/widgets/myAlertDialog.dart';

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Add Floor")),
      body: BlocConsumer<AddFloorBloc, AddFloorState>(
        listener: (context, state) {
          if (state.status == AddFloorStatus.error) {
            _showMyDialog(context, "Error", "Oops! There was an error.");
          }

          if (state.status == AddFloorStatus.success) {
            _showMyDialog(context, "Success", "New building has been added")
                .then((value) => Navigator.of(context).pop());
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            child: Column(
              children: [
                DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(label: Text("Building Name")),
                    value: (state.currValue == "") ? null : state.currValue,
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  child: TextField(
                    decoration: InputDecoration(label: Text("Floor")),
                    onChanged: (value) {
                      context
                          .read<AddFloorBloc>()
                          .add(FloorLevelChanged(int.parse(value)));
                    },
                  ),
                ),
                if (state.image != null)
                  Expanded(
                      child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                    child: Image.file(
                      File(state.image!.path),
                      fit: BoxFit.cover,
                    ),
                  ))
                else
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: GestureDetector(
                        onTap: () {
                          _pickImage(context);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Click here to choose image",
                                style: TextStyle(fontSize: 23),
                              ),
                              Image.asset("assets/imagechoose.png"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
