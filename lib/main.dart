import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vicuna/screen/navbar.dart';
import 'package:flutter/material.dart';
import 'package:vicuna/services/blocs/controllers/themeController.dart';
import 'package:vicuna/services/blocs/states/themeState.dart';

void main() {

  runApp(DevicePreview(builder: (ctx)=>BlocProvider(create:(ctx)=>Themecontroller(),
    child:const MyApp())));
   
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    BlocBuilder<Themecontroller,Themestate>(builder: (ctz,state){
   return  MaterialApp(
      title: 'vicuna',
      darkTheme: ThemeData.dark(useMaterial3: true,
        ),
      themeMode: (state == LightTheme())?ThemeMode.light:ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
        
          textTheme: GoogleFonts.robotoTextTheme(),
        colorScheme: .fromSeed(seedColor: const Color(0xFF2563E0)),
      ),
      home:  NavBar(),
    
    
    );});
   
    
  }
}

