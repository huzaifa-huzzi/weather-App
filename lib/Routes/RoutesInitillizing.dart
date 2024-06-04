import 'package:flutter/material.dart';
import 'package:weather_apis/Routes/Routes_name.dart';
import 'package:weather_apis/view/HomeScreen/HomeScreen.dart';
import 'package:weather_apis/view/Main%20Screen/MainScree.dart';


class Routes {

  static Route<dynamic>generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) =>const  HomeScreen());

      case RoutesName.mainScreen:
        return MaterialPageRoute(builder: (context) =>const  MainScreen());



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