

import 'package:flutter/material.dart';

class AuthBtn extends StatefulWidget{
  String label;
  Widget icon;
 AuthBtn({super.key,required this.label,required this.icon});
@override
State<AuthBtn> createState()=> AuthBtnState();
}

class AuthBtnState extends State<AuthBtn>{

  @override
  Widget build(BuildContext ctx){
    double width = MediaQuery.of(ctx).size.width*0.85;
    return SizedBox(
      width: width,
      child:OutlinedButton.icon(onPressed: (){},
            style: ButtonStyle(),
            icon: super.widget.icon,
              label:Text(super.widget.label) )
            );
  }
}