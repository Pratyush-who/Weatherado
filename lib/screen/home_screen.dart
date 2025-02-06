import 'dart:ui';
import 'package:apihandelling/api/const.dart';
import 'package:apihandelling/widget/bottomNav.dart';
import 'package:apihandelling/widget/description.dart';
import 'package:apihandelling/widget/dialogue_box.dart';
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
    fetchWeather("Lucknow");
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> fetchWeather(String cityName) async {
  var weather = await wf.currentWeatherByCityName(cityName);
  var forecast = await wf.fiveDayForecastByCityName(cityName);
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
            initialChildSize: 0.40,
            minChildSize: 0.40,
            maxChildSize: 0.71,
            builder: (context, controller) {
              return ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                  child: Container(
                    color: const Color.fromARGB(255, 76, 44, 132).withOpacity(0.1),
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
                            SizedBox(height: 10,),
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
      bottomNavigationBar: ClipRRect(
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), 
    child: Container(
      color: Color.fromARGB(255, 74, 44, 132).withOpacity(.8), 
      child: BottomAppBar(
        color: Colors.transparent,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.pin_drop_outlined, color: Colors.white,size: 30,),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: Icon(Icons.list, color: Colors.white,size: 30,),
              onPressed: () => _onItemTapped(2),
            ),
          ],
        ),
      ),
    ),
  ),
),
floatingActionButton: Stack(
  alignment: Alignment.bottomCenter,
  children: [
    Positioned(
      bottom: 3, // Adjust this value to move FAB down
      child: FloatingActionButton(
        onPressed: () async {
          final selectedCity = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return DialogueBox();
            },
          );
          
          if (selectedCity != null && selectedCity.isNotEmpty) {
            setState(() {
              fetchWeather(selectedCity);  // Fetch the weather data for the selected city
            });
          }
        },
        backgroundColor: Colors.purple[200],
        shape: CircleBorder(),
        elevation: 10, // Adds a nice shadow effect
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
    ),
  ],
),


floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, 

    );
  }
}
