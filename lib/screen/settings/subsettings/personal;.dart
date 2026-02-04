import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/widgets/appabar.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => PersonalScreenState();
}

class PersonalScreenState extends State<PersonalScreen> {
  List<Map<String, dynamic>> fields = [
    {"name": "name", "icon": Icon(LucideIcons.user300)},
    {"name": "surname", "icon": Icon(LucideIcons.user300)},
    {"name": "email", "icon": Icon(LucideIcons.mail300)},
    {"name": "gender", "icon": Icon(LucideIcons.users200)},
    {"name": "age", "icon": Icon(LucideIcons.bold)},
    {"name": "cellphone", "icon": Icon(LucideIcons.phone300)},
  ];

  @override
  Widget build(BuildContext ctx) {
    double width = MediaQuery.of(ctx).size.width * 0.9;
    return Scaffold(
      appBar: EpAppBar(title: "Personal"),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 30,
          children: [
            ...fields.map((field) {
              return SizedBox(
                width: width,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: field["name"],
                    prefixIcon: field["icon"],
                    border: OutlineInputBorder(),
                  ),
                ),
              );
            }),
            ElevatedButton(onPressed: () {}, child: Text("save")),
          ],
        ),
      ),
    );
  }
}
