

import 'package:dio/dio.dart';
import 'package:netfilx/core/constants/api_constants.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Content-Type': 'application/json'},
        ),
      ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
         options.headers['Authorization'] =
options.headers['Authorization'] =
    'Bearer ${ApiConstants.accessToken}';          handler.next(options);
        },
      ),
    );
  }
}
