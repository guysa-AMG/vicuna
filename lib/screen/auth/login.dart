

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
      body:SingleChildScrollView(
        child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(top: 30),
        child: Column(

          spacing: 20,
          children: [
            Text("Login",style: TextStyle(fontSize: 30,letterSpacing: 1.2)),
           Container (
            width: 250,
              child: Text("Authenticate with registered email and password or with Auth provider",textAlign: TextAlign.center,style: TextStyle(fontSize: 12,)),
           ),
            EpiInput(label: "email or username"),
            EpiInput(label: "password"),
            Column(
              spacing: 10,
              children: [
                AuthBtn(icon:Image.asset("assets/logo/facebook.png",width: 30,),label: "Facebook",background: Color.fromARGB(255, 22, 130, 231),),
                Text("or"),
                AuthBtn(icon:Image.asset("assets/logo/google.png",width: 30,) ,label: "Google")
            
              ],
            )
           
            

            



          ],

        )),
    ));
  }
}