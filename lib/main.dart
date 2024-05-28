
import 'package:flutter/material.dart';
import 'package:weather_apis/Routes/RoutesInitillizing.dart';
import 'package:weather_apis/Routes/Routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return   const MaterialApp(
     title: "Weather App",
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.homeScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

