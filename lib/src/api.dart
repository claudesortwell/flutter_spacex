import 'package:dio/dio.dart';

import 'class/Launch.dart';
import 'class/rocket.dart';

class DioClient {
  final Dio dio = Dio();

  final baseUrl = 'https://api.spacexdata.com';

  Future<List<Launch>> getAllLaunches() async {
    // Perform GET request to the endpoint "/launche/"
    Response launchesData = await dio.get('$baseUrl/v5/launches/');

    // Parsing the raw JSON data to the Launches class
    return (launchesData.data as List)
        .map((x) => Launch.fromAPIJson(x))
        .toList();
  }

  Future<Rocket> getARocket(String id) async {
    // Perform GET request to the endpoint "/launche/"
    Response rocketData = await dio.get('$baseUrl/v4/rockets/$id');

    // Parsing the raw JSON data to the Launches class
    return Rocket.fromJson(rocketData.data);
  }
}
