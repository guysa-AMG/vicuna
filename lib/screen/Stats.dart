

import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/screen/auth/login.dart';
import 'package:vicuna/screen/chatbot.dart';
import 'package:vicuna/screen/settings/settings.dart';
import 'package:vicuna/widgets/appabar.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget{

  @override 
  State<StatsScreen> createState()=>StatsScreenState();
}

class StatsScreenState extends State<StatsScreen>{
 @override
  Widget build(BuildContext ctx){
    return Scaffold(
      appBar: EpAppBar(title: "StatsScreen",trailing:[
       GestureDetector (
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AuthLoginScreen()));
         },
        child:CircleAvatar(
          child: Icon(Icons.person),
          
        ))]) ,
      body: Text("stats"),
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