import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

class HighTemp extends StatelessWidget {
  final Weather? highest;
  const HighTemp({
    super.key,
    required this.highest,
  });

  @override
  Widget build(BuildContext context) {
    int temp =
        highest?.tempMax?.celsius?.round() ?? 0;
    return Text(
      "H:$temp\u00B0",
      style: GoogleFonts.poppins(
          fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
    );
  }
}
