import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi/map_drawer/bloc/map_drawer_bloc.dart';
import 'package:navi/map_drawer/link_drawer.dart';
import 'package:navi/map_editor/bloc/map_editor_bloc.dart';

import 'package:navi_repository/navi_repository.dart';

class MapDrawer extends StatelessWidget {
  const MapDrawer(
      {super.key,
      required this.floorId,
      required this.child,
      this.canEdit = false});

  final String floorId;
  final Widget child;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MapDrawerBloc(
            floorId: floorId, naviRepository: context.read<NaviRepository>())
          ..add(GetNodes(canEdit: canEdit)),
        child: (canEdit)
            ? BlocListener<MapEditorBloc, MapEditorState>(
                listener: (context, state) {
                  if (state.status == MapEditorStatus.refresh) {
                    context
                        .read<MapDrawerBloc>()
                        .add(GetNodes(canEdit: canEdit));
                  }
                },
                child: MapDrawerChild(
                  child: child,
                  canEdit: canEdit,
                ))
            : MapDrawerChild(child: child, canEdit: canEdit));
  }
}

class MapDrawerChild extends StatelessWidget {
  const MapDrawerChild({super.key, required this.child, required this.canEdit});

  final Widget child;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapDrawerBloc, MapDrawerState>(
      builder: (context, state) {
        return Stack(
          children: [
            LinkDrawer(
              links: state.links,
              nodes: state.nodes,
              child: child,
            ),
            ...state.nodes.map((e) {
              return NodeWidget(
                node: e,
                canEdit: canEdit,
              );
            }).toList(),
          ],
        );
      },
    );
  }
}

class NodeWidget extends StatelessWidget {
  const NodeWidget({super.key, required this.node, required this.canEdit});

  final Node node;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    if (!canEdit && node.type == "path") return Container();

    return Positioned(
      top: node.y - 25,
      left: node.x - 25,
      child: SizedBox(
        width: 50,
        height: 50,
        child: Stack(
          clipBehavior: Clip.none,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              padding: EdgeInsets.all(2),
              onPressed: (canEdit)
                  ? () {
                      context
                          .read<MapEditorBloc>()
                          .add(ClickedOnANode(id: node.id!));
                    }
                  : null,
              icon: (node.type == "path")
                  ? Icon(Icons.circle)
                  : Image.asset("assets/${node.type}.png"),
            ),
            Positioned(
              // alignment: Alignment.bottomCenter,
              bottom: -15,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Color(0xAFFFFFFF),
                    border: Border.all(color: Colors.black)),
                child: Text(
                  node.label,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
