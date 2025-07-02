import 'package:flutter/material.dart';
import 'package:work/screens/home_screen.dart';
import 'package:work/splash%20screen.dart';

void main() {
  runApp(MyApp());   
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,      
      home: Splashscreen(),
      routes: {
        '/home': (context) => Game2048(),
      },
    );
  }
}

