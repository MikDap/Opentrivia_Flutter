import 'package:dio/dio.dart';

class RetrofitHelper {
  static const String baseUrl = "https://opentdb.com/";

  static Dio getDioInstance() {
    final dio = Dio();
    dio.options.baseUrl = baseUrl;
    return dio;
  }
}