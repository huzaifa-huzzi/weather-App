import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_apis/Model/Weather_Api_Model.dart';

class WeatherRepository {
  Future<WeatherApiModel> fetch() async {
    String url = 'https://api.openweathermap.org/data/3.0/onecall?lat=40.7108954265027&lon=-74.01161483217898&appid=005e993f8012d36439ab721c672d9d19';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return WeatherApiModel.fromJson(body);

    } else {
      print('Failed to load weather data. Status code: ${response.statusCode}');
      throw Exception('Error fetching weather data');
    }
  }
}
