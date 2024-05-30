import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_apis/Model/Weather_Api_Model.dart';
import 'package:weather_apis/view_model/Weather_view_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Initialize WeatherViewModel
  WeatherViewModel weatherViewModel = WeatherViewModel();



  @override
  Widget build(BuildContext context) {
    // Get screen size
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: FutureBuilder<WeatherApiModel>(
          future: weatherViewModel.fetch(),
          builder: (BuildContext context, AsyncSnapshot<WeatherApiModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {

              return  const Center(
                child: SpinKitFadingCircle(color: Colors.blue),
              );
            } else if (snapshot.hasError) {
              // Handle error case
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else  {
              String cityName = snapshot.data!.timezone?.split('/')?.last ?? '';
              return Column(
                children: [
                  Container(
                    child: Text(cityName),
                  ),

                ],
              );
            }
          },
        ),
      ),
    );
  }
}
