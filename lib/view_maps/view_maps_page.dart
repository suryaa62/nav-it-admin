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
          DropdownButton<int>(
            value: state.currBuilding,
            onChanged: (value) {
              context.read<ViewMapsBloc>().add(BuildingIndexChanged(value));
            },
            items: List.generate(
                state.buildings.length,
                (index) => DropdownMenuItem(
                      child: Text(state.buildings[index]["name"]!),
                      value: index,
                    )),
          ),
          DropdownButton<int>(
            value: state.currFloor,
            onChanged: (value) {
              context.read<ViewMapsBloc>().add(FloorIndexChanged(value));
            },
            items: List.generate(
                state.floors.length,
                (index) => DropdownMenuItem(
                      child: Text(state.floors[index].level.toString()),
                      value: index,
                    )),
          ),
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
                        context.read<MapBloc>().add(getNewMap(
                            floorId: state.floors[state.currFloor!].id!,
                            imageId: state.floors[state.currFloor!].imageId!));
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
