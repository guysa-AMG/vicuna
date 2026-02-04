import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';

class EpiCard extends StatefulWidget {
  const EpiCard({super.key});

  @override
  State<EpiCard> createState() => EpicCardState();
}

class EpicCardState extends State<EpiCard> {
  @override
  Widget build(BuildContext ctx) {
    return Card(child: Text("Analytics"));
  }
}


class Loading extends TextMessage{

   Loading({required super.authorId, required super.id, required super.text});


}