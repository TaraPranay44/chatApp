// // Base Exception
// abstract class AppException implements Exception {
//   final String message;
//   final String? prefix;

//   AppException({required this.message, this.prefix});

//   @override
//   String toString() {
//     return "$prefix$message";
//   }
// }

// // Network related exceptions
// class NetworkException extends AppException {
//   NetworkException({String message = 'No internet connection'})
//       : super(message: message, prefix: 'Network Error: ');
// }

// class TimeoutException extends AppException {
//   TimeoutException({String message = 'Connection timeout'})
//       : super(message: message, prefix: 'Timeout Error: ');
// }

// // Server related exceptions
// class ServerException extends AppException {
//   ServerException({String message = 'Internal server error'})
//       : super(message: message, prefix: 'Server Error: ');
// }

// class BadRequestException extends AppException {
//   BadRequestException({String? message})
//       : super(message: message ?? 'Bad request', prefix: 'Invalid Request: ');
// }

// class UnauthorizedException extends AppException {
//   UnauthorizedException({String? message})
//       : super(message: message ?? 'Unauthorized', prefix: 'Unauthorized: ');
// }

// class ForbiddenException extends AppException {
//   ForbiddenException({String? message})
//       : super(message: message ?? 'Forbidden', prefix: 'Forbidden: ');
// }

// class NotFoundException extends AppException {
//   NotFoundException({String? message})
//       : super(message: message ?? 'Not found', prefix: 'Not Found: ');
// }

// class RequestCancelledException extends AppException {
//   RequestCancelledException({String message = 'Request cancelled'})
//       : super(message: message, prefix: 'Request Cancelled: ');
// }

// // Cache related exceptions
// class CacheException extends AppException {
//   CacheException({String message = 'Cache error'})
//       : super(message: message, prefix: 'Cache Error: ');
// }

// // Authentication related exceptions
// class AuthenticationException extends AppException {
//   AuthenticationException({String message = 'Authentication failed'})
//       : super(message: message, prefix: 'Authentication Error: ');
// }



import 'package:chatapp/core/constants/exception_constants.dart';

import 'exception_severity.dart';

/// Base exception class for all application exceptions
abstract class AppException implements Exception {
  /// The technical error message for developers
  final String message;
  
  /// User-friendly error message for display
  final String userMessage;
  
  /// Unique error code for tracking
  final int errorCode;
  
  /// Severity level of the exception
  final ExceptionSeverity severity;
  
  /// Optional prefix for the error message
  final String? prefix;
  
  /// Stack trace information
  final StackTrace? stackTrace;
  
  /// Additional context data
  final Map<String, dynamic>? context;
  
  /// Timestamp when the exception occurred
  final DateTime timestamp;

