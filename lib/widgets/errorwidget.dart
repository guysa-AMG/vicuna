
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';


class VicErrorWidget extends StatefulWidget{
  dynamic err;
  VicErrorWidget({super.key,required this.err});
  @override
  State<VicErrorWidget> createState()=> VicErrorWidgetState();
}

class VicErrorWidgetState extends State<VicErrorWidget>{

  @override 
  Widget build(BuildContext context){
    debugPrint(super.widget.err);
    return 
    Opacity(
      opacity: 0.5,
      child:Container(
      padding: EdgeInsets.all(100),
      child:
      Column(
        spacing: 20,
        children: [
          Icon(LucideIcons.serverCrash300,size: 80),
Text(super.widget.err,textAlign: TextAlign.center,style: TextStyle( fontSize: 15,fontWeight: FontWeight.w600))
        ],
      )
       
    ));

  }
}