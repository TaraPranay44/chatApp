// features/chat/domain/repositories/chat_repository.dart
import 'package:chatapp/core/error/failures.dart';
import 'package:chatapp/feature/chat/domain/entities/chat_entity.dart';
import 'package:chatapp/feature/chat/domain/entities/message_entity,dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatEntity>> findOrCreateChat({
    required String user1Id,
    required String user2Id,
  });

  Future<Either<Failure, List<MessageEntity>>> getChatMessages({
    required int chatId,
    int page = 1,
    int limit = 50,
  });

  Future<Either<Failure, MessageEntity>> sendMessage({
    required String senderMobile,
    required String receiverMobile,
    required String content,
  });

  Future<Either<Failure, List<ChatEntity>>> getCachedChats();
  Future<Either<Failure, void>> clearChatCache();
}