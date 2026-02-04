import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/screen/chatbot.dart';
import 'package:vicuna/widgets/appabar.dart';
import 'package:flutter/material.dart';
import 'package:vicuna/widgets/userIcon.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => StatsScreenState();
}

class StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: EpAppBar(title: "Record", trailing: [UserIcon()]),
      body: Center(
        child: Opacity(
          opacity: 0.6,
          child: Text(
            "no previous \nhistory",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => ChatBotScreen()),
          );
        },
        child: Icon(LucideIcons.botMessageSquare300),
      ),
    );
  }
}
