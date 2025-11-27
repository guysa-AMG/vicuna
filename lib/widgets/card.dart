


import 'package:flutter/material.dart';

class EpiCard extends StatefulWidget{

  @override 
  State<EpiCard> createState ()=> EpicCardState();
}

class EpicCardState extends State<EpiCard>{

@override
Widget build(BuildContext ctx){
  return Card(
    child: Text("Analytics"),
  );
}
}