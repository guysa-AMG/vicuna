import 'dart:convert';

import 'package:flutter/foundation.dart';

class MedicalReport {
  final String situationTitle;
  final String criticality;
  final String explanation;
  final List<String> keyFindings;
  final List<String> nextSteps;
  final List<String> warningSigns;
  final String? specialistType;
  final String? followUpQuestion;

  MedicalReport({
    required this.situationTitle,
    required this.criticality,
    required this.explanation,
    required this.keyFindings,
    required this.nextSteps,
    required this.warningSigns,
    this.specialistType,
    this.followUpQuestion,
  });

  factory MedicalReport.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());
    json = jsonDecode(json["text"]);
    return MedicalReport(
      situationTitle: json['situation_title'] ?? 'Analysis Complete',
      criticality: json['criticality'] ?? 'Unknown',
      explanation: json['explanation'] ?? 'No details provided.',
      // Safe list parsing
      keyFindings: List<String>.from(json['key_findings'] ?? []),
      nextSteps: List<String>.from(json['next_steps'] ?? []),
      warningSigns: List<String>.from(json['warning_signs'] ?? []),
      // Handle nulls gracefully
      specialistType: json['specialist_type'],
      followUpQuestion: json['follow_up_question'],
    );
  }
}
