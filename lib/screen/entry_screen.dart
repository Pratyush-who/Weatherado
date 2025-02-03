import 'package:apihandelling/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1A237E),
              Color.fromARGB(255, 67, 74, 153),
              Color.fromARGB(255, 154, 96, 179),
            ],
            stops: [0.2, 0.8, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: Image.asset('assets/images/loginimg.png'),
            ),
            Text(
              'Weather',
              style: GoogleFonts.poppins(
                fontSize: 60,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            Text(
              'ForeCasts',
              style: TextStyle(
                  color: Color.fromARGB(255, 221, 178, 48),
                  fontSize: 60,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 70,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
              child: Text(
                'Get Started',
                style: GoogleFonts.roboto(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 46, 56, 161)),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 221, 178, 48),
                minimumSize: Size(280, 60),
              ),
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
