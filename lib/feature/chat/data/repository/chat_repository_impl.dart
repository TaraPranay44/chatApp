// // features/chat/data/repositories/chat_repository_impl.dart
// import 'dart:developer';

// import 'package:chatapp/core/error/exceptions.dart';
// import 'package:chatapp/core/error/failures.dart';
// import 'package:chatapp/feature/chat/data/datasource/chat_remote_datasource.dart';
// import 'package:chatapp/feature/chat/data/models/request_models/find_or_create_chat_request.dart';
// import 'package:chatapp/feature/chat/data/models/request_models/send_message_request.dart';
// import 'package:chatapp/feature/chat/data/models/response_models/message_response.dart';
// import 'package:chatapp/feature/chat/domain/entities/chat_entity.dart';
// import 'package:chatapp/feature/chat/domain/entities/message_entity,dart';
// import 'package:chatapp/feature/chat/domain/repositories/chat_repository.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ChatRepositoryImpl implements ChatRepository {
//   final ChatRemoteDataSource _remoteDataSource;

//   ChatRepositoryImpl({
//     required ChatRemoteDataSource remoteDataSource,
//   }) : _remoteDataSource = remoteDataSource;

//   @override
//   Future<Either<Failure, ChatEntity>> findOrCreateChat({
//     required String user1Id,
//     required String user2Id,
//   }) async {
//     try {
//       final request = FindOrCreateChatRequest(
//         user1Id: user1Id,
//         user2Id: user2Id,
//       );
      
//       final chatResponse = await _remoteDataSource.findOrCreateChat(request: request);
      
//       // Convert to entity
//       final chatEntity = ChatEntity(
//         id: chatResponse.id ?? 0,
//         user1: _convertChatUserToUserEntity(chatResponse.user1),
//         user2: _convertChatUserToUserEntity(chatResponse.user2),
//       );
      
//       return Right(chatEntity);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(message: e.message));
//     } on NetworkException {
//       return const Left(NetworkFailure());
//     } on BadRequestException catch (e) {
//       return Left(ValidationFailure(message: e.message));
//     } on Exception catch (e) {
//       log("Unexpected error in findOrCreateChat: $e");
//       return const Left(ServerFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, List<MessageEntity>>> getChatMessages({
//     required int chatId,
//     int page = 1,
//     int limit = 50,
//   }) async {
//     try {
//       final messageResponse = await _remoteDataSource.getChatMessages(
//         chatId: chatId,
//         page: page,
//         limit: limit,
//       );
      
//       // Convert to entities
//       final messageEntities = messageResponse.messages?.map((message) => 
//         _convertMessageModelToEntity(message)
//       ).toList() ?? [];
      
//       return Right(messageEntities);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(message: e.message));
//     } on NetworkException {
//       return const Left(NetworkFailure());
//     } on BadRequestException catch (e) {
//       return Left(ValidationFailure(message: e.message));
//     } on Exception catch (e) {
//       log("Unexpected error in getChatMessages: $e");
//       return const Left(ServerFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, MessageEntity>> sendMessage({
//     required String senderMobile,
//     required String receiverMobile,
//     required String content,
//   }) async {
//     try {
//       final request = SendMessageRequest(
//         senderMobile: senderMobile,
//         receiverMobile: receiverMobile,
//         content: content,
//       );
      
//       final sendMessageResponse = await _remoteDataSource.sendMessage(request: request);
      
//       // Convert to entity
//       final messageEntity = _convertMessageModelToEntity(sendMessageResponse.message);
      
//       return Right(messageEntity);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(message: e.message));
//     } on NetworkException {
//       return const Left(NetworkFailure());
//     } on BadRequestException catch (e) {
//       return Left(ValidationFailure(message: e.message));
//     } on Exception catch (e) {
//       log("Unexpected error in sendMessage: $e");
//       return const Left(ServerFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, List<ChatEntity>>> getCachedChats() async {
//     try {
//       // For now, return empty list since we don't have local data source
//       return const Right([]);
//     } on Exception catch (e) {
//       log("Unexpected error in getCachedChats: $e");
//       return const Left(CacheFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, void>> clearChatCache() async {
//     try {
//       // For now, just return success since we don't have local data source
//       return const Right(null);
//     } on Exception catch (e) {
//       log("Unexpected error in clearChatCache: $e");
//       return const Left(CacheFailure());
//     }
//   }

//   // Helper methods
//   UserEntity _convertChatUserToUserEntity(dynamic chatUser) {
//     if (chatUser == null) {
//       return const UserEntity(
//         mobile: '',
//         username: 'Unknown',
//       );
//     }
    
//     return UserEntity(
//       mobile: chatUser.mobile ?? '',
//       username: chatUser.username ?? 'Unknown',
//       password: chatUser.password,
//       isActive: chatUser.isActive ?? false,
//     );
//   }

//   MessageEntity _convertMessageModelToEntity(dynamic message) {
//     if (message == null) {
//       return MessageEntity(
//         id: 0,
//         content: '',
//         senderId: '',
//         receiverId: '',
//         chatId: 0,
//         createdAt: DateTime.now(),
//       );
//     }
    
