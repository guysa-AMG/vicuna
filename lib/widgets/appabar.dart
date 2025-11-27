

import 'package:flutter/material.dart';

class EpAppBar extends PreferredSize{
 final String title;
 final List<Widget>? trailing;

  const EpAppBar({super.key, required this.title,this.trailing, super.preferredSize= const Size.fromHeight(100),  super.child=const Text("")});

  @override
  PreferredSize build(BuildContext ctx){
    return PreferredSize(
      preferredSize:super.preferredSize ,
      child: AppBar(
        toolbarHeight: 150,
        actionsPadding: EdgeInsets.only(right: 10),
        actions: trailing,
      title: Text(title,style: TextStyle(fontSize: 30,fontWeight:FontWeight.w500 ),),
    ));
      
  }
}