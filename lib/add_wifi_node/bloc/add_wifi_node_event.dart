part of 'add_wifi_node_bloc.dart';

abstract class AddWifiNodeEvent extends Equatable {
  const AddWifiNodeEvent();

  @override
  List<Object> get props => [];
}

class StartScan extends AddWifiNodeEvent {}

class RefreshScan extends AddWifiNodeEvent {}

class ScanComplete extends AddWifiNodeEvent {
  ScanComplete({required this.accessPoints});

  List<WiFiAccessPoint> accessPoints;

  @override
  List<Object> get props => [accessPoints];
}

class AccessPointSelected extends AddWifiNodeEvent {
  AccessPointSelected({required this.index});

  final int index;

  @override
  List<Object> get props => [index];
}
