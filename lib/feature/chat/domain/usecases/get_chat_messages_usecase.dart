// features/chat/domain/usecases/get_chat_messages_usecase.dart
import 'package:chatapp/core/error/failures.dart';
import 'package:chatapp/feature/chat/domain/entities/message_entity,dart';
import 'package:chatapp/feature/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class GetChatMessagesUsecase {
  final ChatRepository _repository;

  GetChatMessagesUsecase(this._repository);

  Future<Either<Failure, List<MessageEntity>>> call({
    required int chatId,
    int page = 1,
    int limit = 50,
  }) async {
    return await _repository.getChatMessages(
      chatId: chatId,
      page: page,
      limit: limit,
    );
  }
}
