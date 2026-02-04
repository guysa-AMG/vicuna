import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalInstance {
  late SharedPreferences inst;
  late String Language;
  Future<void> init() async {
    inst = await SharedPreferences.getInstance();
    Language = (getLanguage()) ;
  }

Future <void> setLanguage(String lang) async {
    Language = lang;
    await inst.setString("Lang", lang);
  }

String  getLanguage() {
    String? res =  inst.getString("Lang")??"English";
    return res;
  }

bool getMode() {
    bool? mode = inst.getBool("isDark")??false;
    return mode;
  }

bool toggleMode() {
    inst.setBool("isDark", !(inst.getBool("isDark") ?? false));
    bool mode = inst.getBool("isDark") ?? false;
    debugPrint(mode.toString());
    return mode;
  }

 bool hasValidLocalModel(){
 return inst.getBool("verified")??false;
 }

 void setValidityLocalModel(bool s)async{
await inst.setBool("verified", s);
 }
}
