import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:vicuna/model/report.dart';

class Analyzer {
  List<XFile> files = [];

  late String targetLanguage;

  void setLanguage(String lang) {
    targetLanguage = lang;
  }

  Future<List<Part>> docPromptPrepare(List<XFile> file) async {
    List<Part> lou = [];

    for (XFile ssfile in file) {
      Uint8List bites = await ssfile.readAsBytes();
      lou.add(Part.bytes(bites));
    }
    return lou;
  }

  Future<MedicalReport?> quickread(List<XFile> files) async {
    this.files = files;
    String userLocation = "Johannesburg";

    String ttprompt =
        '''You are Vicuna, an empathetic AI medical assistant. 
  Analyze the attached medical report for the patient. 
  Target Language: $targetLanguage 
  (If specific location is provided in text: $userLocation, otherwise ignore location).

  Output RULES:
  1. Return ONLY valid, raw JSON. Do not use Markdown (no ```json).
  2. Tone: Professional but reassuring. Speak directly to the patient ("You").
  3. Vocabulary: Use everyday terms. Avoid scary medical jargon.
  4. Accessibility: Explanations must be understandable to all ages (Grade 8 reading level).
  5. Completeness: Include enough detail in 'key_findings' to be used as context later.
  6. If the document is NOT medical, return: {"error": "Not a medical document"}

  JSON SCHEMA (Strictly follow this structure):
  {
     "situation_title": "String (Condition name, e.g., 'Normal Blood Test')",
     "criticality": "String (One of: 'Low', 'Moderate', 'High', 'Critical')",
     "explanation": "String (2-3 sentences, simple $targetLanguage/Target Language explaining the situation)",
     "key_findings": ["String", "String"],
     "next_steps": ["String", "String"],
     "warning_signs": ["String", "String"],
     
     // specific type of specialist needed (e.g., 'Cardiologist'). Return null if none needed.
     "specialist_type": "String or null", 
     
     // Ask a follow-up ONLY if the document is ambiguous. Return null if clear.
     "follow_up_question": "String or null"
  }
  ''';
    List<Part> biterized = await docPromptPrepare(files);

    Candidates? respond = await Gemini.instance.prompt(
      parts: [TextPart(ttprompt), ...biterized.map((ssfile) => ssfile)],
    );
    if (respond != null) {
      List<dynamic> data =
          respond.content?.parts?.map((Part part) {
            return Part.toJson(part);
          }).toList() ??
          [];
      MedicalReport report = data
          .map((res) => MedicalReport.fromJson(res))
          .single;
      debugPrint(report.toString());
      return report;
    }
    return null;
  }
}
