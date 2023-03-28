import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navi/add_building/bloc/add_building_bloc.dart';
import 'package:navi_repository/navi_repository.dart';

class AddBuildingPage extends StatelessWidget {
  const AddBuildingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddBuildingBloc(
        naviRepository: context.read<NaviRepository>(),
      ),
      child: const AddBuildingView(),
    );
  }
}

class AddBuildingView extends StatelessWidget {
  const AddBuildingView({super.key});

  void _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    //TODO: add try catch here
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // ignore: use_build_context_synchronously
      context.read<AddBuildingBloc>().add(BuildingImageChanged(image));
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
      appBar: AppBar(title: const Text("Add Building")),
      body: BlocConsumer<AddBuildingBloc, AddBuildingState>(
        listener: (context, state) {
          if (state.status == AddBuildingStatus.error) {
            _showMyDialog(context, "Error Occured");
          }

          if (state.status == AddBuildingStatus.success) {
            _showMyDialog(context, "Added Succesfully")
                .then((value) => Navigator.of(context).pop());
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              TextField(
                onChanged: (value) {
                  context
                      .read<AddBuildingBloc>()
                      .add(BuildingNameChanged(value));
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
                onPressed: (state.name == null || state.image == null)
                    ? null
                    : () {
                        context
                            .read<AddBuildingBloc>()
                            .add(const BuildingSubmitted());
                      },
                child: (state.status == AddBuildingStatus.loading)
                    ? const CircularProgressIndicator()
                    : const Text("Add Building"),
              ),
            ],
          );
        },
      ),
    );
  }
}
