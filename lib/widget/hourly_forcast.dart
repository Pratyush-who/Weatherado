import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class HourlyForecast extends StatelessWidget {
  final List<Weather> forecast;

  const HourlyForecast({required this.forecast});

  // Convert 24-hour format to 12-hour AM/PM format
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

          // Debug: Print icon code
          print("Weather Icon Code: ${weather.weatherIcon}");

          // OpenWeatherMap icon URL (changed @4x to @2x)
          String iconUrl = weather.weatherIcon != null
              ? "https://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png"
              : "";

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Container(
              width: 72,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formatHour(weather.date),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),

                  // Weather Icon (handles null & errors)
                  iconUrl.isNotEmpty
                      ? Image.network(
                          iconUrl,
                          width: 40,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return CircularProgressIndicator();
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.cloud,
                                color: Colors.white, size: 40);
                          },
                        )
                      : Icon(Icons.cloud,
                          color: Colors.white, size: 40), // Fallback icon

                  SizedBox(height: 5),
                  Text(
                    '${weather.temperature?.celsius?.toStringAsFixed(0)}°C',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
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
