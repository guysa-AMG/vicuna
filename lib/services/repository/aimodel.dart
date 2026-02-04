import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vicuna/services/nativelibs/nathash.dart';

class VicunaAi {
  InferenceModel? model;
  bool isLoaded = false;
  String? modelHash;
  String _serverIp = "http://192.168.100.32:8044";

  String get _urlmodelpath => "$_serverIp/gemma-2b-it-cpu-int4.bin";

  bool get hasModel {
    return FlutterGemma.hasActiveModel();
  }

  @protected
  Future<String> getModelPath() async {
    Directory appdir = await getApplicationDocumentsDirectory();
    String fdir = "${appdir.path}/model.gguf";
    return fdir;
  }

  Future<void> init() async {
    await FlutterGemma.initialize();
  }

  Future<bool> modelChecksum() async {
    String currentHash;
    if (modelHash != null) {
      currentHash = modelHash!;
    } else {
      SharedPreferences shared = await SharedPreferences.getInstance();
      String? hash = shared.getString("checksum");

      if (hash != null) {
        currentHash = hash;
      } else {
        debugPrint("Cached hash: $modelHash}");
        debugPrint("Stored hash :$hash");
        debugPrint("no HASH Indentified");
        return false;
      }
    }
    Directory appdir = await getApplicationDocumentsDirectory();
    String fdir = "${appdir.path}/model.gguf";

    String chash = await Isolate.run(() => CHash.getSHA256(fdir));
    debugPrint("calculated model hash :$chash");
    debugPrint("given model hash :$currentHash");

    return chash == currentHash;
  }

  Future<void> saveHash(String hsh) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString("checksum", hsh);
  }

  Future<bool> isServerUp() async {
    try {
      await Dio().get(_serverIp,options: Options(receiveTimeout: Duration(seconds: 10)));
    } catch (e) {
      return false;
    }
    return true;
  }

  Stream<double> downloadModel1() {
    final controller = StreamController<double>();

    Future<void> startDownload() async {
      Directory appdir = await getApplicationDocumentsDirectory();
      String savePath = "${appdir.path}/model.gguf";

      try {
        Response<dynamic> resp = await Dio().download(
          _urlmodelpath,
          savePath,
          options: Options(responseType: ResponseType.stream),
          onReceiveProgress: (count, total) {
            if (total != -1) {
              controller.add((count / total * 100));
            }
          },
        );

        var og = resp.headers["Content-Disposition"];
        modelHash = og?[0].split('-')[1].split(".")[0];
        debugPrint("HASH == $modelHash");

        if (modelHash != null) {
          await saveHash(modelHash!);
        }

        controller.close();
      } catch (e) {
        debugPrint(e.toString());
        controller.addError(e);
        controller.close();
        rethrow;
      }
    }

    startDownload();
    return controller.stream;
  }

  Stream<double> downloadModel() {
    final controller = StreamController<double>();

    Future<void> startDownload() async {
      Dio().get(_urlmodelpath);

      await FlutterGemma.installModel(
        modelType: ModelType.gemmaIt,
        fileType: ModelFileType.binary,
      ).fromNetwork(_urlmodelpath).withProgress((progress) {
        controller.add((progress.toDouble()));
      }).install();

      controller.close();
    }

    startDownload();

    return controller.stream;
  }

  Future<bool> loadModel() async {
    if (FlutterGemma.hasActiveModel()) {
      model = await FlutterGemma.getActiveModel(
        maxTokens: 1024,
        preferredBackend: PreferredBackend.cpu,
      );
      return true;
    }
    return false;
  }

  Future<String> sendChat(String message) async {
    if (model == null) {
      bool ret = await loadModel();
      if (!ret) {
        return "failed to Load";
      }
    }
    final chat = await model!.createChat();
    var Language = "English";
    var sysPrompt = '''
   1. you are a medical note explainer named Vicuna
   2. you help patients find health information and do not engage in unrelated topics 
   3. only respond if you are 89% sure or state you are not sure
   4.  it short simple,
   5. communicate in $Language''';

    await chat.addQueryChunk(Message.text(text: message, isUser: true));

    TextResponse res = await chat.generateChatResponse() as TextResponse;

    return res.token;
  }
}
