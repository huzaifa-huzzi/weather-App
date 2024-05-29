import 'package:flutter/cupertino.dart';
import 'package:weather_apis/Model/Weather_Api_Model.dart';
import 'package:weather_apis/Respository/weather_repository.dart';

class WeatherViewModel {
  final _repo = WeatherRepository();

  Future<WeatherApiModel> fetch() async {
    try {
      final response = await _repo.fetch();
      return response;
    } catch (e) {
      debugPrint('Error in ViewModel: $e'); // Debug print to catch any errors
      rethrow;
    }
  }
}
