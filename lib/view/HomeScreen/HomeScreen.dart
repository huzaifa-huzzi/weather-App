import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_apis/Model/Weather_Api_Model.dart';
import 'package:weather_apis/view_model/Weather_view_model.dart';

class HomeScreen extends StatefulWidget  {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    WeatherViewModel weatherViewModel = WeatherViewModel();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child:  FutureBuilder(
            future: weatherViewModel.fetch(),
            builder: (BuildContext context, AsyncSnapshot<WeatherApiModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SpinKitFadingCircle(color: Colors.blue),
                );
              } else {
                return Column(
                  children: [
                     Text(snapshot.data!.timezone.toString())
                  ],
                );
              }
            },
          ),
      ),

    );
  }
}
