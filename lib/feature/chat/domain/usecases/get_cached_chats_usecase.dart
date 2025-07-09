// features/chat/domain/usecases/get_cached_chats_usecase.dart
import 'package:chatapp/core/error/failures.dart';
import 'package:chatapp/feature/chat/domain/entities/chat_entity.dart';
import 'package:chatapp/feature/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class GetCachedChatsUsecase {
  final ChatRepository _repository;

  GetCachedChatsUsecase(this._repository);

  Future<Either<Failure, List<ChatEntity>>> call() async {
    return await _repository.getCachedChats();
  }
}
