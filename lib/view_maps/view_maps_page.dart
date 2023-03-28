import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi/map/bloc/map_bloc.dart';
import 'package:navi/map/map_view.dart';
import 'package:navi/view_maps/bloc/view_maps_bloc.dart';

import 'package:navi_repository/navi_repository.dart';

class ViewMapsPage extends StatelessWidget {
  const ViewMapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewMapsBloc(
        naviRepository: context.read<NaviRepository>(),
      )..add(GetBuildingList()),
      child: const AddFloorView(),
    );
  }
}

class AddFloorView extends StatelessWidget {
  const AddFloorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewMapsBloc, ViewMapsState>(builder: (context, state) {
      return Column(
        children: [
          DropdownButton(
              value: state.currBuilding,
              onChanged: (value) {
                context.read<ViewMapsBloc>().add(BuildingIndexChanged(value));
              },
              items: state.buildings
                  .map((e) => DropdownMenuItem(
                        child: Text(e["name"]!),
                        value: e["id"]!,
                      ))
                  .toList()),
          DropdownButton(
              value: state.currFloor,
              onChanged: (value) {
                context.read<ViewMapsBloc>().add(FloorIndexChanged(value));
              },
              items: state.floors
                  .map((e) => DropdownMenuItem(
                        child: Text(e.level.toString()),
                        value: e.id,
                      ))
                  .toList()),
          Expanded(
            child: BlocProvider(
              create: (context) => MapBloc(
                  naviRepository:
                      RepositoryProvider.of<NaviRepository>(context)),
              child: BlocBuilder<MapBloc, MapState>(
                builder: (map_context, map_state) {
                  return BlocListener<ViewMapsBloc, ViewMapsState>(
                    listener: (context, state) {
                      if (state.currFloor != null) {
                        context
                            .read<MapBloc>()
                            .add(getNewMap(state.currFloor! , state.currFloor! ));
                      }
                    },
                    child: MapViewer(),
                  );
                },
              ),
            ),
          )
        ],
      );
    });
  }
}
