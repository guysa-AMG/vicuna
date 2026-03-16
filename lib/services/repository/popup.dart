


import 'package:flutter/material.dart';

class PopUp{
BuildContext ref;
 PopUp({required this.ref});



  void broadcast(String txt){
   SnackBar snack = SnackBar(content: Text(txt));
    ScaffoldMessenger.of(ref).showSnackBar(snack);
    
  }

}