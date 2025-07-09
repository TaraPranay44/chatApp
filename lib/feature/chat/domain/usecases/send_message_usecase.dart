// features/chat/domain/usecases/send_message_usecase.dart
import 'package:chatapp/core/error/failures.dart';
import 'package:chatapp/feature/chat/domain/entities/message_entity,dart';
import 'package:chatapp/feature/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class SendMessageUsecase {
  final ChatRepository _repository;

  SendMessageUsecase(this._repository);

  Future<Either<Failure, MessageEntity>> call({
    required String senderMobile,
    required String receiverMobile,
    required String content,
  }) async {
    return await _repository.sendMessage(
      senderMobile: senderMobile,
      receiverMobile: receiverMobile,
      content: content,
    );
  }
}