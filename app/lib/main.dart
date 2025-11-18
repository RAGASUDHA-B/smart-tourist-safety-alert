import 'package:flutter/material.dart';

void main() {
  runApp(const SafeTripApp());
}

class SafeTripApp extends StatelessWidget {
  const SafeTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeTrip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}

// ---------------- Splash Screen ----------------
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Text(
          'SafeTrip',
          style: TextStyle(
              color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// ---------------- Login Screen ----------------
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Home Screen ----------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLanguage = 'en';
  final TextEditingController searchController = TextEditingController();

  final List<String> indianCities = [
    'Delhi',
    'Mumbai',
    'Bangalore',
    'Chennai',
    'Kolkata',
    'Hyderabad',
    'Pune',
    'Jaipur',
    'Lucknow',
    'Ahmedabad'
  ];

  final Map<String, Map<String, String>> translations = {
    'en': {
      'title': 'SafeTrip Home',
      'search': 'Search destination...',
      'mode': 'Select Mode of Alert',
      'sms': 'SMS Alert',
      'voice': 'Voice Assistant',
      'notification': 'Notification',
      'alert': 'Alert Triggered!',
    },
    'ta': {
      'title': 'பாதுகாப்பான பயணம்',
      'search': 'இலக்கை தேடவும்...',
      'mode': 'எச்சரிக்கை முறை தேர்வு',
      'sms': 'எஸ்எம்எஸ் எச்சரிக்கை',
      'voice': 'குரல் உதவியாளர்',
      'notification': 'அறிவிப்பு',
      'alert': 'எச்சரிக்கை செயல்படுத்தப்பட்டது!',
    },
    'hi': {
      'title': 'सुरक्षित यात्रा',
      'search': 'गंतव्य खोजें...',
      'mode': 'चेतावनी मोड चुनें',
      'sms': 'एसएमएस चेतावनी',
      'voice': 'वॉयस असिस्टेंट',
      'notification': 'सूचना',
      'alert': 'चेतावनी सक्रिय!',
    },
    'fr': {
      'title': 'Voyage Sûr',
      'search': 'Rechercher une destination...',
      'mode': 'Sélectionner le mode d\'alerte',
      'sms': 'Alerte SMS',
      'voice': 'Assistant vocal',
      'notification': 'Notification',
      'alert': 'Alerte déclenchée!',
    },
  };

  void triggerAlert(String mode) {
    final t = translations[selectedLanguage]!;
    String alertMessage = t['alert']!;
    String emoji = mode == 'voice'
        ? '🔊'
        : mode == 'sms'
            ? '📩'
            : '🔔';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$emoji $alertMessage')),
    );
  }

  void changeLanguage(String lang) {
    setState(() {
      selectedLanguage = lang;
    });
  }

  void handleSearch(String value) {
    String city = indianCities.firstWhere(
      (c) => value.toLowerCase().contains(c.toLowerCase()),
      orElse: () => '',
    );

    if (city.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => RiskInfoScreen(city: city)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Destination is outside India!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = translations[selectedLanguage]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t['title']!),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: changeLanguage,
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'en', child: Text('English')),
              const PopupMenuItem(value: 'ta', child: Text('தமிழ்')),
              const PopupMenuItem(value: 'hi', child: Text('हिन्दी')),
              const PopupMenuItem(value: 'fr', child: Text('Français')),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: t['search'],
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
              ),
              onSubmitted: handleSearch,
            ),
            const SizedBox(height: 20),

            // Alert Mode
            Text(t['mode']!, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.sms),
              onPressed: () => triggerAlert('sms'),
              label: Text(t['sms']!),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.record_voice_over),
              onPressed: () => triggerAlert('voice'),
              label: Text(t['voice']!),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.notifications),
              onPressed: () => triggerAlert('notification'),
              label: Text(t['notification']!),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Risk Info Screen ----------------
