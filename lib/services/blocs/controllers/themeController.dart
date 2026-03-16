import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vicuna/services/blocs/states/themeState.dart';
import 'package:vicuna/services/repository/localpref.dart';

class Themecontroller extends Cubit<Themestate> {
  late LocalInstance pref;
  Themecontroller() : super(LightTheme()) {
    initial();
  }

  Future<void> initial() async {
    pref = LocalInstance();
    await pref.init();
    pref.getMode() ? emit(DarkTheme()) : emit(LightTheme());
  }

  void toggle() async {
    pref.toggleMode();
    if (state is LightTheme) {
      debugPrint("Darkmode Activated");
      emit(DarkTheme());
    } else {
      debugPrint("Lightmode Activated");
      emit(LightTheme());
    }
  }
}
