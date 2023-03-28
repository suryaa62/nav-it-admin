import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi/map/bloc/map_bloc.dart';

import 'package:navi_repository/navi_repository.dart';

class MapView extends StatelessWidget {
  const MapView({super.key, this.floorId});

  final String? floorId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapBloc>(
      create: (context) {
        print("yes");
        return MapBloc(
                naviRepository: context.read<NaviRepository>(),
              );
      },
      child: const MapViewer(),
    );
  }
}

class MapViewer extends StatelessWidget {
  const MapViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        if (state is NoMapSelectedState) {
          return Center(child: Text("Nothing to show"));
        }

        if (state is MapLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Center(child: Text((state as MapDataState).floorId));
      },
    );
  }
}
