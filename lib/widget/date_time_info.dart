import 'package:flutter/material.dart';
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
          DateFormat("h:m a").format(
            now,
          ),
          style: TextStyle(fontSize: 34),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text(DateFormat("EEEE").format(now),),],
        ),
      ],
    );
  }
}
