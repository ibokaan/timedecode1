import 'package:flutter/material.dart';
import 'dart:async';
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

  @override
  void initState() {
    super.initState();
    _updateTime();
    Timer.periodic(const Duration(seconds: 1), (timer) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now();
    final formatted = '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}';
    setState(() {
      _currentTime = formatted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF121212), Color(0xFF1E1E2F)], // Daha koyu, sofistike
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Text(
              'TimeDecode',
              style: GoogleFonts.spaceMono(
                textStyle: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w600,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [
                        Color(0xFF8AB4F8), // Soft mavi
                        Color(0xFF4A90E2), // Daha koyu mavi
                      ],
                    ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                  letterSpacing: 2.5,
                  shadows: const [
                    Shadow(
                      color: Color(0xFF2A2A3D),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _currentTime,
              style: GoogleFonts.robotoMono(
                textStyle: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9CA3AF), // Pastel gri ton
                  letterSpacing: 3,
                  height: 1.2,
                  shadows: [
                    Shadow(
                      color: Color(0xFF2A2A3D),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
