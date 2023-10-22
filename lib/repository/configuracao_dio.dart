import 'package:dio/dio.dart';

import 'dio_interceptor.dart';

class Back4AppCustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  Back4AppCustomDio() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = "https://parseapi.back4app.com/class";

    _dio.interceptors.add(Back4AppDioInterceptor());
  }
}
