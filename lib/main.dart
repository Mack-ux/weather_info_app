import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();
  String _cityName = '';
  String _temperature = '';
  String _weatherCondition = '';

  // Function to simulate fetching weather data
  void _fetchWeather() {
    final city = _cityController.text;

    if (city.isEmpty) {
      // If the user hasn't entered a city, show an error
      setState(() {
        _cityName = '';
        _temperature = '';
        _weatherCondition = 'Please enter a city name.';
      });
      return;
    }

    final random = Random();
    
    // Generate a random temperature between 15°C and 30°C
    final temp = 15 + random.nextInt(16); // 15 to 30°C

    // List of weather conditions
    const weatherConditions = ['Sunny', 'Cloudy', 'Rainy'];
    final condition = weatherConditions[random.nextInt(weatherConditions.length)];

    setState(() {
      _cityName = city;
      _temperature = '$temp°C';
      _weatherCondition = condition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: Text('Fetch Weather'),
            ),
            SizedBox(height: 16.0),
            if (_cityName.isNotEmpty)
              Text(
                'City: $_cityName',
                style: TextStyle(fontSize: 20),
              ),
            if (_temperature.isNotEmpty)
              Text(
                'Temperature: $_temperature',
                style: TextStyle(fontSize: 20),
              ),
            if (_weatherCondition.isNotEmpty)
              Text(
                'Condition: $_weatherCondition',
                style: TextStyle(fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}