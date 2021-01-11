import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import 'service_manager_interceptors.dart';

class ApiProvider {
  Dio _dio;
  BuildContext context;

  ApiProvider() {
    BaseOptions options;
    options = new BaseOptions(
      receiveTimeout: 30000,
      connectTimeout: 30000,
    );

    _dio = Dio(options);
    _dio.interceptors.add(ServiceMangerInterceptors());
  }

  Dio getInstance() {
    _dio.options.headers.addAll({"Content-Type": "application/json"});
    return _dio;
  }

  Dio getMultipartInstance() {
    _dio.options.headers.addAll({"Content-Type": "multipart/form-data"});
    return _dio;
  }
}
