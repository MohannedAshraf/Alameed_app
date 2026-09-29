import 'package:dio/dio.dart';

import 'api_endpoints.dart';
import 'api_exception.dart';

/// The ONE Dio instance for the whole app. Every feature's remote data
/// source calls DioClient().get/post/put/delete instead of building a
/// fresh Dio() and writing try/catch boilerplate each time.
///
/// Usage inside a remote data source:
/// ```dart
/// final response = await DioClient().post(ApiEndpoints.login, data: body);
/// ```
class DioClient {
  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        headers: const {'Accept': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );

    // Add more interceptors here later, e.g. one that reads the saved
    // auth token from local storage and attaches it automatically.
  }

  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio _dio;

  /// Call once after login, with the token returned by the backend.
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Call on logout.
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  void updateLocale(String languageCode) {
    _dio.options.headers['Accept-Language'] = languageCode;
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get<T>(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// For multipart requests (uploading trip images, profile pictures, etc.)
  Future<Response<T>> upload<T>(String path, FormData formData) async {
    try {
      return await _dio.post<T>(path, data: formData);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
