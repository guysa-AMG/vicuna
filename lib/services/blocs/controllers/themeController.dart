

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vicuna/services/blocs/states/themeState.dart';

class Themecontroller extends Cubit<Themestate>{
Themecontroller():super(LightTheme());

void toggle(){
state is LightTheme()?emit(DarkTheme()):emit(LightTheme());
}

}