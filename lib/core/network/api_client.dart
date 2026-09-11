import 'package:dio/dio.dart';
import 'package:movies/core/errors/network_exception.dart';
import 'package:movies/core/errors/server_exception.dart';

class ApiClient {
  static const String baseUrl = 'https://movies-api.accel.li/api/v2/';

  final Dio _dio;

  ApiClient({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: baseUrl,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
            ),
          );

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw ServerException(e.response!.statusCode ?? 0);
      }

      throw NetworkException('Network request failed');
    }
  }
}
