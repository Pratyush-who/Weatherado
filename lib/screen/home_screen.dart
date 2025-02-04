import 'dart:ui';
import 'package:apihandelling/api/const.dart';
import 'package:apihandelling/widget/description.dart';
import 'package:apihandelling/widget/highTemp.dart';
import 'package:apihandelling/widget/location_Header.dart';
import 'package:apihandelling/widget/lowTemp.dart';
import 'package:apihandelling/widget/temp_data.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherFactory wf =
      WeatherFactory(WEATHER_API_KEY, language: Language.ENGLISH);

  Weather? currentWeather;

  @override
  void initState() {
    super.initState();
    wf.currentWeatherByCityName("lucknow").then((w) {
      print(w.temperature?.celsius);
      setState(() {
        currentWeather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // <-- Wrap everything in a Stack
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Starry.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            child: currentWeather == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LocationHeader(currentWeather: currentWeather),
                        TempData(currentTemp: currentWeather),
                        Description(descrip: currentWeather),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            HighTemp(highest: currentWeather),
                            SizedBox(width: 10),
                            LowTemp(lowest: currentWeather),
                          ],
                        ),
                        Image.asset('assets/images/house.png', height: 350),
                        SizedBox(height: 90),
                      ],
                    ),
                  ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.42,
            minChildSize: 0.42,
            maxChildSize: 0.71,
            builder: (context, controller) {
              return ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
                child: BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: 20, sigmaY: 20), // Blur effect
                  child: Container(
                    color: Colors.white.withOpacity(0.1),
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 30),
                    child: ListView(
                      controller: controller,
                      children: [
                        Center(
                          child: Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text('Hourly Forcast',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w500),),
                            SizedBox(width: 140,),
                            Text('Hourly Forcast',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w500), ),                           
                          ],
                        ),
                        Divider(color: Colors.white.withOpacity(0.5), thickness: 1),
                        ListTile(
                          leading: Icon(Icons.thermostat),
                          title: Text(
                              "Feels Like: ${currentWeather?.tempFeelsLike?.celsius?.toStringAsFixed(1)}°C"),
                        ),
                        ListTile(
                          leading: Icon(Icons.water_drop),
                          title: Text("Humidity: ${currentWeather?.humidity}%"),
                        ),
                        ListTile(
                          leading: Icon(Icons.wind_power),
                          title: Text(
                              "Wind Speed: ${currentWeather?.windSpeed} m/s"),
                        ),
                        ListTile(
                          leading: Icon(Icons.wb_sunny),
                          title: Text("Sunrise: ${currentWeather?.sunrise}"),
                        ),
                        ListTile(
                          leading: Icon(Icons.nightlight_round),
                          title: Text("Sunset: ${currentWeather?.sunset}"),
                        ),
                      ],
                    ),
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
