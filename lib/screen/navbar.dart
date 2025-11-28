

import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/screen/Stats.dart';
import 'package:vicuna/screen/auth/login.dart';
import 'package:vicuna/screen/chatbot.dart';
import 'package:vicuna/screen/home.dart';
import 'package:vicuna/screen/settings/settings.dart';
import 'package:vicuna/widgets/appabar.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget{

  @override 
  State<NavBar> createState()=>NavBarState();
}

class NavBarState extends State<NavBar>{
  int screenIndex=1;
  List<Widget> ScreenList=[StatsScreen(),Home(),Settings()];
  @override
  Widget build(BuildContext ctx){
    return Scaffold(
     
      body: ScreenList[screenIndex],
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Navigator.push(context, 
        MaterialPageRoute(builder: (ctx)=>ChatBotScreen()));
      },
      icon: Icon(LucideIcons.botMessageSquare),
      label: Text("vic"),
      
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: screenIndex,
        onTap: (value) {
          setState(() {
            screenIndex=value;
          });
        },
        items: [
        BottomNavigationBarItem(icon: Icon(LucideIcons.chartNoAxesColumnIncreasing),label: "stats"),
         BottomNavigationBarItem(icon: Icon(LucideIcons.house),label: "Home"),
          BottomNavigationBarItem(
            
            icon: Icon(LucideIcons.settings),label: "settings"),
      ]),
    );
  }
}