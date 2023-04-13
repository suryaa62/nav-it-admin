import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi/add_wifi_node/bloc/add_wifi_node_bloc.dart';
import 'package:navi/widgets/myAlertDialog.dart';

import 'package:navi_repository/navi_repository.dart';

class AddWifiNodePage extends StatelessWidget {
  const AddWifiNodePage(
      {super.key, required this.floorId, required this.x, required this.y});

  final String floorId;
  final double x;
  final double y;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddWifiNodeBloc(
        x: x,
        y: y,
        floorId: floorId,
        naviRepository: context.read<NaviRepository>(),
      )..add(StartScan()),
      child: const AddWifiNodeView(),
    );
  }
}

class AddWifiNodeView extends StatelessWidget {
  const AddWifiNodeView({super.key});

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
      appBar: AppBar(title: const Text("Add Wifi")),
      body: BlocConsumer<AddWifiNodeBloc, AddWifiNodeState>(
        listener: (context, state) {
          if (state.status == AddWifiNodeStatus.error) {
              _showMyDialog(context, "Error", "Oops! There was an error.");
          }

          if (state.status == AddWifiNodeStatus.success) {
            _showMyDialog(context, "Success", "New building has been added")
                .then((value) => Navigator.of(context).pop());
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () => Future(
              () => context.read<AddWifiNodeBloc>().add(StartScan()),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
              child: Column(
                children: [
                  Text(
                    "Choose the nearest Wifi Router",
                    style: TextStyle(fontSize: 21),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: state.accessPoints.length,
                      itemBuilder: (context, index) => ListTile(
                          onTap: () => context
                              .read<AddWifiNodeBloc>()
                              .add(AccessPointSelected(index: index)),
                          title: Text(state.accessPoints[index].ssid),
                          subtitle: Text(state.accessPoints[index].bssid),
                          trailing: Text(
                            state.accessPoints[index].level.toString(),
                            style: TextStyle(fontSize: 19),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
