import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
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

  String currentDate = DateFormat('MMMM dd, yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<WeatherApiModel>(
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
              String cityName = snapshot.data!.timezone?.split('/')?.last ?? '';
              var weatherIcon = snapshot.data!.current!.weather?.first.icon ?? '';
              var weatherDescription = snapshot.data!.current!.weather?.first.description ?? '';

              return ListView(
                children: [
                  Column(
                    children: [
                      SizedBox(height: height * .03,),
                      Padding(
                        padding:const  EdgeInsets.only(right: 170),
                        child: Column(
                          children: [
                            Text(
                              cityName,
                              style: const TextStyle(fontSize: 35),
                            ),
                            Text(
                              currentDate,
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * .06,),
                      Padding(
                        padding:const  EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/weather/$weatherIcon.png',
                              height: 50,
                              width: 50,
                            ),
                            Padding(
                              padding:const  EdgeInsets.only(right: 20),
                              child: RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${snapshot.data!.current!.temp.toString()}\u00B0',
                                          style:const  TextStyle(fontSize: 40, color: Colors.black,fontWeight: FontWeight.w600), // Define style here
                                        ),
                                        TextSpan(
                                          text: weatherDescription,
                                          style:const  TextStyle(fontSize: 14, color: Colors.grey,fontWeight: FontWeight.w400), // Define style here
                                        ),

                                      ]
                                  )
                              ),
                            )
                          ],),
                      ),
                      SizedBox(height: height * .06,),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height:60,
                                width: 60,
                                padding:const  EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Image.asset('assets/icons/windspeed.png'),
                              ),
                              Container(
                                height:60,
                                width: 60,
                                padding:const  EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Image.asset('assets/icons/clouds.png'),

                              ),
                              Container(
                                height:60,
                                width: 60,
                                padding:const  EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Image.asset('assets/icons/humidity.png'),

                              )
                            ],
                          ),
                          SizedBox(height: height * .01,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 60,
                                child: Text("${snapshot.data!.current!.windSpeed.toString()} km/h",style: const TextStyle(fontSize: 12),textAlign: TextAlign.center,),
                              ),
                              SizedBox(
                                height: 20,
                                width: 60,
                                child: Text("${snapshot.data!.current!.clouds.toString()} %",style: const TextStyle(fontSize: 12),textAlign: TextAlign.center,),
                              ),
                              SizedBox(
                                height: 20,
                                width: 60,
                                child: Text("${snapshot.data!.current!.humidity.toString()} %",style: const TextStyle(fontSize: 12),textAlign: TextAlign.center,),
                              ),

                            ],
                          )
                        ],
                      )


                    ],
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
