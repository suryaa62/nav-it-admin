import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi/add_node/add_node_page.dart';
import 'package:navi/add_wifi_node/add_wifi_node_page.dart';
import 'package:navi/map/map_view.dart';
import 'package:navi/map_editor/bloc/map_editor_bloc.dart';

import 'package:navi_repository/navi_repository.dart';

class MapEditorPage extends StatelessWidget {
  MapEditorPage({super.key, required this.floorId, required this.imageId});

  final String floorId;
  final String imageId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapEditorBloc(
        floorId: floorId,
        imageId: imageId,
        naviRepository: context.read<NaviRepository>(),
      ),
      child: const MapEditorView(),
    );
  }
}

class MapEditorView extends StatefulWidget {
  const MapEditorView({super.key});

  @override
  State<MapEditorView> createState() => _MapEditorViewState();
}

class _MapEditorViewState extends State<MapEditorView> {
  TransformationController _tc = TransformationController();

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
        appBar: AppBar(
          title: const Text("Map Editor"),
          actions: [AddNodeButton(), AddLinkButton()],
        ),
        body: BlocConsumer<MapEditorBloc, MapEditorState>(
          listener: (blocContext, state) {
            if (state.status == MapEditorStatus.bottomSheet) {
              showModalBottomSheet<void>(
                      context: context,
                      isDismissible: false,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200,
                          child: Stack(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 34, vertical: 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          child: const Text('Add Normal Node'),
                                          onPressed: () {
                                            print(
                                                "Add node button: ${state.x}");
                                            Navigator.of(context)
                                                .push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddNodePage(
                                                  floorId: (state.floorId),
                                                  x: state.x!,
                                                  y: state.y!,
                                                ),
                                              ),
                                            )
                                                .then((value) {
                                              Navigator.pop(context);
                                              blocContext
                                                  .read<MapEditorBloc>()
                                                  .add(Refresh());
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          child: const Text('Add Wifi Node'),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddWifiNodePage(
                                                  x: state.x!,
                                                  y: state.y!,
                                                  floorId: (state.floorId),
                                                ),
                                              ),
                                            )
                                                .then((value) {
                                              Navigator.pop(context);
                                              blocContext
                                                  .read<MapEditorBloc>()
                                                  .add(Refresh());
                                            });
                                          },
                                        ),
                                      ),
                                      // ElevatedButton(
                                      //   child: const Text('Cancel'),
                                      //   onPressed: () {
                                      //     Navigator.pop(context);
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                  .then((value) =>
                      context.read<MapEditorBloc>().add(CloseBottomSheet()));
            }
          },
          // buildWhen: (previous, current) =>
          //     (current.status == MapEditorStatus.bottomSheet) ? false : true,
          builder: (context, state) {
            print("builder : ${state.x}");
            return GestureDetector(
              onTapDown: (details) {
                if (state.canAdd) {
                  Offset offset = _tc.toScene(details.localPosition);
                  context
                      .read<MapEditorBloc>()
                      .add(TappedOnXY(x: offset.dx, y: offset.dy));
                  context.read<MapEditorBloc>().add(ShowBottamSheet());
                  print(offset.dx);
                }
                print("DETAILS:::::>>>>${details.globalPosition}");
                print("DETAILS:::::>>>>${_tc.toScene(details.localPosition)}");
              },
              child: Container(
                  color: Colors.amber,
                  child: MapView(
                    floorId: state.floorId,
                    imageId: state.imageId,
                    tc: _tc,
                    canEdit: true,
                    refresh: state.refresh,
                  )),
            );
          },
        ));
  }
}

class AddNodeButton extends StatelessWidget {
  const AddNodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapEditorBloc, MapEditorState>(
      builder: (context, state) => IconButton(
        icon: Icon((state.canAdd) ? Icons.mode_standby : Icons.add),
        onPressed: () {
          context.read<MapEditorBloc>().add(ToggleCanAddTo(!state.canAdd));
        },
      ),
    );
  }
}

class AddLinkButton extends StatelessWidget {
  const AddLinkButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapEditorBloc, MapEditorState>(
      builder: (context, state) => IconButton(
        icon: Icon(
          (state.canAddLink) ? Icons.mode_standby : Icons.link,
          color: (state.node1Id != "") ? Colors.green : Colors.white,
        ),
        onPressed: () {
          context
              .read<MapEditorBloc>()
              .add(ToggleCanAddLinkTo(!state.canAddLink));
        },
      ),
    );
  }
}
