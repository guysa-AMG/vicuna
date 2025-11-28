

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/services/blocs/controllers/themeController.dart';
import 'package:vicuna/widgets/appabar.dart';

class Settings extends StatefulWidget{
  @override
  State<Settings> createState()=>SettingsState();
}

class SettingsState extends State<Settings>{
  List<Map<String,dynamic>> cards=[
    {"title":"Personal",
    "icon":Icon(LucideIcons.filePen),
    "subtitle":"view or edit info saved like name,surname,email and any saved medical records"
    },
    {"title":"Specialist Contact",
    "icon":Icon(LucideIcons.contact),
        "subtitle":"save and edit your professional medical practioner contact info and details"
    },
    {"title":"Preference",
    
    "icon":Icon(LucideIcons.contrast),
        "subtitle":"view or edit info saved like name,surname,email and any saved medical records"
    },
    {"title":"Terms and Condition",
    "icon":Icon(LucideIcons.settings),
        "subtitle":"view or edit info saved like name,surname,email and any saved medical records"
    },
    {"title":"About",
    "icon":Icon(LucideIcons.info),
        "subtitle":"view or edit info saved like name,surname,email and any saved medical records"
    }
    ];
  @override
  Widget build(BuildContext ctx){
    return Scaffold(

      appBar: EpAppBar(title: "Settings",trailing: [CircleAvatar(child: IconButton(onPressed: (){
        ctx.read<Themecontroller>().toggle();
      }, icon: Icon(LucideIcons.moon)),)],),
      body: ListView(
        children: cards.map((val)=>
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical:15,horizontal: 10),
          trailing:Icon(LucideIcons.arrowRight) ,
          leading: val["icon"],
          title: Text(val["title"],style: TextStyle(fontSize: 20,)),
          subtitle:Text(val["subtitle"]),
          
          )).toList(),
      ),
    );
  }
}