import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:visit_doctor/core/network/endpoint.dart';

class CustomDio {
  late Dio _dio;

  Dio get instance => _dio;

  CustomDio() {
    _dio = Dio();

    _dio.options.baseUrl = Endpoint.baseUrlViaCep;
    _dio.options.connectTimeout = const Duration(milliseconds: 100000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 100000);

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');

        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        return handler.next(response);
      },
      onError: (e, handler) {
        debugPrint('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
        return handler.next(e);
      },
    ));
  }
}
