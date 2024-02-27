import 'dart:ui';

import 'package:climatee/screens/city_screen.dart';
import 'package:climatee/services/weather.dart';
import 'package:climatee/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:climatee/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temp = 0;
  int cond = 0;
  String cname = "";
  WeatherModel wea = WeatherModel();
  String icon = '', msg = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update(widget.locationWeather);
  }

  void update(dynamic Wdata) {
    setState(() {
      double temp = Wdata['main']['temp'];
      this.temp = temp.toInt();
      cond = Wdata['weather'][0]['id'];
      cname = Wdata['name'];
      icon = wea.getWeatherIcon(cond);
      msg = wea.getMessage(this.temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherdata = await wea.getlocationweather();
                      update(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var type = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (type != null) {
                        var weatherdata = await wea.getWeatherbyName(type);
                        update(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°C',
                      style: kTempTextStyle,
                    ),
                    Expanded(
                      child: Text(
                        '$icon',
                        style: kConditionTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$msg in $cname",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
