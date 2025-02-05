import 'dart:convert';
import 'package:http/http.dart' as http;

const String WEATHER_API_KEY = "YOUR_API_KEY_HERE"; // Replace with your actual API key

class WeatherService {
  static const String baseUrl = "https://api.openweathermap.org/data/2.5";

  // Function to fetch hourly weather data
  static Future<List<dynamic>> getHourlyForecast(double lat, double lon) async {
    final String url = "$baseUrl/forecast?lat=$lat&lon=$lon&units=metric&appid=$WEATHER_API_KEY";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['list']; // Returns the hourly forecast list
    } else {
      throw Exception("Failed to load hourly weather data");
    }
  }
}
