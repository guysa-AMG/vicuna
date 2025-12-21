import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:llama_cpp_dart/llama_cpp_dart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VicunaAi {
  Llama? _llama;
  bool isLoaded = false;
  String? modelHash;
  final String _urlmodelpath = "http://192.168.100.32:8044/models/llama3.2";

  Future<bool> get hasModel async {
    Directory appdir = await getApplicationDocumentsDirectory();
    String fdir = "${appdir.path}/model.gguf";
    await modelChecksum();
    return await File(fdir).exists();
  }

  @protected
  Future<String> getModelPath() async {
    Directory appdir = await getApplicationDocumentsDirectory();
    String fdir = "${appdir.path}/model.gguf";
    if (File(fdir).existsSync()) {
      return fdir;
    } else {
      ByteData mod = await rootBundle.load("assets/model/model.gguf");
      File nfdir = File(fdir);
      await nfdir.writeAsBytes(
        mod.buffer.asUint8List(mod.offsetInBytes, mod.lengthInBytes),
      );
      return fdir;
    }
  }


Future <bool> modelChecksum()async{
  String currentHash;
  if (modelHash!=null) {
    
    currentHash = modelHash!;}
  else{

    SharedPreferences shared= await SharedPreferences.getInstance();
    String? hash =shared.getString("checksum");

    if(hash!=null){currentHash = hash;
    }
    else{
      
      debugPrint("Cached hash: $modelHash}");
      debugPrint("Stored hash :$hash");
      debugPrint("no HASH Indentified");
      return false;}

  }
   Directory appdir = await getApplicationDocumentsDirectory();
   String fdir = "${appdir.path}/model.gguf";

   File modelff=File(fdir);
  
 final modelStream = modelff.openRead();
 final chash = await sha256.bind(modelStream).first;
  
  debugPrint("calculated model hash :${chash.toString()}");
  debugPrint("given model hash :$currentHash");
  
  return chash.toString()==currentHash;


  
}

Future<void> saveHash(String hsh)async{
 SharedPreferences shared= await SharedPreferences.getInstance();
 shared.setString("checksum", hsh);
}
  Stream<double> downloadModel() {
    final controller = StreamController<double>();

    Future<void> startDownload() async {
      Directory appdir = await getApplicationDocumentsDirectory();
      String savePath = "${appdir.path}/model.gguf";

      try {

  
      Response<dynamic> resp=  await Dio().download(
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

        if (modelHash != null){
        await saveHash(modelHash!);}

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

  Future<bool> loadModel() async {
    try {
      String mpath = await getModelPath();

      // nCtx = 2048 is standard. Reduce to 1024 if app crashes on older phones.
      final contextParams = ContextParams()..nCtx = 2048;
      _llama = Llama(mpath, ModelParams(), contextParams);
      isLoaded = true;
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  void dispose() {
    _llama?.dispose();
  }

  Stream<String> sendChat(String message) async* {
    if (isLoaded) {
      _llama!.setPrompt(message);

      await for (final pmt in _llama!.generateText()) {
        yield pmt;
      }
    }
  }
}
