import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vicuna/services/blocs/states/modelstate.dart';
import 'package:vicuna/services/repository/aimodel.dart';
import 'package:vicuna/services/repository/localpref.dart';

const List<String> ERRORS = [
  "DioException [bad response]: This exception was thrown because the response has a status code of 404 and RequestOptions.validateStatus was configured to throw for this status code.",
];

class LLMController extends Cubit<ModelState> {
  VicunaAi vicai;
  LocalInstance pref;

  LLMController({required this.vicai, required this.pref})
    : super(InitModelState());

  bool get ismodelOnDevice {
    return vicai.hasModel;
  }

  void loadModel() async {
    if (vicai.hasModel) {}

    bool res = await vicai.loadModel();
    if (res) {
      emit(ModelLoadedState(chat: ""));
      return;
    } else {
      emit(ErrorLoadingModelState());
      return;
    }
  }

  Future<void> sendChat(String message) async {
    emit(LoadingModelState());

    String response = await vicai.sendChat(message);

    emit(NewContentModelState(cont: response));
  }

  void pullModel() async {
    debugPrint("Pull initiated !!!!!!!!!!!!!!");
    emit(DownloadingModelState(percentage: 0));
    bool serverStatus = await vicai.isServerUp();
    if (serverStatus) {
      try {
        Future<dynamic> data = await vicai
            .downloadModel()
            .listen((event) {
              emit(DownloadingModelState(percentage: event));
            })
            .asFuture()
            .onError(
              (e, _) => {
                if (e.toString().startsWith(ERRORS[0]))
                  {
                    emit(
                      ErrorLoadingModelState(
                        error: "Server Error 404: Could Not Download Model",
                      ),
                    ),
                  }
                else
                  {emit(ErrorLoadingModelState(error: e.toString()))},
              },
            );
        emit(ModelLoadedState(chat: ""));
      } catch (socketExp) {
        print("ERRRRROR: " + socketExp.toString());
      }
    } else {
      emit(ErrorLoadingModelState(error: "Server is not reachable."));
    }

    //bool val =await vicai.modelChecksum();
  }
}
