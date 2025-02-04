import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class DateTimeInfo extends StatelessWidget {
  final Weather? weatherData;
  const DateTimeInfo({super.key,required this.weatherData});
  @override

  Widget build(BuildContext context) {
    DateTime now = weatherData?.date ?? DateTime.now();
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(
            now,
          ),
          style: GoogleFonts.lato(fontSize: 24,color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
