import 'package:vicuna/model/report.dart';

abstract class Analystate {}

class InitialAnalysisState extends Analystate {}

class LoadingAnalysisState extends Analystate {}

class SuccessfulAnalysisState extends Analystate {
  MedicalReport report;
  SuccessfulAnalysisState({required this.report});
}

class ErroredAnalysisState extends Analystate {
  String message;
  ErroredAnalysisState({required this.message});
}
