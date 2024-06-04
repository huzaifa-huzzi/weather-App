import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async' as async;

import 'package:weather_apis/view/HomeScreen/HomeScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

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
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/Icons/clouds.png'),
                SizedBox(height: height * .05,),
                const SpinKitFadingCircle(color: Colors.blue)
              ],
            ),
          )
      ),
    );
  }
}

