import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0e4194),
      body: Center(
        child: Text(
          "Busan Trip",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}