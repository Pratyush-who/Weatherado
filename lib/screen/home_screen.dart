import 'package:apihandelling/api/const.dart';
import 'package:apihandelling/widget/date_time_info.dart';
import 'package:apihandelling/widget/location_Header.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherFactory wf = WeatherFactory(WEATHER_API_KEY);

  Weather? currentWeather;

  @override
  void initState() {
    super.initState();
    wf.currentWeatherByCityName("India").then((w) {
      setState(() {
        currentWeather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Starry.png'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: currentWeather == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LocationHeader(currentWeather: currentWeather),
                    DateTimeInfo(weatherData: currentWeather),
                  ],
                ),
              ),
      ),
    );
  }
}