  AppException({
    required this.message,
    required this.userMessage,
    required this.errorCode,
    required this.severity,
    this.prefix,
    this.stackTrace,
    this.context,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  @override
  String toString() {
    final buffer = StringBuffer();
    
    if (prefix != null) {
      buffer.write(prefix);
    }
    
    buffer.write(message);
    
    if (context != null && context!.isNotEmpty) {
      buffer.write(' | Context: ${context.toString()}');
    }
    
    return buffer.toString();
  }
  
  /// Returns a detailed string representation for logging
  String toDetailedString() {
    final buffer = StringBuffer();
    buffer.writeln('Exception: ${runtimeType.toString()}');
    buffer.writeln('Message: $message');
    buffer.writeln('User Message: $userMessage');
    buffer.writeln('Error Code: $errorCode');
    buffer.writeln('Severity: ${severity.displayName}');
    buffer.writeln('Timestamp: ${timestamp.toIso8601String()}');
    
    if (context != null && context!.isNotEmpty) {
      buffer.writeln('Context: ${context.toString()}');
    }
    
    if (stackTrace != null) {
      buffer.writeln('Stack Trace:');
      buffer.writeln(stackTrace.toString());
    }
    
    return buffer.toString();
  }
  
  /// Converts the exception to a JSON map for serialization
  Map<String, dynamic> toJson() {
    return {
      'type': runtimeType.toString(),
      'message': message,
      'userMessage': userMessage,
      'errorCode': errorCode,
      'severity': severity.name,
      'timestamp': timestamp.toIso8601String(),
      'context': context,
    };
  }
}

// Network related exceptions
class NetworkException extends AppException {
  NetworkException({
    String? message,
    String? userMessage,
    super.stackTrace,
    super.context,
  }) : super(
          message: message ?? ExceptionConstants.defaultNetworkError,
          userMessage: userMessage ?? ExceptionConstants.userFriendlyNetworkError,
          errorCode: ExceptionConstants.networkErrorCode,
          severity: ExceptionSeverity.medium,
          prefix: ExceptionConstants.networkErrorPrefix,
        );
}

class TimeoutException extends AppException {
  final Duration? timeout;
  
  TimeoutException({
    String? message,
    String? userMessage,
    this.timeout,
    super.stackTrace,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? ExceptionConstants.defaultTimeoutError,
          userMessage: userMessage ?? ExceptionConstants.userFriendlyTimeoutError,
          errorCode: ExceptionConstants.timeoutErrorCode,
          severity: ExceptionSeverity.medium,
          prefix: ExceptionConstants.timeoutErrorPrefix,
          context: {
            ...?context,
            if (timeout != null) 'timeoutDuration': timeout.inMilliseconds,
          },
        );
}

// Server related exceptions
class ServerException extends AppException {
  final int? statusCode;
  final String? responseBody;
  
  ServerException({
    String? message,
    String? userMessage,
    this.statusCode,
    this.responseBody,
    super.stackTrace,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? ExceptionConstants.defaultServerError,
          userMessage: userMessage ?? ExceptionConstants.userFriendlyServerError,
          errorCode: ExceptionConstants.serverErrorCode,
          severity: ExceptionSeverity.high,
          prefix: ExceptionConstants.serverErrorPrefix,
          context: {
            ...?context,
            if (statusCode != null) 'statusCode': statusCode,
            if (responseBody != null) 'responseBody': responseBody,
          },
        );
}

class BadRequestException extends AppException {
  final Map<String, List<String>>? validationErrors;
  
  BadRequestException({
    String? message,
    String? userMessage,
    this.validationErrors,
    super.stackTrace,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? ExceptionConstants.defaultBadRequest,
          userMessage: userMessage ?? ExceptionConstants.userFriendlyValidationError,
          errorCode: ExceptionConstants.badRequestCode,
          severity: ExceptionSeverity.low,
          prefix: ExceptionConstants.requestErrorPrefix,
          context: {
            ...?context,
            if (validationErrors != null) 'validationErrors': validationErrors,
          },
        );
}

class UnauthorizedException extends AppException {
  final String? authType;
  
  UnauthorizedException({
    String? message,
    String? userMessage,
    this.authType,
    super.stackTrace,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? ExceptionConstants.defaultUnauthorized,
          userMessage: userMessage ?? ExceptionConstants.userFriendlyAuthError,
          errorCode: ExceptionConstants.unauthorizedCode,
          severity: ExceptionSeverity.high,
          prefix: ExceptionConstants.unauthorizedPrefix,
          context: {
            ...?context,
            if (authType != null) 'authType': authType,
          },
        );
}

class ForbiddenException extends AppException {
  final String? resource;
  final String? action;
  
  ForbiddenException({
    String? message,
    String? userMessage,
    this.resource,
    this.action,
    super.stackTrace,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? ExceptionConstants.defaultForbidden,
          userMessage: userMessage ?? ExceptionConstants.userFriendlyUnauthorizedError,
          errorCode: ExceptionConstants.forbiddenCode,
          severity: ExceptionSeverity.high,
          prefix: ExceptionConstants.forbiddenPrefix,
          context: {
            ...?context,
            if (resource != null) 'resource': resource,
            if (action != null) 'action': action,
          },
        );
}

class NotFoundException extends AppException {
  final String? resourceType;
  final String? resourceId;
  
  NotFoundException({
    String? message,
    String? userMessage,
    this.resourceType,
    this.resourceId,
    super.stackTrace,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? ExceptionConstants.defaultNotFound,
          userMessage: userMessage ?? ExceptionConstants.userFriendlyNotFoundError,
          errorCode: ExceptionConstants.notFoundCode,
          severity: ExceptionSeverity.medium,
          prefix: ExceptionConstants.notFoundPrefix,
          context: {
            ...?context,
            if (resourceType != null) 'resourceType': resourceType,
            if (resourceId != null) 'resourceId': resourceId,
          },
        );
}

class RequestCancelledException extends AppException {
  final String? reason;
  
  RequestCancelledException({
    String? message,
    String? userMessage,
    this.reason,
    super.stackTrace,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? ExceptionConstants.defaultRequestCancelled,
          userMessage: userMessage ?? ExceptionConstants.defaultRequestCancelled,
          errorCode: ExceptionConstants.requestCancelledCode,
          severity: ExceptionSeverity.low,
          prefix: ExceptionConstants.requestCancelledPrefix,
          context: {
            ...?context,
            if (reason != null) 'reason': reason,
          },
        );
}

// Cache related exceptions
class CacheException extends AppException {
  final String? cacheKey;
  final String? operation;
  
  CacheException({
    String? message,
    String? userMessage,
    this.cacheKey,
    this.operation,
    super.stackTrace,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? ExceptionConstants.defaultCacheError,
          userMessage: userMessage ?? ExceptionConstants.userFriendlyUnknownError,
          errorCode: ExceptionConstants.cacheErrorCode,
          severity: ExceptionSeverity.medium,
          prefix: ExceptionConstants.cacheErrorPrefix,
          context: {
            ...?context,
            if (cacheKey != null) 'cacheKey': cacheKey,
            if (operation != null) 'operation': operation,
          },
        );
}

// Authentication related exceptions
class AuthenticationException extends AppException {
  final String? authMethod;
  final String? userId;
  
  AuthenticationException({
    String? message,
    String? userMessage,
    this.authMethod,
    this.userId,
    super.stackTrace,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? ExceptionConstants.defaultAuthError,
          userMessage: userMessage ?? ExceptionConstants.userFriendlyAuthError,
          errorCode: ExceptionConstants.authErrorCode,
          severity: ExceptionSeverity.high,
          prefix: ExceptionConstants.authErrorPrefix,
          context: {
            ...?context,
            if (authMethod != null) 'authMethod': authMethod,
            if (userId != null) 'userId': userId,
          },
        );
}

// Validation related exceptions
class ValidationException extends AppException {
  final Map<String, List<String>>? fieldErrors;
  final String? fieldName;
  
  ValidationException({
    String? message,
    String? userMessage,
    this.fieldErrors,
    this.fieldName,
    super.stackTrace,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? ExceptionConstants.defaultValidationError,
          userMessage: userMessage ?? ExceptionConstants.userFriendlyValidationError,
          errorCode: ExceptionConstants.validationErrorCode,
          severity: ExceptionSeverity.low,
          prefix: ExceptionConstants.validationErrorPrefix,
          context: {
            ...?context,
            if (fieldErrors != null) 'fieldErrors': fieldErrors,
            if (fieldName != null) 'fieldName': fieldName,
          },
        );
}

// Unknown or unexpected exceptions
class UnknownException extends AppException {
  final Exception? originalException;
  
  UnknownException({
    String? message,
    String? userMessage,
    this.originalException,
    super.stackTrace,
    Map<String, dynamic>? context,
  }) : super(
          message: message ?? ExceptionConstants.defaultUnknownError,
          userMessage: userMessage ?? ExceptionConstants.userFriendlyUnknownError,
          errorCode: ExceptionConstants.unknownErrorCode,
          severity: ExceptionSeverity.critical,
          context: {
            ...?context,
            if (originalException != null) 'originalException': originalException.toString(),
          },
        );
}