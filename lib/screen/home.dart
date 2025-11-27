

import 'package:vicuna/screen/auth/login.dart';
import 'package:vicuna/widgets/appabar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{

  @override 
  State<Home> createState()=>HomeState();
}

class HomeState extends State<Home>{
  @override
  Widget build(BuildContext ctx){
    return Scaffold(
      appBar: EpAppBar(title: "Home",trailing:[
       GestureDetector (
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AuthLoginScreen()));
         },
        child:CircleAvatar(
          child: Icon(Icons.person),
          
        ))]) ,
      body: Center(
        child: Text("hi"),
      ),
    );
  }
}