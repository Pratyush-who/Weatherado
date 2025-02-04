import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

class Description extends StatelessWidget {
  final Weather? descrip;
  const Description({
    super.key,
    required this.descrip
  });

  @override
  Widget build(BuildContext context) {
    return Text(
  descrip?.weatherDescription
      ?.split(' ')
      .map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
      .join(' ') ?? "",style: GoogleFonts.poppins(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.w600),
);
  }
}
