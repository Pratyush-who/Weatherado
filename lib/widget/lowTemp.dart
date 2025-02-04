import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

class LowTemp extends StatelessWidget {
  final Weather? lowest;
  const LowTemp({super.key,required this.lowest});

  @override
  Widget build(BuildContext context) {
    int temp =
        lowest?.tempMin?.celsius?.round() ?? 0; 
    return Text(
      "L:$temp\u00B0",
      style: GoogleFonts.poppins(
          fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
    );
  }
}
