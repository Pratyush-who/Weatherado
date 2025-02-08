import 'package:apihandelling/screen/popular_cities.dart';
import 'package:flutter/material.dart';
import 'package:apihandelling/screen/entry_screen.dart';
import 'package:apihandelling/screen/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const EntryScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        PopularCitiesScreen.routeName: (context) => PopularCitiesScreen(),
      },
    );
  }
}
