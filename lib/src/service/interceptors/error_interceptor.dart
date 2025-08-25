import 'package:dio/dio.dart';

import 'logging_interceptor.dart';

class ErrorInterceptor {
  final LoggingInterceptor _loggingInterceptor;

  ErrorInterceptor(this._loggingInterceptor);

  DioException getErrorInterceptors(DioException dioError) {
    if (checkConnection(dioError)) {
      return dioError;
    }

    _loggingInterceptor.printError(dioError);
    return dioError;
  }

  /// Method to verify if there is a problem connecting to the internet so that we can show a message
  /// to the user with the problem
  ///
  /// This is given by the Dio Error Type of `DEFAULT`
  bool checkConnection(DioException error) {
    if (error.type == DioExceptionType.connectionError) {
      return true;
    }
    return false;
  }
}
