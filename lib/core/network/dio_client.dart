import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/api_constants.dart';
import '../errors/exceptions.dart';

part 'dio_client.g.dart';

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  dio.interceptors.add(const _ErrorInterceptor());

  return dio;
}

class _ErrorInterceptor extends Interceptor {
  const _ErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        throw const NetworkException(
          message:
              'Connection timed out. Please check your internet connection.',
        );
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode ?? 500;
        final message =
            err.response?.statusMessage ??
            'An unexpected server error occurred.';
        throw ServerException(message: message, statusCode: statusCode);
      case DioExceptionType.cancel:
        throw const NetworkException(message: 'Request was cancelled.');
      case DioExceptionType.badCertificate:
        throw const ServerException(
          message: 'Invalid SSL certificate.',
          statusCode: 495,
        );
      case DioExceptionType.unknown:
        throw NetworkException(
          message: err.message ?? 'An unknown network error occurred.',
        );
    }
  }
}
