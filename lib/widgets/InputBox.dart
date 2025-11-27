

import 'package:flutter/material.dart';

class EpiInput extends StatefulWidget{
  String label;
 EpiInput({super.key,required this.label});
@override
State<EpiInput> createState()=> EpiInputState();
}

class EpiInputState extends State<EpiInput>{

  @override
  Widget build(BuildContext ctx){
    double width = MediaQuery.of(ctx).size.width*0.85;
    return SizedBox(
      width: width,
      child:TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(width: 0.6)),
                label: Text(super.widget.label)
              ),
            )
            );
  }
}