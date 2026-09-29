import 'package:dio/dio.dart';

/// Every Dio error gets converted into one of these before it reaches a
/// repository or bloc. `messageKey` is a localization key (not English
/// text) so the UI layer just does `exception.messageKey.tr()`.
class ApiException implements Exception {
  final String messageKey;
  final int? statusCode;

  ApiException(this.messageKey, {this.statusCode});

  factory ApiException.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException('common.connection_timeout');

      case DioExceptionType.connectionError:
        return ApiException('common.no_internet');

      case DioExceptionType.badResponse:
        return ApiException(
          _extractServerMessage(e) ?? 'common.something_went_wrong',
          statusCode: e.response?.statusCode,
        );

      case DioExceptionType.cancel:
        return ApiException('common.request_cancelled');

      default:
        return ApiException('common.something_went_wrong');
    }
  }

  /// If the backend returns {"message": "..."} we could show it directly,
  /// but since the app is bilingual, prefer mapping known status codes to
  /// localization keys here instead of showing raw backend text.
  static String? _extractServerMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['message'] is String) {
      // Returned as-is for now; swap for a status-code -> key map once
      // the backend's error contract is finalized.
      return data['message'] as String;
    }
    return null;
  }

  @override
  String toString() => 'ApiException($messageKey, statusCode: $statusCode)';
}
