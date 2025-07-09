// // features/chat/data/datasources/chat_local_datasource.dart
// import 'dart:convert';
// import 'package:chatapp/core/error/exceptions.dart';
// import 'package:chatapp/core/storage/secure_storage.dart';
// import 'package:chatapp/feature/chat/data/models/response_models/chat_response.dart';
// import 'package:chatapp/feature/chat/data/models/response_models/message_response.dart';

// abstract class ChatLocalDataSource {
//   Future<void> cacheChat(ChatResponse chat);
//   Future<List<ChatResponse>> getCachedChats();
//   Future<void> clearChatCache();
  
//   Future<void> cacheMessages(int chatId, List<Message> messages);
//   Future<List<Message>> getCachedMessages(int chatId);
//   Future<void> addMessage(int chatId, Message message);
//   Future<void> clearMessagesCache(int chatId);
// }

// class ChatLocalDataSourceImpl implements ChatLocalDataSource {
//   final SecureStorageService _secureStorage;
  
//   ChatLocalDataSourceImpl(this._secureStorage);

//   static const String _chatsKey = 'cached_chats';
//   static const String _messagesKeyPrefix = 'cached_messages_';

//   @override
//   Future<void> cacheChat(ChatResponse chat) async {
//     try {
//       final cachedChats = await getCachedChats();
      
//       // Remove existing chat with same ID
//       cachedChats.removeWhere((c) => c.id == chat.id);
      
//       // Add new chat
//       cachedChats.add(chat);
      
//       // Store updated list
//       final jsonString = json.encode(cachedChats.map((c) => c.toJson()).toList());
//       // await _secureStorage.write(key: _chatsKey, value: jsonString);
//     } catch (e) {
//       throw CacheException(message: 'Failed to cache chat: $e');
//     }
//   }

//   @override
//   Future<List<ChatResponse>> getCachedChats() async {
//     try {
//       final jsonString = await _secureStorage.read(key: _chatsKey);
//       if (jsonString == null) return [];
      
//       final List<dynamic> jsonList = json.decode(jsonString);
//       return jsonList.map((json) => ChatResponse.fromJson(json)).toList();
//     } catch (e) {
//       throw CacheException(message: 'Failed to get cached chats: $e');
//     }
//   }

//   @override
//   Future<void> clearChatCache() async {
//     try {
//       await _secureStorage.delete(key: _chatsKey);
//     } catch (e) {
//       throw CacheException(message: 'Failed to clear chat cache: $e');
//     }
//   }

//   @override
//   Future<void> cacheMessages(int chatId, List<MessageModel> messages) async {
//     try {
//       final jsonString = json.encode(messages.map((m) => m.toJson()).toList());
//       await _secureStorage.write(
//         key: '$_messagesKeyPrefix$chatId',
//         value: jsonString,
//       );
//     } catch (e) {
//       throw CacheException(message: 'Failed to cache messages: $e');
//     }
//   }

//   @override
//   Future<List<MessageModel>> getCachedMessages(int chatId) async {
//     try {
//       final jsonString = await _secureStorage.read(key: '$_messagesKeyPrefix$chatId');
//       if (jsonString == null) return [];
      
//       final List<dynamic> jsonList = json.decode(jsonString);
//       return jsonList.map((json) => MessageModel.fromJson(json)).toList();
//     } catch (e) {
//       throw CacheException(message: 'Failed to get cached messages: $e');
//     }
//   }

//   @override
//   Future<void> addMessage(int chatId, MessageModel message) async {
//     try {
//       final cachedMessages = await getCachedMessages(chatId);
      
//       // Check if message already exists
//       final existingIndex = cachedMessages.indexWhere((m) => m.id == message.id);
//       if (existingIndex != -1) {
//         cachedMessages[existingIndex] = message;
//       } else {
//         cachedMessages.add(message);
//       }
      
//       // Sort by creation date
//       cachedMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      
//       await cacheMessages(chatId, cachedMessages);
//     } catch (e) {
//       throw CacheException(message: 'Failed to add message: $e');
//     }
//   }

//   @override
//   Future<void> clearMessagesCache(int chatId) async {
//     try {
//       await _secureStorage.delete(key: '$_messagesKeyPrefix$chatId');
//     } catch (e) {
//       throw CacheException(message: 'Failed to clear messages cache: $e');
//     }
//   }
// }
