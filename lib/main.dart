import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const TimeDecodeApp());
}

class TimeDecodeApp extends StatelessWidget {
  const TimeDecodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String _currentTime = '';
  String _currentMessage = 'Yükleniyor...';

  Map<String, List<String>> minuteMessages = {};

  @override
  void initState() {
    super.initState();
    _loadMessages().then((_) {
      _updateTimeAndMessage();
      Timer.periodic(const Duration(seconds: 1), (timer) {
        _updateTimeAndMessage();
      });
    });
  }

  Future<void> _loadMessages() async {
    final jsonString = await rootBundle.loadString('assets/messages.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    minuteMessages = jsonMap.map((key, value) => MapEntry(key, List<String>.from(value)));
  }

  void _updateTimeAndMessage() {
    final now = DateTime.now();

    final formattedTime = '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}';

    final key = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    final messages = minuteMessages[key] ?? List.filled(12, 'Mesaj bulunamadı');
    final index = now.second ~/ 5;

    setState(() {
      _currentTime = formattedTime;
      _currentMessage = messages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Arka plan (yıldızlı gökyüzü)
          Positioned.fill(
            child: Image.asset(
              'assets/images/stars_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // Sağ üstte yarım ay
          Positioned(
            top: 0,
            right: -30,
            child: Image.asset(
              'assets/images/moon.png',
              width: 150,
              height: 150,
              opacity: const AlwaysStoppedAnimation(0.9),
            ),
          ),

          // Uygulama içeriği
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'TimeDecode',
                  style: GoogleFonts.spaceMono(
                    textStyle: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.white24,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _currentTime,
                  style: GoogleFonts.robotoMono(
                    textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                      color: Colors.cyanAccent,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.deepPurpleAccent,
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    _currentMessage,
                    style: GoogleFonts.spaceMono(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
