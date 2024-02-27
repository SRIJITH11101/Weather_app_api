import 'package:climatee/screens/location_screen.dart';
import 'package:climatee/services/location.dart';
import 'package:climatee/services/networking.dart';
import 'package:climatee/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  static late double lat;
  static late double long;
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  //static double lat = 0.0;
  //static double long = 0.0;
  @override
  void initState() {
    super.initState();
    getlocation();
  }

  void getlocation() async {
    WeatherModel wea = WeatherModel();
    var weatherdata = await wea.getlocationweather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherdata);
    }));

    // var longi = decode['coord']['lon'];
    // print(longi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(color: Colors.white, size: 80),
      ),
    );
  }
}
