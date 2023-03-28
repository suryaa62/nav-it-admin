import 'dart:convert';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:navi_api/navi_api.dart';
import 'package:image_api/image_api.dart';
import 'package:navi_repository/navi_repository.dart';
import 'package:navi_repository/src/models/building.dart';

class NaviRepository {
  late NaviAPIClient naviAPIClient;
  late ImageApiClient imageApiClient;

  NaviRepository() {
    String baseUrl = "http://10.0.2.2:5050";
    naviAPIClient = NaviAPIClient(baseUrl: baseUrl);
    imageApiClient = ImageApiClient(baseUrl: "$baseUrl/images");
  }

  Future<List<Building>> getAllBuilding() async {
    try {
      final buildings = await naviAPIClient.getAllBuildings();
      List<Building> output = [];
      for (var building in buildings) {
        ImageModel image = await imageApiClient.getWithId(id: building.imageId);

        XFile imageFile = XFile.fromData(base64.decode(image.image),
            name: image.name, mimeType: image.mime_type);
        output.add(Building(
            imageFile: imageFile, name: building.name, id: building.id));
      }

      return output;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, String>>> getAllBuildingsName() async {
    try {
      final buildings = await naviAPIClient.getAllBuildings();
      List<Map<String, String>> output = [];
      for (var building in buildings) {
        output.add({"name": building.name, "id": building.id ?? ""});
      }

      return output;
    } catch (e) {
      rethrow;
    }
  }

  Future<Building> getBuilding({required String id}) async {
    try {
      final building = await naviAPIClient.getBuilding(id: id);
      ImageModel image = await imageApiClient.getWithId(id: building.imageId);
      XFile imageFile = XFile.fromData(base64.decode(image.image),
          name: image.name, mimeType: image.mime_type);
      return Building(
          imageFile: imageFile, name: building.name, id: building.id);
    } catch (e) {
      print("Error In getBuilding: $e");
      rethrow;
    }
  }

  Future<XFile> getImageAsFile(String id) async {
    try {
      ImageModel image = await imageApiClient.getWithId(id: id);
      XFile imageFile = XFile.fromData(base64.decode(image.image),
          name: image.name, mimeType: image.mime_type);
      return imageFile;
    } catch (e) {
      rethrow;
    }
  }

  Future<Uint8List> getImageAsBuffer(String id) async {
    try {
      ImageModel image = await imageApiClient.getWithId(id: id);
      Uint8List imageFile = base64.decode(image.image);  
      return imageFile;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addBuilding({required Building building}) async {
    try {
      String imageAsString =
          base64.encode(await building.imageFile.readAsBytes());
      String imageId = await imageApiClient.upload(
          image: ImageModel(
              image: imageAsString,
              mime_type: building.imageFile.mimeType ?? "",
              name: building.imageFile.name));
      await naviAPIClient.createBuilding(name: building.name, imageId: imageId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addFloor({required Floor floor}) async {
    try {
      String imageAsString =
          base64.encode(await floor.imageFile!.readAsBytes());
      String imageId = await imageApiClient.upload(
          image: ImageModel(
              image: imageAsString,
              mime_type: floor.imageFile!.mimeType ?? "",
              name: floor.imageFile!.name));
      await naviAPIClient.createFloor(
          buildingId: floor.buildingId, level: floor.level, imageId: imageId);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Floor>> getAllFloorsOfBuildingId(String id) async {
    try {
      final floors = await naviAPIClient.getAllFloors(id);
      List<Floor> floorList = floors
          .map((e) => Floor(
              buildingId: e.buildingId,
              level: e.level,
              imageId: e.imageId,
              id: e.floorId))
          .toList();
      return floorList;
    } catch (e) {
      rethrow;
    }
  }
}
