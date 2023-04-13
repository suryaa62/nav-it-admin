import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navi/add_building/bloc/add_building_bloc.dart';
import 'package:navi/widgets/myAlertDialog.dart';
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
      appBar: AppBar(title: const Text("Add Building")),
      body: BlocConsumer<AddBuildingBloc, AddBuildingState>(
        listener: (context, state) {
          if (state.status == AddBuildingStatus.error) {
            _showMyDialog(context, "Error", "Oops! There was an error.");
          }

          if (state.status == AddBuildingStatus.success) {
            _showMyDialog(context, "Success", "New building has been added")
                .then((value) => Navigator.of(context).pop());
          }
          
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 16),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(label: Text("Building Name")),
                  onChanged: (value) {
                    context
                        .read<AddBuildingBloc>()
                        .add(BuildingNameChanged(value));
                  },
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 16),
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
