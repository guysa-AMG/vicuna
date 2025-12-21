import 'package:flutter/material.dart';

class EpAppBar extends PreferredSize {
  final String title;
  final String? sub;
  final double titleSize;
  final List<Widget>? trailing;

  const EpAppBar({
    super.key,
    required this.title,
    this.titleSize = 24,
    this.sub,
    this.trailing,
    super.preferredSize = const Size.fromHeight(100),
    super.child = const Text(""),
  });

  @override
  PreferredSize build(BuildContext ctx) {
    return PreferredSize(
      preferredSize: super.preferredSize,
      child: AppBar(
        toolbarHeight: 120,
        actionsPadding: EdgeInsets.only(right: 10),
        actions: trailing,
        animateColor: true,

        title: Opacity(
          opacity: 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              sub != null
                  ? Text(sub!, style: TextStyle(fontSize: 14))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
