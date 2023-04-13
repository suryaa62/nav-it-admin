import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi/map/bloc/map_bloc.dart';
import 'package:navi/map_drawer/map_drawer.dart';

import 'package:navi_repository/navi_repository.dart';

class MapView extends StatelessWidget {
  const MapView(
      {super.key,
      required this.floorId,
      required this.imageId,
      this.tc,
      this.canEdit = false,
      required this.refresh});

  final String floorId;
  final String imageId;
  final TransformationController? tc;
  final bool canEdit;
  final int refresh;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapBloc>(
      create: (context) {
        return MapBloc(
          naviRepository: context.read<NaviRepository>(),
        )..add(getNewMap(imageId: imageId, floorId: floorId));
      },
      child: MapViewer(
        tc: tc,
        canEdit: canEdit,
      ),
    );
  }
}

class MapViewer extends StatelessWidget {
  const MapViewer({super.key, this.tc, this.canEdit = false});
  final TransformationController? tc;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        if (state is NoMapSelectedState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  "Nothing to Show",
                  style: TextStyle(fontSize: 21),
                ),
              ),
              Image.asset("assets/nothing.png"),
            ],
          );
        }

        if (state is MapLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Center(
            child: IntercativeMap(
          state: state as MapDataState,
          tc: tc,
          canEdit: canEdit,
        ));
      },
    );
  }
}

class IntercativeMap extends StatelessWidget {
  const IntercativeMap(
      {super.key, required this.state, this.tc, required this.canEdit});

  final MapDataState state;
  final TransformationController? tc;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: tc,
      // constrained: (tc == null) ? true : false,
      constrained: false,
      maxScale: 100,
      // boundaryMargin: EdgeInsets.all(60),
      child: SizedBox(
          width: 1200,
          height: 1500,
          child: MapDrawer(
            floorId: state.floorId,
            canEdit: canEdit,
            child: Image.memory(
              state.imageBuffer,
              width: 1200,
              height: 1500,
            ),
          )),
    );
  }
}
