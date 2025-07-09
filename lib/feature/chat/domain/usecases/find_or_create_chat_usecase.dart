// features/chat/domain/usecases/find_or_create_chat_usecase.dart
import 'package:chatapp/core/error/failures.dart';
import 'package:chatapp/feature/chat/domain/entities/chat_entity.dart';
import 'package:chatapp/feature/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class FindOrCreateChatUsecase {
  final ChatRepository _repository;

  FindOrCreateChatUsecase(this._repository);

  Future<Either<Failure, ChatEntity>> call({
    required String user1Id,
    required String user2Id,
  }) async {
    return await _repository.findOrCreateChat(
      user1Id: user1Id,
      user2Id: user2Id,
    );
  }
}
