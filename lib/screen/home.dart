

import 'dart:ffi';

import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/screen/auth/login.dart';
import 'package:vicuna/screen/chatbot.dart';
import 'package:vicuna/screen/settings/settings.dart';
import 'package:vicuna/widgets/ChartCard.dart';
import 'package:vicuna/widgets/appabar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{

  @override 
  State<Home> createState()=>HomeState();
}

class HomeState extends State<Home>{
  int screenIndex=0;
  List<Widget> ScreenList=[Text("stats"),Text("Home"),Text("Settings")];
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
      body:
      SingleChildScrollView(
        child: 
      
      Container( height: double.maxFinite,padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: 10,
          children: [
        
              SearchBar(hintText: "How Are you Feeling Today?",trailing: [Icon(LucideIcons.search),SizedBox(width: 15,)],)
              ,
              SizedBox(height: 20,)
            ,
            Row(mainAxisSize: MainAxisSize.max,
            spacing: 10,
            children: [EpiChartCard(title: "Overview",),EpiChartCard(title: "feedback",)],
          ),EpiChartCard(title:"follow throught"),

        
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Navigator.push(context, 
        MaterialPageRoute(builder: (ctx)=>ChatBotScreen()));
      },
      icon: Icon(LucideIcons.botMessageSquare),
      label: Text("vic"),
      
      ),
    );
  }
}