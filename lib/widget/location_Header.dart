import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

class LocationHeader extends StatelessWidget {
  final Weather? currentWeather;

  const LocationHeader({super.key, required this.currentWeather});

  @override
  Widget build(BuildContext context) {
    return Text(
      currentWeather?.areaName ?? "Wrong..!!",
      style: GoogleFonts.beVietnamPro(
          fontSize: 34, fontWeight: FontWeight.w400, color: Colors.white),
    );
  }
}
