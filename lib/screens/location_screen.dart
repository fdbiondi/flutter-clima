import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  IconData weatherIcon;
  String weatherMessage = '';
  String cityName;

  int temperature;

  int minTemp = 0;
  int maxTemp = 0;
  int humidity = 0;
  int wind = 0;
  int visibility = 0;

  String today;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  int tempToMetric(double temp) {
    return (temp - 273.1).toInt();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      today = DateFormat("yMMMMEEEEd").format(DateTime.now());

      if (weatherData == null || weatherData['error'] == 404) {
        temperature = 0;
        weatherMessage = 'Error! Unable to get weather data';
        cityName = '';
        weatherIcon = WeatherIcons.na;
        return;
      }

      int condition = weatherData['weather'][0]['id'];

      temperature = tempToMetric(weatherData['main']['temp']);
      cityName = weatherData['name'];

      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weatherData['weather'][0]['main'];

      minTemp = tempToMetric(weatherData['main']['temp_min']);
      maxTemp = tempToMetric(weatherData['main']['temp_max']);
      humidity = weatherData['main']['humidity'];

      wind = weatherData['wind']['speed'].toInt();
      visibility = 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorPrimary,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () async {
                                  String typedName = await Navigator.push(
                                      this.context, MaterialPageRoute(
                                    builder: (context) {
                                      return CityScreen();
                                    },
                                  ));

                                  if (typedName != null) {
                                    var weatherData =
                                        await weather.getCityWeather(typedName);
                                    updateUI(weatherData);
                                  }
                                },
                                child: Icon(
                                  Icons.location_on,
                                  size: 30.0,
                                ),
                              ),
                              FlatButton(
                                onPressed: () async {
                                  dynamic weatherData =
                                      await weather.getLocationWeather();
                                  updateUI(weatherData);
                                },
                                child: Icon(
                                  Icons.refresh,
                                  size: 30.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              BoxedIcon(
                                weatherIcon,
                                size: 50,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                cityName,
                                style: kCityTextStyle,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                weatherMessage,
                                style: kConditionTextStyle,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorPrimaryLight,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '$temperature°',
                            style: kTempTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorAccent,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorAccentLight,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorSecondaryLighter,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          BoxedIcon(
                            WeatherIcons.thermometer,
                          ),
                          BoxedIcon(
                            WeatherIcons.cloudy_gusts,
                          ),
                          BoxedIcon(
                            WeatherIcons.raindrop,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorSecondaryLight,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'High/Low',
                                style: kStatsTextStyle,
                              ),
                              Text(
                                '$maxTemp°/$minTemp°',
                                style: kStatsValuesTextStyle,
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Wind',
                                style: kStatsTextStyle,
                              ),
                              Text(
                                '${wind}mph',
                                style: kStatsValuesTextStyle,
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Humidity',
                                style: kStatsTextStyle,
                              ),
                              Text(
                                '$humidity%',
                                style: kStatsValuesTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorSecondary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorSecondaryDark,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    today,
                                    style: kDateTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
