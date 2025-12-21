import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/screen/Stats.dart';
import 'package:vicuna/screen/home.dart';
import 'package:vicuna/screen/miscscreen.dart';
import 'package:vicuna/screen/settings/settings.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int screenIndex = 0;
  List<Widget> ScreenList = [
   MiscScreen()// Home()
    , StatsScreen(), Settings()];
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: ScreenList[screenIndex],

      bottomNavigationBar: NavigationBar(
        indicatorShape: StadiumBorder(),
        selectedIndex: screenIndex,
        onDestinationSelected: (value) {
          setState(() {
            screenIndex = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(LucideIcons.house100),

            selectedIcon: Icon(LucideIcons.house400, fill: 1),
            label: "Home",
          ),

          NavigationDestination(
            selectedIcon: Icon(LucideIcons.chartArea400, fill: 1),
            icon: Icon(LucideIcons.chartArea100),
            label: "stats",
          ),
          NavigationDestination(
            icon: Icon(LucideIcons.settings100),
            selectedIcon: Icon(LucideIcons.settings400, fill: 1),
            label: "settings",
          ),
        ],
      ),
    );
  }
}
