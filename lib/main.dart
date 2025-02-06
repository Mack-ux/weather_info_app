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

  void _fetchWeather() {
    // Here you would typically make an API call to fetch weather data.
    setState(() {
      // For demonstration, setting static data as placeholders
      _cityName = _cityController.text;
      _temperature = '22°C'; // Placeholder temperature
      _weatherCondition = 'Clear Sky'; // Placeholder weather condition
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
