// features/chat/domain/entities/chat_list_entity.dart
import 'package:chatapp/feature/chat/domain/entities/chat_entity.dart';
import 'package:equatable/equatable.dart';

class ChatListEntity extends Equatable {
  final List<ChatEntity> chats;
  final int total;
  final bool hasMore;
  final int currentPage;

  const ChatListEntity({
    required this.chats,
    required this.total,
    this.hasMore = false,
    this.currentPage = 1,
  });

  @override
  List<Object?> get props => [chats, total, hasMore, currentPage];

  ChatListEntity copyWith({
    List<ChatEntity>? chats,
    int? total,
    bool? hasMore,
    int? currentPage,
  }) {
    return ChatListEntity(
      chats: chats ?? this.chats,
      total: total ?? this.total,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}