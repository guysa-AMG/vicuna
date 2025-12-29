
abstract class ModelState {}

class InitModelState extends ModelState {}

class LoadingModelState extends ModelState {}

class DownloadingModelState extends ModelState {
  double percentage;
  String? hash;
  DownloadingModelState({required this.percentage,this.hash});
}

class ModelLoadedState extends ModelState {
  String chat;
  ModelLoadedState({required this.chat});
}

class NewContentModelState extends ModelState{
  String cont;
  NewContentModelState({required this.cont});
}
class ErrorLoadingModelState extends ModelState {
  String? error;
  ErrorLoadingModelState({this.error});
}
