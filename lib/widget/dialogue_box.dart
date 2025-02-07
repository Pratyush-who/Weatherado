import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DialogueBox extends StatefulWidget {
const DialogueBox({super.key});
  @override
  _DialogueBoxState createState() => _DialogueBoxState();
}
class _DialogueBoxState extends State<DialogueBox> {
  TextEditingController cityController = TextEditingController();
  bool isLoading = false;
  Future<void> getCity(String cityName) async {
    if (cityName.isEmpty) return;
    setState(() => isLoading = true);
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=f84b02b32dc9fdfe4eba1d04ecf11342');
    final response = await http.get(url);
    setState(() => isLoading = false);
    if (response.statusCode == 200) {
      Navigator.pop(context, cityName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("City not found!"), duration: Duration(seconds: 2)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: isLoading ? null : () => getCity(cityController.text.trim()),
              child: isLoading
                  ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}