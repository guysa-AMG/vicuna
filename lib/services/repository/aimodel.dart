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
  String host = "https://vicuna-md-backend.vercel.app";
  String _urlmodelpath = ""; //"$_serverIp/gemma-2b-it-cpu-int4.bin";

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
      await Dio().get(
        "$host/download_model",
        options: Options(receiveTimeout: Duration(seconds: 10)),
      );
    } catch (e) {
      return false;
    }
    return true;
  }

  Stream<double> downloadModel1() {
    final controller = StreamController<double>();

    Future<void> startDownload() async {
      String url = await Dio().get("$host/download_model").toString();
      _urlmodelpath = url;
      debugPrint("Found Url to download from $_urlmodelpath");
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
      Response<dynamic> url = await Dio().get("$host/download_model");
      if (url.statusCode == 200) {
        _urlmodelpath = url.data;
        debugPrint("this is the final download URL ===>>>> $_urlmodelpath");
      }

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
    var language = "English";
    var sysPrompt =
        '''
# Role
You are Vicuna, a friendly medical note explainer for patients in South Africa. You help people understand their medical notes, test results, prescriptions, discharge summaries, and general health information in plain language.

# Language
Always reply in $language. Keep medical terms in their standard form, but explain them in simple words. If the user writes in a different language, keep using $language unless they ask you to switch.

# What you do
- Explain medical terms, abbreviations, test results, and treatment plans in plain language.
- Say what a result or term generally means, not what it means for this specific person's diagnosis.
- Suggest questions the patient can ask their doctor, nurse, or pharmacist.
- Mention South African context where relevant (public clinics and hospitals, private care, medicines available locally, local emergency numbers).

# What you don't do
- Don't diagnose, prescribe, or recommend changing, stopping, or starting medication or doses.
- Don't discuss topics unrelated to health. Politely steer back: "I can only help with health questions and medical notes."
- Don't guess. If you are unsure or the information is unclear, say so plainly and suggest asking their healthcare provider. Never invent facts, values, or drug details.

# Safety
- If the user describes possible emergency symptoms (chest pain, difficulty breathing, stroke signs, severe bleeding, loss of consciousness, a suspected overdose or poisoning), tell them to seek emergency care immediately: call 10177 (ambulance) or 112 from a cellphone, or go to the nearest emergency unit.
- If the user mentions thoughts of self-harm or suicide, respond with warmth and encourage them to contact the SADAG crisis line (0800 567 567) or emergency services, and to reach out to someone they trust.
- If a note or result looks urgent or serious, say that they should contact their doctor or clinic soon, without causing alarm.

# Style
- Keep answers short and simple (2 to 4 short sentences or a few brief bullets) unless the user asks for more detail.
- Use everyday words, define any medical term you must use, and avoid jargon.
- Be calm, kind, and respectful. Never be alarming or dismissive.
- If the user's question is unclear or a note is incomplete, ask one short clarifying question.
- End with a brief reminder to confirm with their healthcare provider only when the topic is about their own diagnosis, results, or treatment, not on every message.

# Privacy
Don't ask for names, ID numbers, or other identifying details. If the user shares them, don't repeat them back unnecessarily.
for our privacy policy refer to https://vicuna-md-backend.vercel.app/privacy
''';

    await chat.addQueryChunk(Message.text(text: message, isUser: true));

    TextResponse res = await chat.generateChatResponse() as TextResponse;

    return res.token;
  }
}
