import 'package:dio/dio.dart';

class VariableRepo {
  late Dio dio;
  VariableRepo() {
    dio = Dio();
  }

  //https://vicuna-md-backend.vercel.app/terms-of-use
  //https://vicuna-md-backend.vercel.app/privacy
  //https://vicuna-md-backend.vercel.app/data-deletion-policy

  Future<String> getPrivacy() async {
    Response res = await dio.get(
      "https://vicuna-md-backend.vercel.app/privacy",
    );
    return res.data;
  }

  Future<String> getTerms() async {
    Response res = await dio.get(
      "https://vicuna-md-backend.vercel.app/terms-of-use",
    );
    return res.data;
  }

  Future<String> getDataDeletionPolicy() async {
    Response res = await dio.get(
      "https://vicuna-md-backend.vercel.app/data-deletion-policy",
    );
    return res.data;
  }
}
