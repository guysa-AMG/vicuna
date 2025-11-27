

import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/widgets/InputBox.dart';
import 'package:vicuna/widgets/signon.dart';
import 'package:vicuna/widgets/appabar.dart';
import 'package:flutter/material.dart';

class AuthLoginScreen extends StatefulWidget{

  @override 
  State<AuthLoginScreen> createState()=>AuthLoginScreenState();
}

class AuthLoginScreenState extends State<AuthLoginScreen>{
  @override
  Widget build(BuildContext ctx){
    return Scaffold(
      appBar: EpAppBar(title:"") ,
      body:Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(top: 50),
        child: Column(
          spacing: 50,
          children: [
            Text("Login",style: TextStyle(fontSize: 30)),
           
            EpiInput(label: "email or username"),
            EpiInput(label: "password"),
            Column(
              children: [
                AuthBtn(icon:Image.asset("assets/logo/facebook.png",width: 25,),label: "Facebook"),
                AuthBtn(icon:Image.asset("assets/logo/google.png",width: 25,) ,label: "Google")
            
              ],
            )
           
            

            



          ],

        )),
    );
  }
}