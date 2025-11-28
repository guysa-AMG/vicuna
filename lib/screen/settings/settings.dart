

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/widgets/appabar.dart';

class Settings extends StatefulWidget{
  @override
  State<Settings> createState()=>SettingsState();
}

class SettingsState extends State<Settings>{
  List<Map<String,dynamic>> cards=[
    {"title":"myInfo",
    "icon":Icon(LucideIcons.filePen),
    },
    {"title":"specialist Contact",
    "icon":Icon(LucideIcons.contact)
    },
    {"title":"preference",
    "icon":Icon(LucideIcons.contrast)
    },
    {"title":"Terms and Condition",
    "icon":Icon(LucideIcons.settings)
    },
    {"title":"about",
    "icon":Icon(LucideIcons.info)
    }
    ];
  @override
  Widget build(BuildContext ctx){
    return Scaffold(

      appBar: EpAppBar(title: "Settings"),
      body: ListView(
        children: cards.map((val)=>
        ListTile(
          trailing: ,
          leading: val["icon"],
          title: Text(val["title"])
          
          ,)).toList(),
      ),
    );
  }
}