//     return MessageEntity(
//       id: message.id ?? 0,
//       content: message.content ?? '',
//       senderId: message.sender?.mobile ?? '',
//       receiverId: '', // Will be set based on context
//       chatId: message.chat?.id ?? 0,
//       createdAt: message.createdAt ?? DateTime.now(),
//       updatedAt: message.updatedAt,
//       isRead: message.isReadByReceiver ?? false,
//       // isSent: message.isSent ?? false,
//       // isDelivered: message.isDelivered ?? false,
//     );
//   }
// }




// features/chat/data/repositories/chat_repository_impl.dart
import 'dart:developer';

import 'package:chatapp/core/error/exceptions.dart';
import 'package:chatapp/core/error/failures.dart';
import 'package:chatapp/feature/chat/data/datasource/chat_remote_datasource.dart';
import 'package:chatapp/feature/chat/data/models/request_models/find_or_create_chat_request.dart';
import 'package:chatapp/feature/chat/data/models/request_models/send_message_request.dart';
import 'package:chatapp/feature/chat/data/models/response_models/message_response.dart';
import 'package:chatapp/feature/chat/domain/entities/chat_entity.dart';
import 'package:chatapp/feature/chat/domain/entities/message_entity,dart';
import 'package:chatapp/feature/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _remoteDataSource;

  ChatRepositoryImpl({
    required ChatRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, ChatEntity>> findOrCreateChat({
    required String user1Id,
    required String user2Id,
  }) async {
    try {
      // Validate inputs
      if (user1Id.isEmpty || user2Id.isEmpty) {
        return const Left(ValidationFailure(message: 'User IDs cannot be empty'));
      }

      final request = FindOrCreateChatRequest(
        user1Id: user1Id,
        user2Id: user2Id,
      );
      
      final chatResponse = await _remoteDataSource.findOrCreateChat(request: request);
      
      // Convert to entity
      final chatEntity = ChatEntity(
        id: chatResponse.id ?? 0,
        user1: _convertChatUserToUserEntity(chatResponse.user1),
        user2: _convertChatUserToUserEntity(chatResponse.user2),
      );
      
      return Right(chatEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } on BadRequestException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } on Exception catch (e) {
      log("Unexpected error in findOrCreateChat: $e");
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getChatMessages({
    required int chatId,
    int page = 1,
    int limit = 50,
  }) async {
    try {
      // Validate inputs
      if (chatId <= 0) {
        return const Left(ValidationFailure(message: 'Invalid chat ID'));
      }

      final messageResponse = await _remoteDataSource.getChatMessages(
        chatId: chatId,
        page: page,
        limit: limit,
      );
      
      // Convert to entities
      final messageEntities = messageResponse.messages?.map((message) => 
        _convertMessageModelToEntity(message)
      ).toList() ?? [];
      
      return Right(messageEntities);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } on BadRequestException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } on Exception catch (e) {
      log("Unexpected error in getChatMessages: $e");
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> sendMessage({
    required String senderMobile,
    required String receiverMobile,
    required String content,
  }) async {
    try {
      // Validate inputs
      if (senderMobile.isEmpty || receiverMobile.isEmpty || content.trim().isEmpty) {
        return const Left(ValidationFailure(message: 'All fields are required'));
      }

      final request = SendMessageRequest(
        senderMobile: senderMobile,
        receiverMobile: receiverMobile,
        content: content.trim(),
      );
      
      final sendMessageResponse = await _remoteDataSource.sendMessage(request: request);
      
      // Convert to entity
      final messageEntity = _convertMessageModelToEntity(sendMessageResponse.message);
      
      return Right(messageEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException {
      return const Left(NetworkFailure());
    } on BadRequestException catch (e) {
      return Left(ValidationFailure(message: e.message));
    } on Exception catch (e) {
      log("Unexpected error in sendMessage: $e");
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ChatEntity>>> getCachedChats() async {
    try {
      // For now, return empty list since we don't have local data source
      return const Right([]);
    } on Exception catch (e) {
      log("Unexpected error in getCachedChats: $e");
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> clearChatCache() async {
    try {
      // For now, just return success since we don't have local data source
      return const Right(null);
    } on Exception catch (e) {
      log("Unexpected error in clearChatCache: $e");
      return const Left(CacheFailure());
    }
  }

  // Helper methods
  UserEntity _convertChatUserToUserEntity(dynamic chatUser) {
    if (chatUser == null) {
      return const UserEntity(
        mobile: '',
        username: 'Unknown',
      );
    }
    
    return UserEntity(
      mobile: chatUser.mobile ?? '',
      username: chatUser.username ?? 'Unknown',
      password: chatUser.password,
      isActive: chatUser.isActive ?? false,
    );
  }

  MessageEntity _convertMessageModelToEntity(dynamic message) {
    if (message == null) {
      return MessageEntity(
        id: 0,
        content: '',
        senderId: '',
        receiverId: '',
        chatId: 0,
        createdAt: DateTime.now(),
      );
    }
    
    return MessageEntity(
      id: message.id ?? 0,
      content: message.content ?? '',
      senderId: message.sender?.mobile ?? '',
      receiverId: '', // Will be set based on context
      chatId: message.chat?.id ?? 0,
      createdAt: message.createdAt ?? DateTime.now(),
      updatedAt: message.updatedAt,
      isRead: message.isReadByReceiver ?? false,
    );
  }
}
