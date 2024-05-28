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
      body: SafeArea(
        child: FutureBuilder<weatherApiModel>(future:weatherViewModel.fetchWeatherApi() , builder: (BuildContext context,snapshot){
               if(snapshot.connectionState == ConnectionState.waiting){
                 return const  Center(child: SpinKitChasingDots(color: Colors.blue,size: 40,),);
               }else{
                 return ListView.builder(
                     itemCount: snapshot.data!.timezone!.length,
                     itemBuilder: (context,index){

                   return Column(
                     children: [
                       SizedBox(height: height * .04,),

                     ],
                   );

                 });
               }
            }),
      )
        
    );
  }
}
