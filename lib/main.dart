import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi/add_building/add_building_page.dart';
import 'package:navi/add_floor/add_floor_page.dart';
import 'package:navi/view_maps/view_maps_page.dart';
import 'package:navi_repository/navi_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NaviRepository(),
      child: MaterialApp(
        title: 'Navi admin',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Navi Admin'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Uint8List> _myFuture;

  @override
  void initState() {
    // TODO: implement initState
    this._myFuture =
        NaviRepository().getBuilding(id: "6408764df45bbe4034977d30").then(
      (value) async {
        return await value.imageFile.readAsBytes();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ViewMapsPage(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddBuildingPage(),
                ),
              );
            },
            child: const Icon(Icons.store),
          ),
          FloatingActionButton(
            heroTag: "addFloorTag",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddFloorPage(),
                ),
              );
            },
            child: const Icon(Icons.map),
          ),
        ],
      ),
    );
  }
}