class RiskInfoScreen extends StatelessWidget {
  final String city;
  const RiskInfoScreen({super.key, required this.city});

  Map<String, List<Map<String, String>>> getRiskData() {
    return {
      'Delhi': [
        {
          'title': 'Traffic Accident',
          'date': '2025-11-01',
          'image':
              'https://images.unsplash.com/photo-1570129477492-45c003edd2be?fit=crop&w=600&q=60',
          'description': 'Multi-vehicle collision on NH 44.'
        },
        {
          'title': 'Air Pollution Alert',
          'date': '2025-11-05',
          'image':
              'https://images.unsplash.com/photo-1606761562352-365a68a4143e?fit=crop&w=600&q=60',
          'description': 'Air quality reached hazardous levels.'
        },
      ],
      'Mumbai': [
        {
          'title': 'Flood Warning',
          'date': '2025-10-28',
          'image':
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fit=crop&w=600&q=60',
          'description': 'Heavy rainfall caused waterlogging.'
        },
        {
          'title': 'Building Collapse',
          'date': '2025-11-03',
          'image':
              'https://images.unsplash.com/photo-1581091215367-4fc41759f3f3?fit=crop&w=600&q=60',
          'description': 'Old building collapsed in central Mumbai.'
        },
      ],
      'Bangalore': [
        {
          'title': 'Cyber Crime Alert',
          'date': '2025-11-02',
          'image':
              'https://images.unsplash.com/photo-1590608897129-79d14cbdc74f?fit=crop&w=600&q=60',
          'description': 'Phishing scams reported in IT hubs.'
        },
      ],
      'Chennai': [
        {
          'title': 'Flood Warning',
          'date': '2025-10-30',
          'image':
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fit=crop&w=600&q=60',
          'description': 'Low-lying areas waterlogged due to rain.'
        },
      ],
      'Kolkata': [
        {
          'title': 'Fire Incident',
          'date': '2025-11-04',
          'image':
              'https://images.unsplash.com/photo-1596326898227-3a0d17f8f1b5?fit=crop&w=600&q=60',
          'description': 'Warehouse fire in central Kolkata.'
        },
      ],
      'Hyderabad': [
        {
          'title': 'Traffic Accident',
          'date': '2025-11-01',
          'image':
              'https://images.unsplash.com/photo-1570129477492-45c003edd2be?fit=crop&w=600&q=60',
          'description': 'Collision near highway 65.'
        },
      ],
      'Pune': [
        {
          'title': 'Water Supply Issue',
          'date': '2025-11-06',
          'image':
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fit=crop&w=600&q=60',
          'description': 'Pipeline maintenance disrupting supply.'
        },
      ],
      'Jaipur': [
        {
          'title': 'Construction Accident',
          'date': '2025-11-07',
          'image':
              'https://images.unsplash.com/photo-1581091215367-4fc41759f3f3?fit=crop&w=600&q=60',
          'description': 'Scaffolding collapsed at construction site.'
        },
      ],
      'Lucknow': [
        {
          'title': 'Flood Warning',
          'date': '2025-11-03',
          'image':
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fit=crop&w=600&q=60',
          'description': 'Waterlogging reported after heavy rain.'
        },
      ],
      'Ahmedabad': [
        {
          'title': 'Heatwave Alert',
          'date': '2025-11-05',
          'image':
              'https://images.unsplash.com/photo-1509228627152-2f21e63aa8c7?fit=crop&w=600&q=60',
          'description': 'Temperature crossed 45°C, stay hydrated.'
        },
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final riskData = getRiskData();
    final List<Map<String, String>> cityRisks = riskData[city] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text('Risks in $city')),
      body: cityRisks.isEmpty
          ? const Center(child: Text('No risk data available'))
          : ListView.builder(
              itemCount: cityRisks.length,
              itemBuilder: (context, index) {
                final item = cityRisks[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        item['image']!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item['title']!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(item['description']!),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Date: ${item['date']}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}