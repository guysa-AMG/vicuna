

import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/screen/auth/login.dart';
import 'package:vicuna/screen/settings.dart';
import 'package:vicuna/widgets/appabar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{

  @override 
  State<Home> createState()=>HomeState();
}

class HomeState extends State<Home>{
  @override
  Widget build(BuildContext ctx){
    return Scaffold(
      appBar: EpAppBar(title: "Home",trailing:[
       GestureDetector (
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AuthLoginScreen()));
         },
        child:CircleAvatar(
          child: Icon(Icons.person),
          
        ))]) ,
      body: Center(
        child: Text("hi"),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){},
      icon: Icon(LucideIcons.botMessageSquare),
      label: Text("vic"),
      
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          if (value==2){
            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Settings()));
          }
        },
        items: [
        BottomNavigationBarItem(icon: Icon(LucideIcons.chartNoAxesColumnIncreasing),label: "stats"),
         BottomNavigationBarItem(icon: Icon(LucideIcons.house),label: "home"),
          BottomNavigationBarItem(
            
            icon: Icon(LucideIcons.settings),label: "settings"),
      ]),
    );
  }
}