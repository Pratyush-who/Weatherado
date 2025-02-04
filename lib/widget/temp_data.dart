import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

class TempData extends StatelessWidget {
  final Weather? currentTemp;
  const TempData({super.key, required this.currentTemp});

  @override
  Widget build(BuildContext context) {
    int temp =
        currentTemp?.temperature?.celsius?.round() ?? 0; // Ensure int value
    return Text(
      "$temp\u00B0",
      style: GoogleFonts.openSans(
          fontSize: 80, fontWeight: FontWeight.w100, color: Colors.white),
    );
  }
}
