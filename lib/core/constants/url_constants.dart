import 'package:flutter/foundation.dart';

class ApiEndpoints {
  ApiEndpoints._(); // Private constructor to prevent instantiation

  // Base configuration
  static const String _baseUrl = 'https://chat-backend-gxtu.onrender.com';
  // static const String _apiVersion = '/api/v1'; // Optional: Add API versioning

  // Complete URL getter
  static String get baseUrl => _baseUrl;
  // static String get apiBaseUrl => '$_baseUrl$_apiVersion';
  static String get apiBaseUrl => _baseUrl;

  // Auth endpoints
  static const String _auth = '/auth';
  static String get login => '$_auth/login';
  static String get logout => '$_auth/logout';
  static String get register => '$_auth/register';
  static String get refreshToken => '$_auth/refresh';

  // OTP endpoints
  static const String _otp = '/otp';
  static String get sendOtp => '$_otp/request';
  static String get verifyOtp => '$_otp/verify';
  static String get resendOtp => '$_otp/resend';

  // User endpoints
  static const String _user = '/user';
  static String get profile => '$_user/profile';
  static String get updateProfile => '$_user/update';
  static String get deleteAccount => '$_user/delete';

  // Chat endpoints
  static const String _chat = '/chat';
  static String get messages => '$_chat/messages';
  static String get conversations => '$_chat/conversations';
  static String get createConversation => '$_chat/create';

  // Utility methods for dynamic endpoints
  static String getUserProfile(String userId) => '$_user/profile/$userId';
  static String getConversation(String conversationId) =>
      '$_chat/conversations/$conversationId';
  static String getMessages(String conversationId) =>
      '$_chat/conversations/$conversationId/messages';
  static String deleteMessage(String messageId) => '$_chat/messages/$messageId';
  static String updateMessage(String messageId) => '$_chat/messages/$messageId';

  // WebSocket endpoints
  static String get wsBaseUrl => _baseUrl
      .replaceFirst('https://', 'wss://')
      .replaceFirst('http://', 'ws://');
  static String get chatSocket => '$wsBaseUrl/ws/chat';
  static String get notificationSocket => '$wsBaseUrl/ws/notifications';

  // Helper method to get full URL
  static String getFullUrl(String endpoint) => '$apiBaseUrl$endpoint';

  // Environment-specific URLs (useful for different environments)
  static String get environmentUrl {
    if (kDebugMode) {
      return 'https://chat-backend-dev.onrender.com'; // Development URL
    } else if (kProfileMode) {
      return 'https://chat-backend-staging.onrender.com'; // Staging URL
    } else {
      return 'https://chat-backend-gxtu.onrender.com'; // Production URL
    }
  }

  // HTTP methods constants (optional but useful)
  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';

  // Common headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> authHeaders(String token) => {
        ...defaultHeaders,
        'Authorization': 'Bearer $token',
      };

  // Request timeout constants
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Debug helper
  static void printEndpoints() {
    if (kDebugMode) {
      print('=== API Endpoints ===');
      print('Base URL: $apiBaseUrl');
      print('Login: ${getFullUrl(login)}');
      print('Send OTP: ${getFullUrl(sendOtp)}');
      print('Messages: ${getFullUrl(messages)}');
      print('WebSocket: $chatSocket');
      print('=====================');
    }
  }
}
