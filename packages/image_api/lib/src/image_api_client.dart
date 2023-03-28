// import 'dart:io';

// import 'package:mime_type/mime_type.dart';

import 'models/model.dart';
import 'package:dio/dio.dart';

class ImageApiClient {
  late Dio _dio;

  ImageApiClient({required String baseUrl}) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
  }

  Future<ImageModel> getWithId({required String id}) async {
    print("ooooooooooo>>>>$id");
    try {
      Response response = await _dio.get("/id", data: {"id": id});

      if (response.statusCode == 200) {
        ImageModel im = ImageModel.fromJson(response.data);
        return im;
      } else {
        throw Exception("Error : ${response.data}");
      }
    } catch (e) {
      print("Error In getWithId: $e");
      rethrow;
    }
  }

  Future<String> upload({required ImageModel image}) async {
    try {
      //   String fileName = file.path.split('/').last;
      //   FormData formData = FormData.fromMap({
      //     "mime_type" : mime(fileName),
      //     "name" : fileName,
      //     "file":
      //         await MultipartFile.fromFile(file.path, filename:fileName),
      // });
      Response response =
          await _dio.post("/", data: image.toJson()..remove("id"));
      if (response.statusCode == 200) {
        return response.data['insertedId'];
      } else {
        throw Exception(
            "Error in upload method of ImageAPIClient : ${response.data}");
      }
    } catch (e) {
      rethrow;
    }
  }
}

// void main(List<String> args) {
//   ImageApiClient client = ImageApiClient(baseUrl: "http://localhost:5050/images");
//   client
//       .getWithId(id: "64031be9485eb9029896d4d7")
//       .then((value) => print(value))
//       .onError((error, stackTrace) => print(error));
// }