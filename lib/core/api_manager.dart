import 'package:dio/dio.dart';

class ApiManager {
  final _connnectionTimeOut = 60000;
  final _recieveTimeOut = 60000;

  late Dio dio;

  ApiManager() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: "http://127.0.0.1:3000/",
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {"Accept": "application/json"});
    dio = Dio(baseOptions);

    print("dio:::$dio");
  }
}
