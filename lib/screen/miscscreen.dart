import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vicuna/services/blocs/controllers/aimodelcontroller.dart';
import 'package:vicuna/widgets/prodloader.dart';

class MiscScreen extends StatefulWidget {
  @override
  State<MiscScreen> createState() => MiscScreenState();
}

class MiscScreenState extends State<MiscScreen> {
  
  @override
  Widget build(BuildContext ctx) {
        ctx.read<LLMController>().validateModel();
    return
     Scaffold(
      body: DeterminedLoadingWidget(value: 10));
  }
}
