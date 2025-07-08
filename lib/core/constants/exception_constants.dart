class ExceptionConstants {
  // Exception Prefixes
  static const String networkErrorPrefix = 'Network Error: ';
  static const String timeoutErrorPrefix = 'Timeout Error: ';
  static const String serverErrorPrefix = 'Server Error: ';
  static const String validationErrorPrefix = 'Validation Error: ';
  static const String authErrorPrefix = 'Authentication Error: ';
  static const String cacheErrorPrefix = 'Cache Error: ';
  static const String requestErrorPrefix = 'Request Error: ';
  static const String unauthorizedPrefix = 'Unauthorized: ';
  static const String forbiddenPrefix = 'Forbidden: ';
  static const String notFoundPrefix = 'Not Found: ';
  static const String requestCancelledPrefix = 'Request Cancelled: ';
  
  // Default Messages
  static const String defaultNetworkError = 'No internet connection';
  static const String defaultTimeoutError = 'Connection timeout';
  static const String defaultServerError = 'Internal server error';
  static const String defaultBadRequest = 'Bad request';
  static const String defaultUnauthorized = 'Unauthorized access';
  static const String defaultForbidden = 'Access forbidden';
  static const String defaultNotFound = 'Resource not found';
  static const String defaultRequestCancelled = 'Request was cancelled';
  static const String defaultCacheError = 'Cache operation failed';
  static const String defaultAuthError = 'Authentication failed';
  static const String defaultValidationError = 'Validation failed';
  static const String defaultUnknownError = 'An unexpected error occurred';
  
  // User-Friendly Messages
  static const String userFriendlyNetworkError = 'Please check your internet connection and try again';
  static const String userFriendlyTimeoutError = 'The request took too long. Please try again';
  static const String userFriendlyServerError = 'Something went wrong on our end. Please try again later';
  static const String userFriendlyAuthError = 'Please log in again to continue';
  static const String userFriendlyUnauthorizedError = 'You don\'t have permission to access this resource';
  static const String userFriendlyNotFoundError = 'The requested resource was not found';
  static const String userFriendlyValidationError = 'Please check your input and try again';
  static const String userFriendlyUnknownError = 'Something went wrong. Please try again';
  
  // Error Codes
  static const int networkErrorCode = 1000;
  static const int timeoutErrorCode = 1001;
  static const int serverErrorCode = 1002;
  static const int badRequestCode = 1003;
  static const int unauthorizedCode = 1004;
  static const int forbiddenCode = 1005;
  static const int notFoundCode = 1006;
  static const int requestCancelledCode = 1007;
  static const int cacheErrorCode = 1008;
  static const int authErrorCode = 1009;
  static const int validationErrorCode = 1010;
  static const int unknownErrorCode = 9999;
}