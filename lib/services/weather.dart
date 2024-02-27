import 'dart:async';

import 'package:climatee/services/location.dart';
import 'package:climatee/services/networking.dart';

class WeatherModel {
  Future<dynamic> getWeatherbyName(String cityname) async {
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=4544755d6912a7f7715a28b98fa22e5a&units=metric";
    NetworkHelp networkhelp = NetworkHelp(url);
    var weatherdata = await networkhelp.getdata();
    return weatherdata;
  }

  Future<dynamic> getlocationweather() async {
    Location location = Location();
    await location.getLocation();
    //lat = location.latitude;
    //long = location.longitude;
    var url =
        "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=4544755d6912a7f7715a28b98fa22e5a&units=metric";
    NetworkHelp networkhelp = NetworkHelp(url);
    var weatherdata = await networkhelp.getdata();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
