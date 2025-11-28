

import 'package:file_picker/file_picker.dart';
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
      appBar: EpAppBar(title: "Analyzer",trailing:[
       GestureDetector (
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AuthLoginScreen()));
         },
        child:CircleAvatar(
          child: Icon(Icons.person),
          
        ))]) ,
      body:
      Center(
        child: Text("Upload medical report")),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(onPressed: ()async{
       await FilePickerIO().pickFiles(type: FileType.custom,allowedExtensions: ["png","pdf","jpg","jpeg","csv"]);
      },
      child: Icon(LucideIcons.upload),
    
      
      ),
    );
  }
}