import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: .fromSeed(seedColor: const Color.from(alpha: 255, red: 59, green: 130, blue: 246)),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

