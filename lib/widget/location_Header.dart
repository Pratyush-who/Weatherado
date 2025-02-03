import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class LocationHeader extends StatelessWidget {
  final Weather? currentWeather;

  const LocationHeader({super.key, required this.currentWeather});

  @override
  Widget build(BuildContext context) {
    return Text(
      currentWeather?.country ?? "Wrong..!!",
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }
}
