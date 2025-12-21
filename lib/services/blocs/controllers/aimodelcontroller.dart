import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vicuna/services/blocs/states/modelstate.dart';
import 'package:vicuna/services/repository/aimodel.dart';
import 'package:vicuna/services/repository/localpref.dart';

const List<String> ERRORS=["DioException [bad response]: This exception was thrown because the response has a status code of 404 and RequestOptions.validateStatus was configured to throw for this status code.",
];
class LLMController extends Cubit<ModelState> {
  VicunaAi vicai;
  LocalInstance pref;

  LLMController({required this.vicai,required this.pref}) : super(InitModelState());

  bool get ismodelOnDevice  {
    return pref.hasValidLocalModel();
  }

  void loadModel() async {
    if (await vicai.hasModel) {}

    bool res = await vicai.loadModel();
    if (res) {
      emit(ModelLoadedState());
      return;
    } else {

      emit(ErrorLoadingModelState());
      return;
    }
  }
  void validateModel()async{
    
    bool val =await vicai.modelChecksum();
     debugPrint("All Good");
   if(val){
   
    pref.setValidityLocalModel(true);
    emit(ModelLoadedState());
   }
  }
  void pullModel() async {
    debugPrint("Pull initiated !!!!!!!!!!!!!!");
    emit(DownloadingModelState(percentage: 0));

    vicai
        .downloadModel()
        .listen((event) {
          emit(DownloadingModelState(percentage: event));
        }).onError((e)=>{
          if (e.toString().startsWith(ERRORS[0])){
          emit(ErrorLoadingModelState(error: "Server Error 404: Could Not Download Model"))}
          else{
            emit(ErrorLoadingModelState(error: e.toString()))
          }
        });
        bool val =await vicai.modelChecksum();
   if(val){
    pref.setValidityLocalModel(true);
    emit(ModelLoadedState());
   }
   
        
        
        
        
  }
}
