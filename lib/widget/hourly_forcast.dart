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
            child: CustomPaint(
              size: Size(62, 120),
              painter: BorderGradientPainter(),
              child: Container(
                width: 62,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 82, 61, 158).withOpacity(.6), // Background color
                  borderRadius: BorderRadius.circular(40),
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
            ),
          );
        },
      ),
    );
  }
}

class BorderGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [const Color.fromARGB(255, 200, 166, 206), Colors.transparent], // White to transparent
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(40));
    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
