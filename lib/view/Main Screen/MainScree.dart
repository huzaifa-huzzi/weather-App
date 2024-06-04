import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_apis/Model/Weather_Api_Model.dart';
import 'package:weather_apis/Utils/Colors.dart';
import 'dart:async' as async;

import 'package:weather_apis/view/HomeScreen/HomeScreen.dart';
import 'package:weather_apis/view_model/Weather_view_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  WeatherViewModel weatherViewModel = WeatherViewModel();

  @override
  void initState() {
    super.initState();
    async.Timer(const Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>const  HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:FutureBuilder<WeatherApiModel>(
        future: weatherViewModel.fetch(),
        builder: (BuildContext context, AsyncSnapshot<WeatherApiModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitFadingCircle(color: Colors.blue),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/clouds.png'),
               SizedBox(height: height * .04,),
               const  SpinKitFadingCircle(color: CustomColors.firstGradientColor,)
              ],
            );
          }
        },
      ),




    );
  }
}

