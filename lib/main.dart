import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vicuna/screen/navbar.dart';
import 'package:flutter/material.dart';
import 'package:vicuna/services/blocs/controllers/aimodelcontroller.dart';
import 'package:vicuna/services/blocs/controllers/authcontroller.dart';
import 'package:vicuna/services/blocs/controllers/homeviewcontroller.dart';
import 'package:vicuna/services/blocs/controllers/themeController.dart';
import 'package:vicuna/services/blocs/states/themeState.dart';
import 'package:vicuna/services/misc/constants.dart';
import 'package:vicuna/services/repository/aimodel.dart';
import 'package:vicuna/services/repository/analyzer.dart';
import 'package:vicuna/services/repository/authentication.dart';
import 'package:vicuna/services/repository/localpref.dart';
import 'package:vicuna/splash.dart';
import 'package:vicuna/widgets/loading.dart';
import 'firebase_options.dart';

Future<bool> awaitMain(List<Function> lstfunc) async {
  for (var func in lstfunc) {
    await func();
  }
  return true;
}

void main() {
  runApp(
    DevicePreview(
      enabled: false,
      builder: (dctx) => FutureBuilder(
        future: Splash(),
        builder: (BuildContext context, AsyncSnapshot asyncSnap) {
          if (asyncSnap.hasData) {
            return asyncSnap.data;
          }
          return LoadingWidget();
        },
      ),
    ),
  );
}
