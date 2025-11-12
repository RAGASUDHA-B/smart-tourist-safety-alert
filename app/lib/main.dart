import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const SmartTouristSafetyApp());
}

class SmartTouristSafetyApp extends StatelessWidget {
  const SmartTouristSafetyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Tourist Safety Alert System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Tourist Safety Alert System'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Get real-time hazard alerts, weather updates, and safe route navigation.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Map screen button
            ElevatedButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Open Safety Map'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapScreen()),
                );
              },
            ),
            const SizedBox(height: 20),

            // Weather screen button
            ElevatedButton.icon(
              icon: const Icon(Icons.cloud),
              label: const Text('Check Weather Alerts'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WeatherScreen()),
                );
              },
            ),
            const SizedBox(height: 20),

            // Report hazard screen button
            ElevatedButton.icon(
              icon: const Icon(Icons.warning_amber_rounded),
              label: const Text('Report or View Safety Alerts'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safety Map')),
      body: const Center(
        child: Text(
          '🗺️ Map with hazard zones will appear here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String weather = "Loading...";
  final String apiKey = "1b5be94ed2f7de6b80fc7f58524dac06";
  final double lat = 9.9252; // Example: Madurai
  final double lon = 78.1198;

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  Future<void> getWeather() async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        weather =
            "${data['weather'][0]['main']} | ${data['main']['temp']}°C in ${data['name']}";
      });
    } else {
      setState(() => weather = "Unable to load weather data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Alerts')),
      body: Center(child: Text(weather, style: const TextStyle(fontSize: 18))),
    );
  }
}


class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safety Reports & Alerts')),
      body: const Center(
        child: Text(
          '🚨 Users can report hazards and see nearby alerts here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
