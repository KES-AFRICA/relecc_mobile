import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

// Configuration du logger
final _logger = Logger('AppException');

/// Base exception class for all app-specific exceptions
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic data;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    this.code,
    this.data,
    this.stackTrace,
  });

  @override
  String toString() {
    final codeStr = code != null ? ' ($code)' : '';
    final dataStr = data != null ? ', Data: $data' : '';
    return '$message$codeStr$dataStr';
  }
}

/// Exception thrown when the server returns a 400 Bad Request response
class BadRequestException extends AppException {
  BadRequestException({
    required super.message,
    super.code,
    super.data,
    super.stackTrace,
  });
}

/// Exception thrown when the server returns a 401 or 403 Unauthorized response
class UnauthorizedException extends AppException {
  UnauthorizedException({
    required super.message,
    super.code,
    super.data,
    super.stackTrace,
  });
}

/// Exception thrown when the server returns a 404 Not Found response
class NotFoundException extends AppException {
  NotFoundException({
    required super.message,
    super.code,
    super.data,
    super.stackTrace,
  });
}

/// Exception thrown when there's an error fetching data from the server
class FetchDataException extends AppException {
  FetchDataException({
    required super.message,
    super.code,
    super.data,
    super.stackTrace,
  });
}

/// Exception thrown when the input data is invalid
class InvalidInputException extends AppException {
  InvalidInputException({
    super.code,
    super.data,
    super.stackTrace,
  }) : super(message: 'Invalid input data provided');
}

/// Handles HTTP response errors and converts them to appropriate exceptions
AppException handleResponseError(Response? response, {StackTrace? stackTrace}) {
  _logger.warning('Handling response error: ${response?.statusCode}');

  if (response == null) {
    final exception = FetchDataException(
      message: 'No response received from server',
      stackTrace: stackTrace,
    );
    _logger.severe('No response received: $exception');
    return exception;
  }

  final dynamic errorData = response.data;
  final String errorMessage = _extractErrorMessage(errorData);
  final String? errorCode = _extractErrorCode(errorData);

  AppException exception;
  switch (response.statusCode) {
    case 400:
      exception = BadRequestException(
        message: errorMessage,
        code: errorCode,
        data: errorData,
        stackTrace: stackTrace,
      );
      break;
    case 401:
    case 403:
      exception = UnauthorizedException(
        message: errorMessage,
        code: errorCode,
        data: errorData,
        stackTrace: stackTrace,
      );
      break;
    case 404:
      exception = NotFoundException(
        message: errorMessage,
        code: errorCode,
        data: errorData,
        stackTrace: stackTrace,
      );
      break;
    case 500:
    default:
      exception = FetchDataException(
        message: errorMessage,
        code: errorCode,
        data: errorData,
        stackTrace: stackTrace,
      );
      break;
  }

  _logger.severe('Response error: $exception');
  return exception;
}

/// Handles Dio-specific errors and converts them to appropriate exceptions
AppException handleDioError(DioException error, {StackTrace? stackTrace}) {
  _logger.warning('Handling Dio error: ${error.type}');

  AppException exception;
  switch (error.type) {
    case DioExceptionType.cancel:
      exception = FetchDataException(
        message: 'Request cancelled',
        stackTrace: stackTrace,
      );
      break;
    case DioExceptionType.connectionTimeout:
      exception = FetchDataException(
        message: 'Connection timeout',
        stackTrace: stackTrace,
      );
      break;
    case DioExceptionType.sendTimeout:
      exception = FetchDataException(
        message: 'Send timeout',
        stackTrace: stackTrace,
      );
      break;
    case DioExceptionType.receiveTimeout:
      exception = FetchDataException(
        message: 'Response timeout',
        stackTrace: stackTrace,
      );
      break;
    case DioExceptionType.badCertificate:
      exception = FetchDataException(
        message: 'Invalid SSL certificate',
        stackTrace: stackTrace,
      );
      break;
    case DioExceptionType.connectionError:
      exception = FetchDataException(
        message: 'No internet connection',
        stackTrace: stackTrace,
      );
      break;
    case DioExceptionType.badResponse:
      return handleResponseError(error.response, stackTrace: stackTrace);
    case DioExceptionType.unknown:
      exception = FetchDataException(
        message: error.error?.toString() ?? 'Unknown error occurred',
        stackTrace: stackTrace,
      );
      break;
  }

  _logger.severe('Dio error: $exception');
  return exception;
}

/// Extracts error message from response data
String _extractErrorMessage(dynamic errorData) {
  if (errorData == null) {
    _logger.fine('No error data provided');
    return 'Unknown error occurred';
  }

  if (errorData is Map) {
    final message = errorData['message']?.toString() ??
        errorData['error']?.toString() ??
        errorData['error_description']?.toString() ??
        'Unknown error occurred';
    _logger.fine('Extracted error message: $message');
    return message;
  }

  if (errorData is String) {
    _logger.fine('Error data is string: $errorData');
    return errorData;
  }

  _logger.fine('Unknown error data type: ${errorData.runtimeType}');
  return 'Unknown error occurred';
}

/// Extracts error code from response data
String? _extractErrorCode(dynamic errorData) {
  if (errorData is Map) {
    final code = errorData['code']?.toString() ?? errorData['error_code']?.toString();
    if (code != null) {
      _logger.fine('Extracted error code: $code');
    }
    return code;
  }
  _logger.fine('No error code found');
  return null;
}