import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class HourlyForecast extends StatelessWidget {
  final List<Weather> forecast;

  const HourlyForecast({required this.forecast});

  String formatHour(DateTime? date) {
    if (date == null) return "";
    int hour = date.hour;
    String period = hour >= 12 ? "PM" : "AM";
    return "${hour % 12 == 0 ? 12 : hour % 12} $period";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          Weather weather = forecast[index];
          String iconUrl = weather.weatherIcon != null
              ? "https://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png"
              : "https://openweathermap.org/img/wn/10d@2x.png";

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Container(
              width: 62,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.shade400,
                    Colors.deepPurple.shade600,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                    color: Colors.white.withOpacity(0.5), width: 1.5),
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formatHour(weather.date),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Image.network(
                    iconUrl,
                    width: 40,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CircularProgressIndicator();
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.cloud, color: Colors.white, size: 40);
                    },
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${weather.temperature?.celsius?.toStringAsFixed(0)}°',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

  }
}
