// features/chat/presentation/providers/chat_provider.dart
import 'package:chatapp/core/error/failures.dart';
import 'package:chatapp/feature/chat/data/datasource/chat_remote_datasource.dart';
import 'package:chatapp/feature/chat/data/repository/chat_repository_impl.dart';
import 'package:chatapp/feature/chat/domain/entities/chat_entity.dart';
import 'package:chatapp/feature/chat/domain/entities/message_entity,dart';
import 'package:chatapp/feature/chat/domain/repositories/chat_repository.dart';
import 'package:chatapp/feature/chat/domain/usecases/find_or_create_chat_usecase.dart';
import 'package:chatapp/feature/chat/domain/usecases/get_cached_chats_usecase.dart';
import 'package:chatapp/feature/chat/domain/usecases/get_chat_messages_usecase.dart';
import 'package:chatapp/feature/chat/domain/usecases/send_message_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Data source provider
final chatRemoteDataSourceProvider = Provider<ChatRemoteDataSource>((ref) {
  // You need to provide ApiClient here
  // final apiClient = ref.watch(apiClientProvider);
  // return ChatRemoteDataSourceImpl(apiClient);
  throw UnimplementedError('ApiClient provider not implemented');
});

// Repository provider
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final remoteDataSource = ref.watch(chatRemoteDataSourceProvider);
  return ChatRepositoryImpl(
    remoteDataSource: remoteDataSource,
  );
});

// Use case providers
final findOrCreateChatUsecaseProvider = Provider<FindOrCreateChatUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return FindOrCreateChatUsecase(repository);
});

final getChatMessagesUsecaseProvider = Provider<GetChatMessagesUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return GetChatMessagesUsecase(repository);
});

final sendMessageUsecaseProvider = Provider<SendMessageUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return SendMessageUsecase(repository);
});

final getCachedChatsUsecaseProvider = Provider<GetCachedChatsUsecase>((ref) {
  final repository = ref.watch(chatRepositoryProvider);
  return GetCachedChatsUsecase(repository);
});

// Chat state classes
class ChatState {
  final List<ChatEntity> chats;
  final bool isLoading;
  final String? error;

  ChatState({
    this.chats = const [],
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<ChatEntity>? chats,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      chats: chats ?? this.chats,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class MessageState {
  final List<MessageEntity> messages;
  final bool isLoading;
  final bool isSending;
  final String? error;
  final bool hasMore;
  final int currentPage;

  MessageState({
    this.messages = const [],
    this.isLoading = false,
    this.isSending = false,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
  });

  MessageState copyWith({
    List<MessageEntity>? messages,
    bool? isLoading,
    bool? isSending,
    String? error,
    bool? hasMore,
    int? currentPage,
  }) {
    return MessageState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

// Chat list provider
class ChatNotifier extends StateNotifier<ChatState> {
  final GetCachedChatsUsecase _getCachedChatsUsecase;
  final FindOrCreateChatUsecase _findOrCreateChatUsecase;

  ChatNotifier(
    this._getCachedChatsUsecase,
    this._findOrCreateChatUsecase,
  ) : super(ChatState());

  Future<void> loadChats() async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _getCachedChatsUsecase();
    
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: _mapFailureToMessage(failure),
      ),
      (chats) => state = state.copyWith(
        isLoading: false,
        chats: chats,
        error: null,
      ),
    );
  }

  Future<ChatEntity?> findOrCreateChat({
    required String user1Id,
    required String user2Id,
  }) async {
    final result = await _findOrCreateChatUsecase(
      user1Id: user1Id,
      user2Id: user2Id,
    );
    
    return result.fold(
      (failure) {
        state = state.copyWith(error: _mapFailureToMessage(failure));
        return null;
      },
      (chat) {
        // Update chats list
        final updatedChats = List<ChatEntity>.from(state.chats);
        final existingIndex = updatedChats.indexWhere((c) => c.id == chat.id);
        
        if (existingIndex != -1) {
          updatedChats[existingIndex] = chat;
        } else {
          updatedChats.insert(0, chat);
        }
        
        state = state.copyWith(chats: updatedChats, error: null);
        return chat;
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message ?? 'Server error occurred';
      case NetworkFailure:
        return 'Network error occurred';
      case ValidationFailure:
        return (failure as ValidationFailure).message ?? 'Validation error';
      case CacheFailure:
        return (failure as CacheFailure).message ?? 'Cache error occurred';
      default:
        return 'Unexpected error occurred';
    }
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final getCachedChatsUsecase = ref.watch(getCachedChatsUsecaseProvider);
  final findOrCreateChatUsecase = ref.watch(findOrCreateChatUsecaseProvider);
  return ChatNotifier(getCachedChatsUsecase, findOrCreateChatUsecase);
});

// Message provider
class MessageNotifier extends StateNotifier<MessageState> {
  final GetChatMessagesUsecase _getChatMessagesUsecase;
  final SendMessageUsecase _sendMessageUsecase;

  MessageNotifier(
    this._getChatMessagesUsecase,
    this._sendMessageUsecase,
  ) : super(MessageState());

  Future<void> loadMessages(int chatId) async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _getChatMessagesUsecase(chatId: chatId);
    
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: _mapFailureToMessage(failure),
      ),
      (messages) => state = state.copyWith(
        isLoading: false,
        messages: messages,
        error: null,
      ),
    );
  }

  Future<void> sendMessage({
    required String senderMobile,
    required String receiverMobile,
    required String content,
  }) async {
    state = state.copyWith(isSending: true, error: null);
    
    final result = await _sendMessageUsecase(
      senderMobile: senderMobile,
      receiverMobile: receiverMobile,
      content: content,
    );
    
    result.fold(
      (failure) => state = state.copyWith(
        isSending: false,
        error: _mapFailureToMessage(failure),
      ),
      (message) {
        final updatedMessages = List<MessageEntity>.from(state.messages);
        updatedMessages.add(message);
        
        state = state.copyWith(
          isSending: false,
          messages: updatedMessages,
          error: null,
        );
      },
    );
  }

  void addMessage(MessageEntity message) {
    final updatedMessages = List<MessageEntity>.from(state.messages);
    updatedMessages.add(message);
    state = state.copyWith(messages: updatedMessages);
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message ?? 'Server error occurred';
      case NetworkFailure:
        return 'Network error occurred';
      case ValidationFailure:
        return (failure as ValidationFailure).message ?? 'Validation error';
      case CacheFailure:
        return (failure as CacheFailure).message ?? 'Cache error occurred';
      default:
        return 'Unexpected error occurred';
    }
  }
}

final messageProvider = StateNotifierProvider<MessageNotifier, MessageState>((ref) {
  final getChatMessagesUsecase = ref.watch(getChatMessagesUsecaseProvider);
  final sendMessageUsecase = ref.watch(sendMessageUsecaseProvider);
  return MessageNotifier(getChatMessagesUsecase, sendMessageUsecase);
});