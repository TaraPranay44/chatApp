class AppConstants {
  // App Info
  static const String appName = 'ChatApp';
  static const String appVersion = '1.0.0';
  
  // Input Validation
  static const int otpLength = 6;
  static const String phoneRegex = r'^[+]?[\d\s-()]{10,}$';
  static const String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  
  // UI Constants
  static const double borderRadius = 12.0;
  static const double buttonBorderRadius = 30.0;
  static const double iconSize = 24.0;
  
  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration snackBarDuration = Duration(seconds: 3);
  
  // Text
  static const String loginTitle = 'Enter your phone or email';
  static const String emailHint = 'Email';
  static const String phoneHint = 'Mobile number';
  static const String otpHint = 'Enter OTP';
  static const String nextButton = 'Next';
  static const String useEmailButton = 'Use Email';
  static const String useMobileButton = 'Use Mobile';
  
  // Error Messages
  static const String emptyEmailError = 'Please enter your email';
  static const String emptyPhoneError = 'Please enter your mobile number';
  static const String invalidEmailError = 'Please enter a valid email';
  static const String invalidPhoneError = 'Please enter a valid mobile number';
  static const String emptyOtpError = 'Please enter the OTP';
  static const String invalidOtpError = 'OTP must be 6 digits';
  static const String defaultSendOtpError = 'Failed to send OTP. Please try again.';
  static const String defaultVerifyOtpError = 'Invalid OTP. Please try again.';
  
  // Success Messages
  static const String otpSentToEmail = 'OTP sent to email';
  static const String otpSentToPhone = 'OTP sent to mobile number';
  static const String loginSuccess = 'Login successful!';
}