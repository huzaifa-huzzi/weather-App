import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:weather_apis/Model/Weather_Api_Model.dart';
import 'package:weather_apis/view_model/Weather_view_model.dart';


class HomScreen extends StatefulWidget {
  const HomScreen({super.key});

  @override
  State<HomScreen> createState() => _HomScreenState();
}

class _HomScreenState extends State<HomScreen> {

   WeatherViewModel weatherViewModel = WeatherViewModel();
  final format = DateFormat( 'MMMM dd,yyyy');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: FutureBuilder<WeatherApiModel>(future:weatherViewModel.fetch() , builder:(BuildContext context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitFadingCircle(color: Colors.blue,),);
          } else{
            return Column(
              children: [
                Text(snapshot.data!.timezone.toString())
              ],
            );
          }
        })


      )
        
    );
  }
}
