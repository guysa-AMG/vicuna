import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:vicuna/screen/auth/login.dart';
import 'package:vicuna/services/blocs/controllers/authcontroller.dart';
import 'package:vicuna/services/blocs/states/authenticationState.dart';
import 'package:vicuna/widgets/appabar.dart';

class UserIcon extends StatefulWidget {
  const UserIcon({super.key});

  @override
  State<UserIcon> createState() => UserIconState();
}

class UserIconState extends State<UserIcon> {
  @override
  Widget build(BuildContext ctx) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: ctx,
          builder: (context) {
            return BlocBuilder<Authcontroller, Authenticationstate>(
              builder: (context, state) {
                return Dialog(
                  child: Scaffold(
                    appBar: EpAppBar(
                      title: "Account Action",
                      titleSize: 20,
                      trailing: [
                        (state is SuccessFullAuthenticationState)
                            ? Image.network(
                                state.userCred.photoURL ??
                                    "https://cdn-icons-png.flaticon.com/128/10701/10701484.png",
                                fit: BoxFit.fill,
                              )
                            : Icon(LucideIcons.user200),
                      ],
                    ),
                    body: ListView(
                      children: [
                        ListTile(
                          onTap: () {
                            state is SuccessFullAuthenticationState
                                ? ctx.read<Authcontroller>().logOut()
                                : Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctbx) => AuthLoginScreen(),
                                    ),
                                  );
                          },
                          leading: Icon(LucideIcons.logOut200),
                          title: state is SuccessFullAuthenticationState
                              ? Text("SignOut")
                              : Text("Login"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },

      child: BlocBuilder<Authcontroller, Authenticationstate>(
        builder: (context, state) {
          return (state is SuccessFullAuthenticationState)
              ? CircleAvatar(
                  radius: 24,
                  backgroundImage: Image.network(
                    state.userCred.photoURL ??
                        "https://cdn-icons-png.flaticon.com/128/10701/10701484.png",
                  ).image,
                )
              : CircleAvatar(child: Icon(LucideIcons.user200));
        },
      ),
    );
  }
}
