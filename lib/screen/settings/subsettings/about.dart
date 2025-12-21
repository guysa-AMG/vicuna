import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/services/repository/variablerep.dart';
import 'package:vicuna/widgets/appabar.dart';
import 'package:vicuna/widgets/loading.dart';
import 'package:local_auth/local_auth.dart';

class AboutScreen extends StatefulWidget {
  @override
  State<AboutScreen> createState() => AboutScreenState();
}

class AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext ctx) {
    LocalAuthentication loth = LocalAuthentication();
    List<Map<String, dynamic>> cards = [
      {
        "title": "Terms and Condition",
        "icon": Icon(LucideIcons.settings),
        "subtitle":
            "view or edit info saved like name,surname,email and any saved medical records",
        "onclick": (ctx) => {
          showAdaptiveDialog(
            context: ctx,
            builder: (ctx) {
              return Dialog.fullscreen(
                child: Scaffold(
                  appBar: EpAppBar(title: "Term's of use"),
                  body: FutureBuilder(
                    future: VariableRepo().getTerms(),
                    builder: (ctv, state) {
                      if (state.hasData) {
                        return SingleChildScrollView(
                          child: Html(data: state.data!),
                        );
                      }
                      return LoadingWidget();
                    },
                  ),
                ),
              );
            },
          ),
        },
      },
      {
        "title": "Privacy",
        "icon": Icon(LucideIcons.settings),
        "subtitle":
            "view or edit info saved like name,surname,email and any saved medical records",
        "onclick": (ctx) => {
          showAdaptiveDialog(
            context: ctx,
            builder: (ctx) {
              return Dialog.fullscreen(
                child: Scaffold(
                  appBar: EpAppBar(title: "Privacy"),
                  body: FutureBuilder(
                    future: VariableRepo().getPrivacy(),
                    builder: (ctv, state) {
                      if (state.hasData) {
                        return SingleChildScrollView(
                          child: Html(data: state.data!),
                        );
                      }
                      return LoadingWidget();
                    },
                  ),
                ),
              );
            },
          ),
        },
      },
      {
        "title": "My Data",
        "icon": Icon(LucideIcons.settings),
        "subtitle": "Download all data recorded my Vicuna  ",
        "onclick": (ctx) async {
          bool didAuth = await loth.authenticate(
            localizedReason: "Please Sign in to continue",
          );
          didAuth
              ? showAdaptiveDialog(
                  context: ctx,
                  builder: (ctx) {
                    return Dialog.fullscreen(
                      child: Scaffold(
                        appBar: EpAppBar(title: "Privacy"),
                        body: FutureBuilder(
                          future: VariableRepo().getPrivacy(),
                          builder: (ctv, state) {
                            if (state.hasData) {
                              return SingleChildScrollView(
                                child: Html(data: state.data!),
                              );
                            }
                            return LoadingWidget();
                          },
                        ),
                      ),
                    );
                  },
                )
              : null;
        },
      },
      {
        "title": "Data Deletion",
        "icon": Icon(LucideIcons.settings),
        "subtitle":
            "view or edit info saved like name,surname,email and any saved medical records",
        "onclick": (ctx) => {
          showAdaptiveDialog(
            context: ctx,
            builder: (ctx) {
              return Dialog.fullscreen(
                child: Scaffold(
                  appBar: EpAppBar(title: "Data Deletion Policy"),
                  body: FutureBuilder(
                    future: VariableRepo().getDataDeletionPolicy(),
                    builder: (ctv, state) {
                      if (state.hasData) {
                        return SingleChildScrollView(
                          child: Html(data: state.data!),
                        );
                      }
                      return LoadingWidget();
                    },
                  ),
                ),
              );
            },
          ),
        },
      },
    ];

    return Scaffold(
      appBar: EpAppBar(title: "About"),

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
