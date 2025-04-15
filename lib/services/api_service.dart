import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = dotenv.env['BASE_URL'] ?? '';
    _dio.options.headers['Authorization'] = 'Bearer ${dotenv.env['API_KEY']}';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response.data;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  Future<dynamic> put(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response.data;
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  Future<void> delete(String endpoint) async {
    try {
      await _dio.delete(endpoint);
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }
}
