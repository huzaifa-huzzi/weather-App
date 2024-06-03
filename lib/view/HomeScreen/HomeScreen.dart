import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_apis/Model/Weather_Api_Model.dart';
import 'package:weather_apis/Utils/Colors.dart';
import 'package:weather_apis/view_model/Weather_view_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherViewModel weatherViewModel = WeatherViewModel();
  String currentDate = DateFormat('MMMM dd, yyyy').format(DateTime.now());

  // Time into Readable Human Time in it.
  String getTime(int timeStamp, int minutesInterval) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    time = time.add(Duration(minutes: minutesInterval));
    String formattedTime = DateFormat('jm').format(time);
    return formattedTime;
  }

  // Time into the Days
  String getDay(final day){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final formattedDay = DateFormat('EEE ').format(time);

    return formattedDay;

  }

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
              String cityName = snapshot.data!.timezone?.split('/').last ?? '';
              var weatherIcon = snapshot.data!.current!.weather?.first.icon ?? '';
              var weatherDescription = snapshot.data!.current!.weather?.first.description ?? '';

              return ListView(
                children: [
                  Column(
                    children: [
                      SizedBox(height: height * .03,),
                      Padding(
                        padding: const EdgeInsets.only(right: 170),
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
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/weather/$weatherIcon.png',
                              height: 50,
                              width: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${snapshot.data!.current!.temp.toString()}\u00B0',
                                      style: const TextStyle(fontSize: 40, color: Colors.black, fontWeight: FontWeight.w600),
                                    ),
                                    TextSpan(
                                      text: weatherDescription,
                                      style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * .06,),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.asset('assets/icons/windspeed.png'),
                              ),
                              Container(
                                height: 60,
                                width: 60,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.asset('assets/icons/clouds.png'),
                              ),
                              Container(
                                height: 60,
                                width: 60,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.asset('assets/icons/humidity.png'),
                              ),
                            ],
                          ),
                          SizedBox(height: height * .01,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 60,
                                child: Text("${snapshot.data!.current!.windSpeed.toString()} km/h", style: const TextStyle(fontSize: 12), textAlign: TextAlign.center,),
                              ),
                              SizedBox(
                                height: 20,
                                width: 60,
                                child: Text("${snapshot.data!.current!.clouds.toString()} %", style: const TextStyle(fontSize: 12), textAlign: TextAlign.center,),
                              ),
                              SizedBox(
                                height: 20,
                                width: 60,
                                child: Text("${snapshot.data!.current!.humidity.toString()} %", style: const TextStyle(fontSize: 12), textAlign: TextAlign.center,),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height * .02,),
                      Column(
                        children: [
                          const Text('Today', style: TextStyle(fontSize: 18),),
                          SizedBox(height: height * .03,),
                          HourlyWeatherList(
                            snapshot: snapshot,
                            height: height,
                            getTime: getTime,
                          ),
                        ],
                      ),
                      SizedBox(height: height * .04,),
                      Container(
                        height: 400,
                        margin: const EdgeInsets.all(20),
                        padding:const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: CustomColors.dividerLine.withAlpha(150),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child:Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin:const  EdgeInsets.only(bottom: 10),
                              child:const  Text('Next Days',style: TextStyle(color: CustomColors.textColorBlack,fontSize: 17),),
                            ),
                            SizedBox(height: height * .02,),
                            SizedBox(
                              height: 300,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data!.daily!.length > 7 ? 7:snapshot.data!.daily!.length,
                                  itemBuilder: (context,index){
                                    var weatherIcons = snapshot.data!.daily![index].weather?.first.icon ?? '';
                                    var weatherTemp = snapshot.data!.daily![index].temp?.max ?? '';
                                    var weatherTempTwo = snapshot.data!.daily![index].temp?.min ?? '';

                                    return Column(
                                    children: [
                                       Container(
                                         height:60,
                                         padding:const EdgeInsets.only(left: 10,right: 10) ,
                                         child:Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                           children: [
                                             SizedBox(
                                               width: 80,
                                               child: Text(getDay(snapshot.data!.daily![index].dt),style:const  TextStyle(color: CustomColors.textColorBlack,fontSize: 14),),
                                             ),
                                             SizedBox(
                                               height: 30,
                                               width: 30,
                                               child: Image.asset( 'assets/weather/$weatherIcons.png',),
                                             ),
                                             SizedBox(width: width * .05,),
                                             Text('${weatherTemp}\u00B0 /${weatherTempTwo}\u00B0  '),
                                             Container(
                                               height: 1,
                                               color: CustomColors.dividerLine,
                                             )

                                             

                                           ],
                                         )


                                       )
                                    ],
                                  );

                              }),
                            ),
                            
                          ],
                        ) ,
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



class HourlyWeatherList extends StatefulWidget {
  final AsyncSnapshot snapshot;
  final double height;
  final String Function(int, int) getTime;

  HourlyWeatherList({super.key,
    required this.snapshot,
    required this.height,
    required this.getTime,
  });

  @override
  _HourlyWeatherListState createState() => _HourlyWeatherListState();
}

class _HourlyWeatherListState extends State<HourlyWeatherList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.snapshot.data!.hourly!.length > 12 ? 12 : widget.snapshot.data!.hourly!.length,
        itemBuilder: (context, index) {
          var hourlyData = widget.snapshot.data!.hourly![index];
          var weatherIcon = hourlyData.weather?.first.icon ?? '';
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 80,
              margin: const EdgeInsets.only(left: 20, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0.5, 0),
                    blurRadius: 30,
                    spreadRadius: 1,
                    color: selectedIndex == index ? CustomColors.dividerLine.withAlpha(150) : Colors.transparent,
                  ),
                ],
                gradient: LinearGradient(
                  colors: selectedIndex == index ? [CustomColors.firstGradientColor, CustomColors.secondGradientColor] : [CustomColors.dividerLine, CustomColors.dividerLine.withAlpha(150)],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: widget.height * .02,),
                  Text(
                    hourlyData.dt != null ? widget.getTime(hourlyData.dt!, index * 30) : 'N/A',
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Image.asset(
                      'assets/weather/$weatherIcon.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  SizedBox(height: widget.height * .01,),
                  Text('${hourlyData.temp.toString()}\u00B0'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
