import 'dart:developer' as developer;
import 'package:chatapp/core/error/exceptions.dart';

import 'exception_severity.dart';

/// Centralized exception handler for the application
class ExceptionHandler {
  static final ExceptionHandler _instance = ExceptionHandler._internal();
  factory ExceptionHandler() => _instance;
  ExceptionHandler._internal();

  /// Callback for logging exceptions
  Function(AppException)? _onLogException;
  
  /// Callback for reporting crashes
  Function(AppException)? _onReportCrash;
  
  /// Callback for showing user-friendly error messages
  Function(String)? _onShowUserError;

  /// Initialize the exception handler with callbacks
  void initialize({
    Function(AppException)? onLogException,
    Function(AppException)? onReportCrash,
    Function(String)? onShowUserError,
  }) {
    _onLogException = onLogException;
    _onReportCrash = onReportCrash;
    _onShowUserError = onShowUserError;
  }

  /// Handle an exception with appropriate logging and user feedback
  void handleException(AppException exception) {
    // Log the exception if severity requires it
    if (exception.severity.shouldLog) {
      _logException(exception);
    }

    // Report crash if severity requires it
    if (exception.severity.shouldReportCrash) {
      _reportCrash(exception);
    }

    // Show user-friendly error message
    _showUserError(exception.userMessage);
  }

  /// Handle a generic exception by converting it to AppException
  void handleGenericException(
    Exception exception, {
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    final appException = UnknownException(
      message: exception.toString(),
      originalException: exception,
      stackTrace: stackTrace,
      context: context,
    );
    
    handleException(appException);
  }

  /// Log exception using the provided callback or default logging
  void _logException(AppException exception) {
    if (_onLogException != null) {
      _onLogException!(exception);
    } else {
      // Default logging to console
      developer.log(
        exception.toDetailedString(),
        name: 'ExceptionHandler',
        error: exception,
        stackTrace: exception.stackTrace,
        level: _getSeverityLevel(exception.severity),
      );
    }
  }

  /// Report crash using the provided callback
  void _reportCrash(AppException exception) {
    if (_onReportCrash != null) {
      _onReportCrash!(exception);
    }
  }

  /// Show user error using the provided callback
  void _showUserError(String message) {
    if (_onShowUserError != null) {
      _onShowUserError!(message);
    }
  }

  /// Convert severity to logging level
  int _getSeverityLevel(ExceptionSeverity severity) {
    switch (severity) {
      case ExceptionSeverity.low:
        return 500; // Info level
      case ExceptionSeverity.medium:
        return 900; // Warning level
      case ExceptionSeverity.high:
        return 1000; // Error level
      case ExceptionSeverity.critical:
        return 1200; // Severe level
    }
  }

  /// Create exception from HTTP status code
  static AppException fromHttpStatusCode(
    int statusCode, {
    String? message,
    String? responseBody,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    switch (statusCode) {
      case 400:
        return BadRequestException(
          message: message,
          // responseBody: responseBody,
          stackTrace: stackTrace,
          context: context,
        );
      case 401:
        return UnauthorizedException(
          message: message,
          stackTrace: stackTrace,
          context: context,
        );
      case 403:
        return ForbiddenException(
          message: message,
          stackTrace: stackTrace,
          context: context,
        );
      case 404:
        return NotFoundException(
          message: message,
          stackTrace: stackTrace,
          context: context,
        );
      case 408:
        return TimeoutException(
          message: message,
          stackTrace: stackTrace,
          context: context,
        );
      case 500:
      case 502:
      case 503:
      case 504:
        return ServerException(
          message: message,
          statusCode: statusCode,
          responseBody: responseBody,
          stackTrace: stackTrace,
          context: context,
        );
      default:
        return ServerException(
          message: message ?? 'HTTP Error: $statusCode',
          statusCode: statusCode,
          responseBody: responseBody,
          stackTrace: stackTrace,
          context: context,
        );
    }
  }

  /// Wrap a function call with exception handling
  static Future<T> wrapAsync<T>(
    Future<T> Function() function, {
    Function(AppException)? onError,
  }) async {
    try {
      return await function();
    } on AppException catch (e) {
      if (onError != null) {
        onError(e);
      } else {
        ExceptionHandler().handleException(e);
      }
      rethrow;
    } catch (e, stackTrace) {
      final exception = UnknownException(
        message: e.toString(),
        originalException: e is Exception ? e : Exception(e.toString()),
        stackTrace: stackTrace,
      );
      
      if (onError != null) {
        onError(exception);
      } else {
        ExceptionHandler().handleException(exception);
      }
      rethrow;
    }
  }

  /// Wrap a synchronous function call with exception handling
  static T wrapSync<T>(
    T Function() function, {
    Function(AppException)? onError,
  }) {
    try {
      return function();
    } on AppException catch (e) {
      if (onError != null) {
        onError(e);
      } else {
        ExceptionHandler().handleException(e);
      }
      rethrow;
    } catch (e, stackTrace) {
      final exception = UnknownException(
        message: e.toString(),
        originalException: e is Exception ? e : Exception(e.toString()),
        stackTrace: stackTrace,
      );
      
      if (onError != null) {
        onError(exception);
      } else {
        ExceptionHandler().handleException(exception);
      }
      rethrow;
    }
  }
}