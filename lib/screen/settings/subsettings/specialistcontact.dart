import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/widgets/appabar.dart';

class SpecialistContactScreen extends StatefulWidget {
  const SpecialistContactScreen({super.key});

  @override
  State<SpecialistContactScreen> createState() =>
      SpecialistContactScreenState();
}

class SpecialistContactScreenState extends State<SpecialistContactScreen> {
  List<Map<String, dynamic>> fields = [
    {"name": "name", "icon": Icon(LucideIcons.user300)},
    {"name": "company/organization", "icon": Icon(LucideIcons.building200)},
    {"name": "email", "icon": Icon(LucideIcons.mail300)},
    {"name": "telephone", "icon": Icon(LucideIcons.phone200)},
    {"name": "address1", "icon": Icon(LucideIcons.locate200)},
    {"name": "addres2", "icon": Icon(LucideIcons.locate200)},
  ];

  @override
  Widget build(BuildContext ctx) {
    double width = MediaQuery.of(ctx).size.width * 0.9;
    return Scaffold(
      appBar: EpAppBar(title: "Specialist Contact"),
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
