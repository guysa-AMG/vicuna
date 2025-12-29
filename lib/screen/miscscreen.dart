import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:vicuna/services/blocs/controllers/aimodelcontroller.dart';
import 'package:vicuna/services/repository/aimodel.dart';
import 'package:vicuna/widgets/loading.dart';
import 'package:vicuna/widgets/prodloader.dart';

class MiscScreen extends StatefulWidget {
  @override
  State<MiscScreen> createState() => MiscScreenState();
}

class MiscScreenState extends State<MiscScreen> {
  
late Future<bool> loaded;

  @override
  void initState() {
    // TODO: implement initState
    loaded=context.read<VicunaAi>().loadModel();
    super.initState();
  }
  @override
  Widget build(BuildContext ctx) {


    return
     Scaffold(
      body:
      
      
      FutureBuilder(future: loaded,
       builder: (cont,snapss){
  if (snapss.hasError){
    return Text(snapss.error.toString());
  }
if (snapss.hasData){
  if (snapss.data!)
{
return FutureBuilder(future: ctx.read<VicunaAi>().sendChat("Hello"),
       builder: (cont,snap){
  if (snap.hasError){
    return Text(snap.error.toString());
  }
if (snap.hasData){
  return Text(snap.data!);
}
return LoadingWidget();
       });}}
       
       return LoadingWidget();
       })
       );
  }
}
