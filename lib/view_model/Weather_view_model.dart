

import 'package:weather_apis/Model/Weather_Api_Model.dart';
import 'package:weather_apis/Respository/weather_repository.dart';

class WeatherViewModel{

  final _repo = WeatherRepository();

  Future<weatherApiModel>fetchWeatherApi()async{
    final response = await _repo.fetchWeatherApi();
     return response;
  }


}