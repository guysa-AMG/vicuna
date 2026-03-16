import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vicuna/services/blocs/controllers/authcontroller.dart';
import 'package:vicuna/widgets/InputBox.dart';
import 'package:vicuna/widgets/signon.dart';
import 'package:vicuna/widgets/appabar.dart';
import 'package:flutter/material.dart';

class AuthSignUpScreen extends StatefulWidget {
  const AuthSignUpScreen({super.key});

  @override
  State<AuthSignUpScreen> createState() => AuthLoginScreenState();
}

class AuthLoginScreenState extends State<AuthSignUpScreen> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: EpAppBar(title: ""),
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(top: 30),
          child: Column(
            spacing: 20,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 30,
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                width: 250,
                child: Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont Have An Account?",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black45),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ),
              EpiInput(label: "email or username"),
              EpiInput(label: "password"),
              Column(
                spacing: 10,
                children: [
                  AuthBtn(
                    icon: Icon(Icons.facebook, color: Colors.white, size: 30),
                    onclick: () {
                      BlocProvider.of<Authcontroller>(ctx).signInWithGoogle();
                    },
                    label: "Continue with Facebook",
                    background: Color(0xff3975EA),
                  ),
                  Text("or"),
                  AuthBtn(
                    icon: Image.asset("assets/logo/google.png", width: 25),
                    onclick: () async {
                      BlocProvider.of<Authcontroller>(ctx).signInWithGoogle();
                    },
                    label: "Google",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
