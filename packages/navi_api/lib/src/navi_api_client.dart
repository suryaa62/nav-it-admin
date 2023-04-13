import 'models/models.dart';
import 'package:dio/dio.dart';

class NaviAPIClient {
  late Dio _dio;

  NaviAPIClient({required String baseUrl}) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<List<Building>> getAllBuildings() async {
    try {
      Response response = await _dio.get("/buildings/");

      if (response.statusCode == 200) {
        List<Building> buildings =
            (response.data).map<Building>((i) => Building.fromJson(i)).toList();
        return buildings;
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<Building> getBuilding({required String id}) async {
    try {
      Response response = await _dio.get("/buildings/id", data: {"id": id});

      if (response.statusCode == 200) {
        Building buildings = Building.fromJson(response.data);
        return buildings;
      } else {
        throw Exception("Error: ${response.data}");
      }
    } catch (e) {
      print("Error In getBuilding: $e");
      rethrow;
    }
  }

  Future<String?> createBuilding(
      {required String name, required String imageId}) async {
    Building building = Building(imageId: imageId, name: name);
    try {
      Response response = await _dio.post("/buildings/",
          data: building.toJson()..remove("_id"));

      if (response.statusCode == 200) {
        return response.data["insertedId"];
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> createFloor(
      {required String buildingId,
      required int level,
      required String imageId}) async {
    Floor floor = Floor(
        buildingId: buildingId,
        level: level,
        floorId: "dummyId",
        imageId: imageId);
    try {
      Response response =
          await _dio.post("/floors/", data: floor.toJson()..remove("_id"));

      if (response.statusCode == 200) {
        return response.data["insertedId"];
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> createNode(
      {required String label,
      required double x,
      required String floorId,
      required double y,
      required String type,
      required String desc,
      String? ssid}) async {
    Node node = Node(
        x: x,
        y: y,
        id: "",
        desc: desc,
        floorId: floorId,
        label: label,
        type: type,
        ssid: ssid);
    try {
      Response response =
          await _dio.post("/nodes/", data: node.toJson()..remove("_id"));

      if (response.statusCode == 200) {
        return response.data["insertedId"];
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Node>> getAllNodes({required String floorId}) async {
    try {
      Response response =
          await _dio.get("/nodes/floor", data: {"floorId": floorId});

      if (response.statusCode == 200) {
        List<Node> nodes =
            (response.data).map<Node>((i) => Node.fromJson(i)).toList();
        return nodes;
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Link>> getAllLinks({required String floorId}) async {
    try {
      Response response =
          await _dio.get("/links/floor", data: {"floorId": floorId});

      if (response.statusCode == 200) {
        List<Link> links =
            (response.data).map<Link>((i) => Link.fromJson(i)).toList();
        return links;
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> createLink(
      {required String floorId,
      required String linkId1,
      required String linkId2}) async {
    Link link =
        Link(id: "", floorId: floorId, linkId1: linkId1, linkId2: linkId2);
    try {
      Response response =
          await _dio.post("/links/", data: link.toJson()..remove("_id"));
      print("s2");

      if (response.statusCode == 200) {
        return response.data["insertedId"];
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Floor>> getAllFloors(String buildingId) async {
    try {
      Response response =
          await _dio.get("/floors/building", data: {"buildingId": buildingId});

      if (response.statusCode == 200) {
        List<Floor> floors =
            (response.data).map<Floor>((i) => Floor.fromJson(i)).toList();
        return floors;
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }
}

// void main(List<String> args) {
//   NaviAPIClient client = NaviAPIClient(baseUrl: "http://localhost:5050");
//   client
//       .createBuilding(building: Building(imageId: "", name: "SMV"))
//       .then((value) => print(value))
//       .onError((error, stackTrace) => print(error));
// }
