import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/screen/miscscreen.dart';

class TestIcon extends StatefulWidget {
  const TestIcon({super.key});

  @override
  State<TestIcon> createState() => TestIconState();
}

class TestIconState extends State<TestIcon> {
  @override
  Widget build(BuildContext ctx) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ct) => MiscScreen()),
        );
      },

      child: CircleAvatar(child: Icon(LucideIcons.bug200)),
    );
  }
}
