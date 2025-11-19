import 'package:flutter/material.dart';

void main() {
  runApp(const SafeTripApp());
}

// ---------------- SafeTrip App ----------------
class SafeTripApp extends StatelessWidget {
  const SafeTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeTrip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AuthScreen(),
    );
  }
}

// ---------------- Authentication Screen ----------------
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true; // toggle between sign up & login
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Map<String, String> accounts = {}; // simple in-memory user store

  void authenticate() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter username & password")));
      return;
    }

    if (isLogin) {
      // login
      if (accounts[username] == password) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen(user: username)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid credentials")));
      }
    } else {
      // sign up
      accounts[username] = password;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account created! Please login")));
      setState(() {
        isLogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fit=crop&w=900&q=60',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black45), // dark overlay for text readability
          SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Text(
                  isLogin ? "Login" : "Sign Up",
                  style: const TextStyle(
                      fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      labelText: 'Username', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: authenticate,
                    child: Text(isLogin ? "Login" : "Sign Up")),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(isLogin
                        ? "Don't have an account? Sign Up"
                        : "Already have an account? Login"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Home Screen ----------------
class HomeScreen extends StatefulWidget {
  final String user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLanguage = 'en';
  final TextEditingController searchController = TextEditingController();
  final List<String> recentSearches = [];

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
      'mode': 'Select Alert Mode',
      'sms': 'SMS Alert',
      'voice': 'Voice Assistant',
      'notification': 'Notification',
      'alert': 'Alert Triggered!',
      'recent': 'Recent Searches',
      'tourist': 'Tourist Places',
      'emergency': 'Emergency Contacts',
      'history': 'Recent Alerts',
      'intro': 'SafeTrip helps tourists stay aware of safety alerts and contact local authorities in emergencies.',
    },
    'ta': {
      'title': 'பாதுகாப்பான பயணம்',
      'search': 'இலக்கை தேடவும்...',
      'mode': 'எச்சரிக்கை முறை தேர்வு',
      'sms': 'எஸ்எம்எஸ் எச்சரிக்கை',
      'voice': 'குரல் உதவியாளர்',
      'notification': 'அறிவிப்பு',
      'alert': 'எச்சரிக்கை செயல்படுத்தப்பட்டது!',
      'recent': 'சமீபத்திய தேடல்கள்',
      'tourist': 'பரபரப்பான இடங்கள்',
      'emergency': 'அவசர தொடர்புகள்',
      'history': 'சமீபத்திய எச்சரிக்கைகள்',
      'intro': 'SafeTrip பயணிகளை பாதுகாப்பு எச்சரிக்கைகள் மற்றும் அவசர தொடர்புகளுக்கு அறிய உதவுகிறது.',
    },
  };

  final List<Map<String, dynamic>> alertModes = [
    {'icon': Icons.sms, 'color': Colors.green, 'label': 'SMS Alert'},
    {'icon': Icons.record_voice_over, 'color': Colors.blue, 'label': 'Voice Assistant'},
    {'icon': Icons.notifications, 'color': Colors.orange, 'label': 'Notification'},
  ];

  final List<Map<String, String>> touristPlaces = [
    {
      'name': 'Taj Mahal',
      'image':
          'https://images.unsplash.com/photo-1509228627152-2f21e63aa8c7?fit=crop&w=400&q=60'
    },
    {
      'name': 'India Gate',
      'image':
          'https://images.unsplash.com/photo-1549887534-07a1a5cde434?fit=crop&w=400&q=60'
    },
    {
      'name': 'Gateway of India',
      'image':
          'https://images.unsplash.com/photo-1505691723518-34c9c2ef111d?fit=crop&w=400&q=60'
    },
  ];

  final Map<String, List<Map<String, String>>> pastAlerts = {
    'Delhi': [
      {'title': 'Flood Alert', 'date': '2025-11-18'},
      {'title': 'Rain Alert', 'date': '2025-11-17'},
    ],
    'Mumbai': [
      {'title': 'Earthquake Alert', 'date': '2025-11-18'},
      {'title': 'Flood Alert', 'date': '2025-11-17'},
    ],
  };

  final Map<String, List<Map<String, String>>> authorities = {
    'Delhi': [
      {
        'name': 'John Smith',
        'position': 'Police Commissioner',
        'contact': '+91-1234567890',
        'image':
            'https://randomuser.me/api/portraits/men/1.jpg'
      }
    ],
    'Mumbai': [
      {
        'name': 'Rita Sharma',
        'position': 'Emergency Officer',
        'contact': '+91-9876543210',
        'image':
            'https://randomuser.me/api/portraits/women/2.jpg'
      }
    ],
  };

  void triggerAlert(String mode) {
    final t = translations[selectedLanguage]!;
    String alertMessage = t['alert']!;
    String emoji = mode == 'Voice Assistant'
        ? '🔊'
        : mode == 'SMS Alert'
            ? '📩'
            : '🔔';
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$emoji $alertMessage')));
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
      if (!recentSearches.contains(city)) recentSearches.add(city);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => RiskInfoScreen(city: city)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Destination is outside India!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = translations[selectedLanguage]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('${t['title']} - ${widget.user}'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const AuthScreen()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fit=crop&w=900&q=60',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(color: Colors.black38),
          SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t['intro']!,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: t['search'],
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.search),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  onSubmitted: handleSearch,
                ),
                const SizedBox(height: 15),
                if (recentSearches.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t['recent']!,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: recentSearches
                              .map((city) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: ActionChip(
                                        label: Text(city),
                                        onPressed: () => handleSearch(city)),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                Text(t['tourist']!,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: touristPlaces
                        .map((place) =>
                            TouristCard(imageUrl: place['image']!, place: place['name']!))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 15),
                Text(t['history']!,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ...pastAlerts.entries.map((entry) {
                  return Card(
                    color: Colors.white70,
                    child: ListTile(
                      title: Text('${entry.key} Alerts'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: entry.value
                            .map((alert) => Text('${alert['date']}: ${alert['title']}'))
                            .toList(),
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: alertModes.map((mode) {
            return IconButton(
              icon: Icon(mode['icon'], color: mode['color']),
              onPressed: () => triggerAlert(mode['label'] as String),
              iconSize: 30,
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ---------------- Tourist Card ----------------
class TouristCard extends StatelessWidget {
  final String imageUrl;
  final String place;
  const TouristCard({super.key, required this.imageUrl, required this.place});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: 150,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imageUrl, height: 100, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(place, textAlign: TextAlign.center),
            )
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
        {'title': 'Flood Alert', 'date': '2025-11-18', 'image': 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?fit=crop&w=600&q=60', 'description': 'Heavy rain caused waterlogging.'},
        {'title': 'Air Pollution Alert', 'date': '2025-11-17', 'image': 'https://images.unsplash.com/photo-1606761562352-365a68a4143e?fit=crop&w=600&q=60', 'description': 'Air quality reached hazardous levels.'},
      ],
      'Mumbai': [
        {'title': 'Earthquake Alert', 'date': '2025-11-18', 'image': 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?fit=crop&w=600&q=60', 'description': 'Minor tremors reported.'},
        {'title': 'Flood Alert', 'date': '2025-11-17', 'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fit=crop&w=600&q=60', 'description': 'Waterlogging in low-lying areas.'},
      ],
      'chennai': [
        {'title': 'Flood Alert', 'date': '2025-11-17', 'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fit=crop&w=600&q=60', 'description': 'Waterlogging in low-lying areas.'},
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

