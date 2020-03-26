import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_icons/weather_icons.dart';

const apiUrl = 'http://api.openweathermap.org/data/2.5/weather';
const apiKey = '42fa4d09ed94047519c4a920328f078b';

class WeatherModel {
  String lang = 'sp';

  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$apiUrl?q=$cityName&appid=$apiKey&lang=$lang';

    var weatherData = await NetworkHelper(url).getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$apiUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&lang=$lang');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  IconData getWeatherIcon(int condition) {
    if (condition < 300) {
      return WeatherIcons.thunderstorm;
    } else if (condition < 400) {
      return WeatherIcons.rain_mix;
    } else if (condition < 600) {
      return WeatherIcons.rain;
    } else if (condition < 700) {
      return WeatherIcons.snow;
    } else if (condition < 800) {
      return WeatherIcons.fog;
    } else if (condition == 800) {
      return WeatherIcons.day_sunny;
    } else if (condition <= 804) {
      return WeatherIcons.cloudy;
    } else {
      return WeatherIcons.windy;
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
