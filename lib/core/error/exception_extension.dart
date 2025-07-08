import 'package:chatapp/core/error/exceptions.dart';


/// Extension methods for working with exceptions
extension ExceptionExtensions on Exception {
  /// Convert a generic exception to AppException
  AppException toAppException({
    String? message,
    String? userMessage,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) {
    return UnknownException(
      message: message ?? toString(),
      userMessage: userMessage,
      originalException: this,
      stackTrace: stackTrace,
      context: context,
    );
  }
}

/// Extension methods for AppException
extension AppExceptionExtensions on AppException {
  /// Check if this exception should be retried
  bool get isRetryable {
    return this is NetworkException ||
           this is TimeoutException ||
           (this is ServerException && 
            (this as ServerException).statusCode != null &&
            (this as ServerException).statusCode! >= 500);
  }
  
  /// Check if this exception is related to authentication
  bool get isAuthenticationRelated {
    return this is AuthenticationException ||
           this is UnauthorizedException;
  }
  
  /// Check if this exception is a client error (4xx)
  bool get isClientError {
    return this is BadRequestException ||
           this is UnauthorizedException ||
           this is ForbiddenException ||
           this is NotFoundException;
  }
  
  /// Check if this exception is a server error (5xx)
  bool get isServerError {
    return this is ServerException;
  }
  
  /// Check if this exception is network related
  bool get isNetworkRelated {
    return this is NetworkException ||
           this is TimeoutException;
  }
  
  /// Get retry delay based on exception type
  Duration get retryDelay {
    if (this is NetworkException) {
      return const Duration(seconds: 2);
    } else if (this is TimeoutException) {
      return const Duration(seconds: 5);
    } else if (this is ServerException) {
      return const Duration(seconds: 10);
    }
    return const Duration(seconds: 1);
  }
  
  /// Get maximum retry attempts based on exception type
  int get maxRetryAttempts {
    if (this is NetworkException) {
      return 3;
    } else if (this is TimeoutException) {
      return 2;
    } else if (this is ServerException) {
      return 1;
    }
    return 0;
  }
}