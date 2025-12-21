
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/screen/settings/subsettings/about.dart';
import 'package:vicuna/screen/settings/subsettings/preference.dart';
import 'package:vicuna/screen/settings/subsettings/specialistcontact.dart';
import 'package:vicuna/widgets/appabar.dart';
import 'package:vicuna/screen/settings/subsettings/personal;.dart';
import 'package:vicuna/widgets/testscreen.dart';
import 'package:vicuna/widgets/userIcon.dart';

class Settings extends StatefulWidget {
const  Settings({super.key});
  @override
  State<Settings> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  List<Map<String, dynamic>> cards = [
    {
      "title": "Personal",
      "icon": Icon(LucideIcons.filePen),
      "subtitle":
          "view or edit info saved like name,surname,email and any saved medical records",
      "onclick": (ctx) => {
        Navigator.push(
          ctx,
          MaterialPageRoute(builder: (ctx) => PersonalScreen()),
        ),
      },
    },
    {
      "title": "Specialist Contact",
      "icon": Icon(LucideIcons.contact),
      "subtitle":
          "save and edit your professional medical practioner contact info and details",
      "onclick": (ctx) => {
        Navigator.push(
          ctx,
          MaterialPageRoute(builder: (ctx) => SpecialistContactScreen()),
        ),
      },
    },
    {
      "title": "Preference",

      "icon": Icon(LucideIcons.contrast),
      "subtitle":
          "view or edit info saved like name,surname,email and any saved medical records",
      "onclick": (ctx) => {
        Navigator.push(
          ctx,
          MaterialPageRoute(builder: (ctx) => PreferenceScreen()),
        ),
      },
    },

    {
      "title": "About & Policies",
      "icon": Icon(LucideIcons.info),
      "subtitle":
          "view or edit info saved like name,surname,email and any saved medical records",
      "onclick": (ctx) => {
        Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => AboutScreen())),
      },
    },
  ];
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: EpAppBar(title: "Settings", trailing: [UserIcon(), TestIcon()]),
      body: ListView(
        children: cards
            .map(
              (val) => ListTile(
                onTap: () => val["onclick"](ctx),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 9,
                ),
                trailing: Icon(LucideIcons.arrowRight),
                leading: val["icon"],
                title: Text(
                  val["title"],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  val["subtitle"],
                  style: TextStyle(
                    color: Theme.brightnessOf(ctx) == Brightness.light
                        ? Colors.black45
                        : Colors.white54,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
