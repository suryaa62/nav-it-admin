
import 'package:equatable/equatable.dart';

class Link extends Equatable {
  const Link(
      {required this.id,
      required this.floorId,
      required this.link1Id,
      required this.link2Id});

  

  final String id;
  final String floorId;
  final String link1Id;
  final String link2Id;

  @override
  List<Object?> get props => [id, floorId, link1Id ,link2Id];
}