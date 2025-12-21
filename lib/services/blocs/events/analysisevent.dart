import 'package:cross_file/cross_file.dart';

abstract class AnalysisEvent {}

class EmptyAnalysisEvent extends AnalysisEvent {}

class RequestAnalysisEvent extends AnalysisEvent {
  List<XFile>? files;
  String? messages;
  RequestAnalysisEvent({this.files, this.messages});
}
