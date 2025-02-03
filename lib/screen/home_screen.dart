import 'package:apihandelling/api/const.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherFactory wf = WeatherFactory(WEATHER_API_KEY);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Starry.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text('data'),
          ),
        ),
      ),
    );
  }
}
