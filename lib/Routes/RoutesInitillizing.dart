import 'package:flutter/material.dart';
import 'package:weather_apis/Routes/Routes_name.dart';
import 'package:weather_apis/view/HomeScreen/HomeScreen.dart';


class Routes {

  static Route<dynamic>generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => HomScreen());


      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No Routes Found'),
            ),
          );
        });
    }
  }

}