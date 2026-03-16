import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vicuna/services/blocs/controllers/authcontroller.dart';
import 'package:vicuna/services/blocs/states/authenticationState.dart';
import 'package:vicuna/widgets/InputBox.dart';
import 'package:vicuna/widgets/signon.dart';
import 'package:vicuna/widgets/appabar.dart';
import 'package:flutter/material.dart';

class AuthLoginScreen extends StatefulWidget {
  const AuthLoginScreen({super.key});
  @override
  State<AuthLoginScreen> createState() => AuthLoginScreenState();
}

class AuthLoginScreenState extends State<AuthLoginScreen> {
  @override
  Widget build(BuildContext ctx) {
    return BlocListener<Authcontroller, Authenticationstate>(
      listener: (context, state) {
        if (state is SuccessFullAuthenticationState) {
          Navigator.pop(context);
        }
      },

      child: Scaffold(
        appBar: EpAppBar(title: ""),
        body: BlocListener<Authcontroller, Authenticationstate>(
          listener: (context, state) {
            if (state is ErrorAuthenticationState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(top: 20),
              child: Column(
                spacing: 20,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: Image.asset("assets/logo/logo.png").image,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                      letterSpacing: -1.2,
                      fontWeight: FontWeight.w500,
                      color: Theme.brightnessOf(ctx) == Brightness.light
                          ? Colors.black87
                          : Colors.white70,
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
                          style: TextStyle(
                            color: Theme.brightnessOf(ctx) == Brightness.light
                                ? Colors.black45
                                : Colors.white54,
                          ),
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
                        icon: Icon(
                          Icons.facebook,
                          color: Colors.white,
                          size: 30,
                        ),
                        onclick: () {
                          BlocProvider.of<Authcontroller>(
                            ctx,
                          ).signInWithFacebook();
                        },
                        label: "Continue with Facebook",
                        background: Color(0xff3975EA),
                      ),
                      Text("or"),
                      AuthBtn(
                        icon: Image.asset("assets/logo/google.png", width: 25),
                        onclick: () async {
                          BlocProvider.of<Authcontroller>(
                            ctx,
                          ).signInWithGoogle();
                        },
                        label: "Google",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
