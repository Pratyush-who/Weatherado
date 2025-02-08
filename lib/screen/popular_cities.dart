import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import '../api/const.dart';
import 'package:intl/intl.dart';

class PopularCitiesScreen extends StatefulWidget {
  static const routeName = '/popularCities';

  @override
  _PopularCitiesScreenState createState() => _PopularCitiesScreenState();
}

class _PopularCitiesScreenState extends State<PopularCitiesScreen> {
  final WeatherFactory wf =
      WeatherFactory(WEATHER_API_KEY, language: Language.ENGLISH);

  List<String> popularCities = [
    "Karachi",
    "Ghaziabad",
    "Uttarakhand",
    "Delhi",
    "Lucknow",
    "Mumbai",
    "Maharashtra",
    "Agra"
  ];
  Map<String, Weather?> cityWeather = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeatherForCities();
  }

  Future<void> fetchWeatherForCities() async {
    for (String city in popularCities) {
      var weather = await wf.currentWeatherByCityName(city);
      setState(() {
        cityWeather[city] = weather;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Popular Cities"),
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // No shadow
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Starry.png'), // Your image
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Starry.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : ListView.builder(
                  itemCount: popularCities.length,
                  itemBuilder: (context, index) {
                    String city = popularCities[index];
                    Weather? weather = cityWeather[city];

                    return Card(
                      color: Colors.white.withOpacity(0.1),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: weather != null
                            ? Image.network(
                                "https://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png",
                                height: 40,
                              )
                            : Icon(Icons.location_city, color: Colors.white),
                        title: Text(
                          city,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          weather != null
                              ? "${weather.temperature?.celsius?.toStringAsFixed(1)}°C | ${weather.weatherDescription?.toUpperCase()}"
                              : "Fetching...",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
