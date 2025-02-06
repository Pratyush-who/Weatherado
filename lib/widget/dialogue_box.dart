import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DialogueBox extends StatefulWidget {
  const DialogueBox({super.key});

  @override
  _DialogueBoxState createState() => _DialogueBoxState();
}

class _DialogueBoxState extends State<DialogueBox> {
  List<String> cities = ['Lucknow', 'Delhi', 'Mumbai', 'Bangalore', 'Chennai']; // Mock list of cities
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300,
        width: 300,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(cities[index]),
                    onTap: () {
                      Navigator.pop(context, cities[index]);  // Send selected city back
                    },
                  );
                },
              ),
      ),
    );
  }
}
