import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enhanced Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
      debugShowCheckedModeBanner: false, // Hide debug banner
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();
  String _cityName = '';
  String _temperature = '';
  String _weatherCondition = '';
  bool _isLoading = false;

  // Function to get weather icon based on condition
  IconData _getWeatherIcon(String condition) {
    switch (condition) {
      case 'Sunny':
        return Icons.wb_sunny;
      case 'Cloudy':
        return Icons.cloud;
      case 'Rainy':
        return Icons.beach_access;
      default:
        return Icons.wb_cloudy;
    }
  }

  // Function to get background color based on weather
  Color _getBackgroundColor(String condition) {
    switch (condition) {
      case 'Sunny':
        return Colors.orange.shade300;
      case 'Cloudy':
        return Colors.blueGrey.shade300;
      case 'Rainy':
        return Colors.blue.shade400;
      default:
        return Colors.white;
    }
  }

  // Function to simulate fetching weather data
  void _fetchWeather() {
    final city = _cityController.text.trim();

    if (city.isEmpty) {
      // If no city name is entered, show an error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a city name."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      final random = Random();

      // Generate a random temperature between 15°C and 30°C
      final temp = 15 + random.nextInt(16); // 15 to 30°C

      // List of weather conditions
      const weatherConditions = ['Sunny', 'Cloudy', 'Rainy'];
      final condition =
          weatherConditions[random.nextInt(weatherConditions.length)];

      setState(() {
        _cityName = city;
        _temperature = '$temp°C';
        _weatherCondition = condition;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _getBackgroundColor(_weatherCondition),
      appBar: AppBar(
        title: Text('Enhanced Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            _isLoading
                ? CircularProgressIndicator() // Show loading spinner
                : Column(
                    children: [
                      if (_cityName.isNotEmpty)
                        Text(
                          'City: $_cityName',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      if (_temperature.isNotEmpty)
                        Text(
                          'Temperature: $_temperature',
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                        ),
                      if (_weatherCondition.isNotEmpty)
                        Column(
                          children: [
                            Icon(
                              _getWeatherIcon(_weatherCondition),
                              size: 80,
                              color: Colors.white,
                            ),
                            Text(
                              'Condition: $_weatherCondition',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
