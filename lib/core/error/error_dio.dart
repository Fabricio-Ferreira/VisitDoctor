import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  String? message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.badCertificate:
      case DioExceptionType.cancel:
      case DioExceptionType.connectionError:
      case DioExceptionType.badResponse:
        message = _handleError(dioError.response!.statusCode, dioError.response!.data);
        break;
      case DioExceptionType.unknown:
        message = 'Ops, algo deu errado, tente mais tarde';
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    if (statusCode != 502 && statusCode != 404 && statusCode != 504) {
      try {
        if (error is String) {
          return error;
        }
        return error['message'] ?? 'Ops, algo deu errado, tente mais tarde';
      } on Exception catch (ex) {
        return ex.toString();
      }
    } else {
      return 'Ops, algo deu errado, tente mais tarde';
    }
  }

  @override
  String toString() => message!;
}
