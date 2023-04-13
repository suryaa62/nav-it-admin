import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navi/add_node/bloc/add_node_bloc.dart';
import 'package:navi_repository/navi_repository.dart';
import 'package:wifi_scan/wifi_scan.dart';

part 'add_wifi_node_event.dart';
part 'add_wifi_node_state.dart';

class AddWifiNodeBloc extends Bloc<AddWifiNodeEvent, AddWifiNodeState> {
  AddWifiNodeBloc(
      {required String floorId,
      required this.naviRepository,
      required double x,
      required double y})
      : super(AddWifiNodeState(floorId: floorId, x: x, y: y)) {
    _init();
    on<StartScan>((event, emit) => _onStartScan(event, emit));
    on<ScanComplete>((event, emit) => _onScanComplete(event, emit));
    on<AccessPointSelected>(
        (event, emit) => _onAccessPointSelected(event, emit));
  }

  late StreamSubscription<List<WiFiAccessPoint>>? subscription;
  final NaviRepository naviRepository;

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }

  void _init() async {
    final can =
        await WiFiScan.instance.canGetScannedResults(askPermissions: true);
    switch (can) {
      case CanGetScannedResults.yes:
        subscription =
            WiFiScan.instance.onScannedResultsAvailable.listen((results) {
          add(ScanComplete(accessPoints: results));
        });
        break;

      default:
        print("---- CAN NOT GET RESULT---");
    }
  }

  void _onStartScan(StartScan event, Emitter<AddWifiNodeState> emit) async {
    final can = await WiFiScan.instance.canStartScan(askPermissions: true);
    switch (can) {
      case CanStartScan.yes:
        final isScanning = await WiFiScan.instance.startScan();
        print(isScanning);

        break;
      default:
        print("---CAN NOT SCAN---");
    }
  }

  void _onScanComplete(ScanComplete event, Emitter<AddWifiNodeState> emit) {
    event.accessPoints.sort(((a, b) {
      return b.level.compareTo(a.level);
    }));
    emit(state.copyWith(accessPoints: event.accessPoints));
    print("Scan Complete");
  }

  void _onAccessPointSelected(
      AccessPointSelected event, Emitter<AddWifiNodeState> emit) async {
    try {
      emit(state.copyWith(status: AddWifiNodeStatus.busy));
      Node node = Node(
          x: state.x,
          desc: state.accessPoints[event.index].ssid,
          floorId: state.floorId,
          label: state.accessPoints[event.index].bssid,
          type: "path",
          ssid: state.accessPoints[event.index].bssid,
          y: state.y);
      await naviRepository.addNode(node: node);
      emit(state.copyWith(status: AddWifiNodeStatus.success));
    } catch (e) {
      print("Bloc Error: $e");
      emit(state.copyWith(status: AddWifiNodeStatus.error));
    }
  }
}
