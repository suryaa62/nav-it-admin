import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:navi_repository/navi_repository.dart';

class LinkDrawer extends StatelessWidget {
  const LinkDrawer(
      {super.key,
      required this.child,
      required this.links,
      required this.nodes});

  final Widget child;
  final List<Link> links;
  final List<Node> nodes;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: child,
      foregroundPainter: PathPainter(links: links, nodes: nodes),
      size: const Size(1200, 1500),
    );
  }
}

class PathPainter extends CustomPainter {
  PathPainter({required this.links, required this.nodes}) {
    map = {};
    for (Node node in nodes) {
      map.addAll({node.id!: node});
    }
  }

  final List<Link> links;
  final List<Node> nodes;
  late Map<String, Node> map;

  @override
  void paint(Canvas canvas, Size size) {
    print(links.length);
    for (int i = 0; i < links.length; i++) {
      print("map");
      canvas.drawLine(
          Offset(map[links[i].link1Id]!.x, map[links[i].link1Id]!.y),
          Offset(map[links[i].link2Id]!.x, map[links[i].link2Id]!.y),
          Paint()
          ..color = Colors.blue
          ..strokeWidth = 4);
    }
  }

  @override
  bool shouldRepaint(covariant PathPainter oldDelegate) {
    return oldDelegate.links != links;
  }
}
