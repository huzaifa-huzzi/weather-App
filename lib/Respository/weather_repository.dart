import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:weather_apis/Model/Weather_Api_Model.dart';

class WeatherRepository {


  Future<WeatherApiModel> fetch() async {
    String url = 'https://api.openweathermap.org/data/3.0/onecall?lat=33.7846143068728&lon=72.72223940755853&appid=005e993f8012d36439ab721c672d9d19&units=metric&exclude=minutely';

    final response = await http.get(Uri.parse(url));

    if (kDebugMode) {
      print(response.body);
    }

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return WeatherApiModel.fromJson(body);

    } else {
      print('Failed to load weather data. Status code: ${response.statusCode}');
      throw Exception('Error fetching weather data');
    }
  }
}
