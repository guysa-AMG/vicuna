import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vicuna/model/report.dart';
import 'package:vicuna/services/blocs/events/analysisevent.dart';
import 'package:vicuna/services/blocs/states/analystate.dart';
import 'package:vicuna/services/repository/analyzer.dart';
import 'package:vicuna/services/repository/localpref.dart';

class QuickAnalysisController extends Bloc<AnalysisEvent, Analystate> {
  Analyzer vicuna;
  LocalInstance prevState;
  QuickAnalysisController({required this.prevState, required this.vicuna})
    : super(InitialAnalysisState()) {
    on<EmptyAnalysisEvent>((event, emit) async {
      String lang = prevState.getLanguage();
      vicuna.setLanguage(lang);
      emit(InitialAnalysisState());
    });

    on<RequestAnalysisEvent>((event, emit) async {
      String lang = prevState.getLanguage();
      vicuna.setLanguage(lang);
      emit(LoadingAnalysisState());

      if (event.files != null || event.messages != null) {
        MedicalReport? report = await vicuna.quickread(event.files!);
        if (report != null) {
          emit(SuccessfulAnalysisState(report: report));
        } else {
          emit(ErroredAnalysisState(message: "Falied to Read Report"));
        }
      } else {
        emit(ErroredAnalysisState(message: "no content found"));
      }
    });
  }
}
