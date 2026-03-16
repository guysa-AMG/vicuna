import 'package:flutter/material.dart';

class AuthBtn extends StatefulWidget {
  String label;
  Widget icon;
  Color background;
  Function? onclick;
  AuthBtn({
    super.key,
    required this.label,
    this.onclick,
    required this.icon,
    this.background = Colors.white,
  });
  @override
  State<AuthBtn> createState() => AuthBtnState();
}

class AuthBtnState extends State<AuthBtn> {
  @override
  Widget build(BuildContext ctx) {
    double width = MediaQuery.of(ctx).size.width * 0.85;
    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        onPressed: () {
          super.widget.onclick != null ? super.widget.onclick!() : () {};
        },
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 10)),
          backgroundColor: WidgetStatePropertyAll(super.widget.background),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(7),
              side: BorderSide(width: 0.6, color: Colors.black45),
            ),
          ),
        ),
        icon: super.widget.icon,
        label: Text(
          super.widget.label,
          style: TextStyle(
            color: super.widget.background != Colors.white
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }
}
