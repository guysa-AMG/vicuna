import 'package:device_preview/device_preview.dart';
import 'package:vicuna/screen/home.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(DevicePreview(builder: (ctx)=>const MyApp()));
   
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'vicuna',
      
      theme: ThemeData(
          
        colorScheme: .fromSeed(seedColor: const Color(0xFF2563E0)),
      ),
      home:  Home(),
    );
  }
}

