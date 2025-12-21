import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/services/blocs/controllers/themeController.dart';
import 'package:vicuna/services/blocs/states/themeState.dart';
import 'package:vicuna/services/repository/localpref.dart';
import 'package:vicuna/widgets/appabar.dart';

class PreferenceScreen extends StatefulWidget {
  @override
  State<PreferenceScreen> createState() => PreferenceScreenState();
}

class PreferenceScreenState extends State<PreferenceScreen> {
  @override
  Widget build(BuildContext ctx) {
    List<String> lang = [
      "English",
      "isiZulu",
      "Afrikaans",
      "isiXhosa",
      "Sepedi",
      "Tswana",
    ];
    return Scaffold(
      appBar: EpAppBar(title: "Preference"),
      body: ListView(
        children: [
          BlocBuilder<Themecontroller, Themestate>(
            builder: (cttx, state) {
              return ListTile(
                onTap: () => ctx.read<Themecontroller>().toggle(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 9,
                ),
                leading: (state is LightTheme)
                    ? Icon(LucideIcons.sun300)
                    : Icon(LucideIcons.moon300),
                subtitle: (state is LightTheme) ? Text("Light") : Text("Dark"),
                title: Text("Theme", style: TextStyle(fontSize: 18)),
              );
            },
          ),

          ListTile(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (ctax) => StatefulBuilder(
                  builder: (cot, state) {
                    return Scaffold(
                      appBar: EpAppBar(title: "Select Language"),
                      body: ListView(
                        children: lang.map((lan) {
                          return ListTile(
                            selected:
                                ctax.read<LocalInstance>().Language == lan,
                            onTap: () async {
                               await ctax.read<LocalInstance>().setLanguage(lan);
                              setState(() {
                                debugPrint(ctax.read<LocalInstance>().Language);
                              });
                              Navigator.pop(ctax);
                            },
                            title: Text(lan),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              );
            },
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 9),

            leading: Icon(LucideIcons.languages),
            title: Text("Language", style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
