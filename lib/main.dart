
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi/add_building/add_building_page.dart';
import 'package:navi/add_floor/add_floor_page.dart';
import 'package:navi/map_editor/map_editor_page.dart';
import 'package:navi/view_maps/bloc/view_maps_bloc.dart';
import 'package:navi/view_maps/view_maps_page.dart';
import 'package:navi_repository/navi_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NaviRepository(),
      child: MaterialApp(
        title: 'Navi admin',
        theme: ThemeData(
          progressIndicatorTheme:
              ProgressIndicatorThemeData(color: Colors.black),
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Color(0xFF252525)),
          primaryColor: Color(0xFF252525),
          appBarTheme: AppBarTheme(
            color: Color(0xFF252525),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 23,
                fontFamily: "VisbyRoundCF"),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.all(12)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  textStyle: MaterialStateProperty.all(TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: "VisbyRoundCF",
                      color: Colors.white,
                      fontSize: 21)),
                  backgroundColor: MaterialStateColor.resolveWith((states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Color(0xFFA7A7A7);
                    }

                    return Color(0xFF252525);
                  }))),
          textTheme: TextTheme(
              subtitle1: TextStyle(fontFamily: "VisbyRoundCF", fontSize: 23)),
          fontFamily: "VisbyRoundCF",
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.black,
          ),
          inputDecorationTheme: InputDecorationTheme(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              floatingLabelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.06, color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.06, color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(6)))),
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
    return BlocProvider(
      create: (context) => ViewMapsBloc(
        naviRepository: context.read<NaviRepository>(),
      )..add(
          GetBuildingList(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ViewMapsPage(),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
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
            SizedBox(
              height: 24,
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
            SizedBox(
              height: 24,
            ),
            Builder(builder: (context) {
              return BlocBuilder<ViewMapsBloc, ViewMapsState>(
                builder: (context, state) {
                  return FloatingActionButton(
                    heroTag: "mapEditorTag",
                    onPressed: (state.currFloor != null)
                        ? () {
                            (Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MapEditorPage(
                                    floorId:
                                        (state.floors[state.currFloor!].id!),
                                    imageId: state
                                        .floors[state.currFloor!].imageId!),
                              ),
                            ));
                          }
                        : null,
                    child: const Icon(Icons.edit),
                  );
                },
              );
            }),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
