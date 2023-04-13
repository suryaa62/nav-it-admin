part of 'add_wifi_node_bloc.dart';

enum AddWifiNodeStatus {
  busy,
  notBusy,
  scanning,
  list,
  success,
  error,
}

class AddWifiNodeState extends Equatable {
  const AddWifiNodeState(
      {this.status = AddWifiNodeStatus.list,
      this.accessPoints = const [],
      required this.floorId,
      required this.x,
      required this.y});
  final double x;
  final double y;
  final AddWifiNodeStatus status;
  final List<WiFiAccessPoint> accessPoints;
  final String floorId;

  AddWifiNodeState copyWith(
      {AddWifiNodeStatus? status, List<WiFiAccessPoint>? accessPoints}) {
    return AddWifiNodeState(
        x: x,
        y: y,
        floorId: floorId,
        status: status ?? this.status,
        accessPoints: accessPoints ?? this.accessPoints);
  }

  @override
  List<Object> get props => [status, accessPoints];
}
