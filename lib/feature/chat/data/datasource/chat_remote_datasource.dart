// features/chat/data/datasources/chat_remote_datasource.dart
import 'dart:developer';
import 'package:chatapp/core/constants/url_constants.dart';
import 'package:chatapp/core/error/exception_handler.dart';
import 'package:chatapp/core/error/exceptions.dart';
import 'package:chatapp/core/network/api_client.dart';
import 'package:chatapp/feature/chat/data/models/request_models/find_or_create_chat_request.dart';
import 'package:chatapp/feature/chat/data/models/request_models/send_message_request.dart';
import 'package:chatapp/feature/chat/data/models/response_models/chat_response.dart';
import 'package:chatapp/feature/chat/data/models/response_models/message_response.dart';
import 'package:chatapp/feature/chat/data/models/response_models/send_message_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ChatRemoteDataSource {
  Future<ChatResponse> findOrCreateChat({
    required FindOrCreateChatRequest request,
  });

  Future<MessageResponse> getChatMessages({
    required int chatId,
    int page = 1,
    int limit = 50,
  });

  Future<SendMessageResponse> sendMessage({
    required SendMessageRequest request,
  });
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ApiClient _apiClient;

  ChatRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ChatResponse> findOrCreateChat({
    required FindOrCreateChatRequest request,
  }) async {
    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.findOrCreateChat,
        data: findOrCreateChatRequestToJson(request),
      );

      final chatResponse = ChatResponse.fromJson(response);

      log("Chat found/created successfully with ID: ${chatResponse.id}");
      return chatResponse;
    } on AppException catch (e) {
      ExceptionHandler().handleException(e);
      rethrow;
    } on Exception catch (e) {
      log("Unexpected error in findOrCreateChat: $e");
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<MessageResponse> getChatMessages({
    required int chatId,
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final response = await _apiClient.get<Map<String, dynamic>>(
        ApiEndpoints.getMessages(chatId),
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      final messageResponse = MessageResponse.fromJson(response);

      log("Retrieved ${messageResponse.messages?.length} messages for chat $chatId");
      return messageResponse;
    } on AppException catch (e) {
      ExceptionHandler().handleException(e);
      rethrow;
    } on Exception catch (e) {
      log("Unexpected error in getChatMessages: $e");
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<SendMessageResponse> sendMessage({
    required SendMessageRequest request,
  }) async {
    try {
      final response = await _apiClient.post<Map<String, dynamic>>(
        ApiEndpoints.sendMessage,
        data: sendMessageRequestToJson(request),
      );

      final sendMessageResponse = SendMessageResponse.fromJson(response);

      log("Message sent successfully from ${request.senderMobile} to ${request.receiverMobile}");
      return sendMessageResponse;
    } on AppException catch (e) {
      ExceptionHandler().handleException(e);
      rethrow;
    } on Exception catch (e) {
      log("Unexpected error in sendMessage: $e");
      throw ServerException(message: e.toString());
    }
  }
}
