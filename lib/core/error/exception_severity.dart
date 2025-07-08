/// Enum representing different severity levels of exceptions
enum ExceptionSeverity {
  /// Low severity - typically user errors or expected conditions
  low,
  
  /// Medium severity - network issues, timeouts, or recoverable errors
  medium,
  
  /// High severity - server errors, authentication failures
  high,
  
  /// Critical severity - system failures, data corruption
  critical;
  
  /// Returns a string representation of the severity level
  String get displayName {
    switch (this) {
      case ExceptionSeverity.low:
        return 'Low';
      case ExceptionSeverity.medium:
        return 'Medium';
      case ExceptionSeverity.high:
        return 'High';
      case ExceptionSeverity.critical:
        return 'Critical';
    }
  }
  
  /// Returns whether this severity should be logged
  bool get shouldLog {
    switch (this) {
      case ExceptionSeverity.low:
        return false;
      case ExceptionSeverity.medium:
      case ExceptionSeverity.high:
      case ExceptionSeverity.critical:
        return true;
    }
  }
  
  /// Returns whether this severity should trigger crash reporting
  bool get shouldReportCrash {
    switch (this) {
      case ExceptionSeverity.low:
      case ExceptionSeverity.medium:
        return false;
      case ExceptionSeverity.high:
      case ExceptionSeverity.critical:
        return true;
    }
  }
}