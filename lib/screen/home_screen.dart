import 'dart:ui';
import 'package:apihandelling/api/const.dart';
import 'package:apihandelling/widget/bottomNav.dart';
import 'package:apihandelling/widget/description.dart';
import 'package:apihandelling/widget/highTemp.dart';
import 'package:apihandelling/widget/hourly_forcast.dart';
import 'package:apihandelling/widget/location_Header.dart';
import 'package:apihandelling/widget/lowTemp.dart';
import 'package:apihandelling/widget/temp_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  List<Weather> hourlyForecast = [];

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> fetchWeather() async {
    var weather = await wf.currentWeatherByCityName("Lucknow");
    var forecast = await wf.fiveDayForecastByCityName("Lucknow");
    var now = DateTime.now();

    setState(() {
      currentWeather = weather;
      hourlyForecast = forecast
          .where((w) => w.date?.isAfter(now) ?? false)
          .take(10)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Starry.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: currentWeather == null
                ? Center(child: CircularProgressIndicator())
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
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
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
                            Text('Hourly Forcast',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500)),
                            Spacer(),
                            Text('Weekly Forcast',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Divider(
                            color: Colors.white.withOpacity(0.5), thickness: 1),
                        hourlyForecast.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : HourlyForecast(forecast: hourlyForecast),
                        ListTile(
                          leading: Icon(
                            Icons.thermostat,
                            color: const Color.fromARGB(255, 177, 166, 166),
                            size: 30,
                          ),
                          title: Text(
                            "Feels Like: ${currentWeather?.tempFeelsLike?.celsius?.toStringAsFixed(1)}°C",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.water_drop,
                              color: const Color.fromARGB(255, 177, 166, 166),
                              size: 30),
                          title: Text(
                            "Humidity: ${currentWeather?.humidity}%",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.wind_power,
                              color: const Color.fromARGB(255, 177, 166, 166),
                              size: 30),
                          title: Text(
                              "Wind Speed: ${currentWeather?.windSpeed} m/s",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ),
                        ListTile(
                          leading: Icon(Icons.wb_sunny,
                              color: const Color.fromARGB(255, 177, 166, 166),
                              size: 30),
                          title: Text(
                            "Sunrise: ${currentWeather?.sunrise != null ? DateFormat("h:mm a").format(DateTime.fromMillisecondsSinceEpoch(currentWeather!.sunrise!.millisecondsSinceEpoch)) : 'N/A'}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.nightlight_round_outlined,
                              color: const Color.fromARGB(255, 177, 166, 166),
                              size: 30),
                          title: Text(
                            "Sunset: ${currentWeather?.sunrise != null ? DateFormat("h:mm a").format(DateTime.fromMillisecondsSinceEpoch(currentWeather!.sunset!.millisecondsSinceEpoch)) : 'N/A'}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
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
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.pin_drop_outlined),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _onItemTapped(1),
            ),
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () => _onItemTapped(2),
            ),
          ],
        ),
      ),
    );
  }
}
