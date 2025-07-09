// features/chat/presentation/providers/chat_provider.dart
import 'package:chatapp/core/error/failures.dart';
import 'package:chatapp/core/network/api_client.dart';
import 'package:chatapp/core/storage/secure_storage.dart';
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

// Providers
final apiClientProvider = Provider<ApiClient>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return ApiClient(secureStorageService: secureStorage);
});

final chatRemoteDataSourceProvider = Provider<ChatRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ChatRemoteDataSourceImpl(apiClient);
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final remoteDataSource = ref.watch(chatRemoteDataSourceProvider);
  return ChatRepositoryImpl(remoteDataSource: remoteDataSource);
});

final findOrCreateChatUsecaseProvider =
    Provider<FindOrCreateChatUsecase>((ref) {
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

// Enhanced State Classes
enum ChatStateStatus { initial, loading, loaded, error, empty }

class ChatState {
  final List<ChatEntity> chats;
  final ChatStateStatus status;
  final String? error;
  final bool isRefreshing;
  final String? searchQuery;

  const ChatState({
    this.chats = const [],
    this.status = ChatStateStatus.initial,
    this.error,
    this.isRefreshing = false,
    this.searchQuery,
  });

  ChatState copyWith({
    List<ChatEntity>? chats,
    ChatStateStatus? status,
    String? error,
    bool? isRefreshing,
    String? searchQuery,
  }) {
    return ChatState(
      chats: chats ?? this.chats,
      status: status ?? this.status,
      error: error,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  // Helper getters
  bool get isLoading => status == ChatStateStatus.loading;
  bool get isLoaded => status == ChatStateStatus.loaded;
  bool get hasError => status == ChatStateStatus.error;
  bool get isEmpty => status == ChatStateStatus.empty;

  List<ChatEntity> get filteredChats {
    if (searchQuery == null || searchQuery!.isEmpty) {
      return chats;
    }
    return chats.where((chat) {
      final query = searchQuery!.toLowerCase();
      return chat.user1.username.toLowerCase().contains(query) ||
          chat.user2.username.toLowerCase().contains(query) ||
          (chat.lastMessage?.content.toLowerCase().contains(query) ?? false);
    }).toList();
  }
}

enum MessageStateStatus { initial, loading, loaded, error, empty }

class MessageState {
  final List<MessageEntity> messages;
  final MessageStateStatus status;
  final bool isSending;
  final String? error;
  final bool hasMore;
  final int currentPage;
  final int? currentChatId;

  const MessageState({
    this.messages = const [],
    this.status = MessageStateStatus.initial,
    this.isSending = false,
    this.error,
    this.hasMore = true,
    this.currentPage = 1,
    this.currentChatId,
  });

  MessageState copyWith({
    List<MessageEntity>? messages,
    MessageStateStatus? status,
    bool? isSending,
    String? error,
    bool? hasMore,
    int? currentPage,
    int? currentChatId,
  }) {
    return MessageState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      isSending: isSending ?? this.isSending,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      currentChatId: currentChatId ?? this.currentChatId,
    );
  }

  // Helper getters
  bool get isLoading => status == MessageStateStatus.loading;
  bool get isLoaded => status == MessageStateStatus.loaded;
  bool get hasError => status == MessageStateStatus.error;
  bool get isEmpty => status == MessageStateStatus.empty;
}

// Enhanced Chat Notifier
class ChatNotifier extends StateNotifier<ChatState> {
  final GetCachedChatsUsecase _getCachedChatsUsecase;
  final FindOrCreateChatUsecase _findOrCreateChatUsecase;

  ChatNotifier(
    this._getCachedChatsUsecase,
    this._findOrCreateChatUsecase,
  ) : super(const ChatState());

  // Initialize with dummy data since chat list API is not ready
  void initializeDummyChats() {
    final dummyChats = [
      ChatEntity(
        id: 1,
        user1: const UserEntity(
          mobile: '7780451128',
          username: 'You',
          isActive: true,
        ),
        user2: const UserEntity(
          mobile: '7780451128',
          username: 'Alice Smith',
          isActive: true,
        ),
        lastMessage: MessageEntity(
          id: 1,
          content: 'Hey! How are you doing?',
          senderId: '7780451128',
          receiverId: '6280790883',
          chatId: 1,
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          isRead: false,
        ),
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      ChatEntity(
        id: 2,
        user1: const UserEntity(
          mobile: '6280790883',
          username: 'You',
          isActive: true,
        ),
        user2: const UserEntity(
          mobile: '7780451128',
          username: 'John Doe',
          isActive: false,
        ),
        lastMessage: MessageEntity(
          id: 2,
          content: 'See you tomorrow!',
          senderId: '6280790883',
          receiverId: '7780451128',
          chatId: 2,
          createdAt: DateTime.now().subtract(const Duration(hours: 5)),
          isRead: true,
        ),
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
    ];

    state = state.copyWith(
      chats: dummyChats,
      status: ChatStateStatus.loaded,
      error: null,
    );
  }

  Future<void> loadChats() async {
    if (state.isLoading) return;

    state = state.copyWith(status: ChatStateStatus.loading, error: null);

    // For now, use dummy data since chat list API is not ready
    await Future.delayed(
        const Duration(milliseconds: 500)); // Simulate network delay
    initializeDummyChats();
  }

  Future<void> refreshChats() async {
    state = state.copyWith(isRefreshing: true);
    await loadChats();
    state = state.copyWith(isRefreshing: false);
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
        state = state.copyWith(
          status: ChatStateStatus.error,
          error: _mapFailureToMessage(failure),
        );
        return null;
      },
      (chat) {
        _updateChatInList(chat);
        return chat;
      },
    );
  }

  void updateChatLastMessage(int chatId, MessageEntity message) {
    final updatedChats = state.chats.map((chat) {
      if (chat.id == chatId) {
        return chat.copyWith(
          lastMessage: message,
          updatedAt: DateTime.now(),
        );
      }
      return chat;
    }).toList();

    // Sort by last message time
    updatedChats.sort((a, b) => (b.lastMessage?.createdAt ??
            b.updatedAt ??
            DateTime.now())
        .compareTo(a.lastMessage?.createdAt ?? a.updatedAt ?? DateTime.now()));

    state = state.copyWith(chats: updatedChats);
  }

  void searchChats(String query) {
    state = state.copyWith(searchQuery: query.isEmpty ? null : query);
  }

  void clearSearch() {
    state = state.copyWith(searchQuery: null);
  }

  void _updateChatInList(ChatEntity chat) {
    final updatedChats = List<ChatEntity>.from(state.chats);
    final existingIndex = updatedChats.indexWhere((c) => c.id == chat.id);

    if (existingIndex != -1) {
      updatedChats[existingIndex] = chat;
    } else {
      updatedChats.insert(0, chat);
    }

    // Sort by last message time
    updatedChats.sort((a, b) => (b.lastMessage?.createdAt ??
            b.updatedAt ??
            DateTime.now())
        .compareTo(a.lastMessage?.createdAt ?? a.updatedAt ?? DateTime.now()));

    state = state.copyWith(
      chats: updatedChats,
      status: ChatStateStatus.loaded,
      error: null,
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message ?? 'Server error occurred';
      case NetworkFailure:
        return 'Network error occurred. Please check your connection.';
      case ValidationFailure:
        return (failure as ValidationFailure).message ?? 'Validation error';
      case CacheFailure:
        return 'Cache error occurred';
      default:
        return 'An unexpected error occurred';
    }
  }
}

// Enhanced Message Notifier
class MessageNotifier extends StateNotifier<MessageState> {
  final GetChatMessagesUsecase _getChatMessagesUsecase;
  final SendMessageUsecase _sendMessageUsecase;

  MessageNotifier(
    this._getChatMessagesUsecase,
    this._sendMessageUsecase,
  ) : super(const MessageState());

  Future<void> loadMessages(int chatId) async {
    if (state.isLoading && state.currentChatId == chatId) return;

    state = state.copyWith(
      status: MessageStateStatus.loading,
      error: null,
      currentChatId: chatId,
      currentPage: 1,
      messages: [], // Clear previous messages when loading new chat
    );

    final result = await _getChatMessagesUsecase(chatId: chatId);

    result.fold(
      (failure) => state = state.copyWith(
        status: MessageStateStatus.error,
        error: _mapFailureToMessage(failure),
      ),
      (messages) {
        // Sort messages by creation time (oldest first for chat display)
        final sortedMessages = List<MessageEntity>.from(messages);
        sortedMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

        state = state.copyWith(
          status: sortedMessages.isEmpty
              ? MessageStateStatus.empty
              : MessageStateStatus.loaded,
          messages: sortedMessages,
          error: null,
        );
      },
    );
  }

  Future<void> refreshMessages() async {
    if (state.currentChatId != null) {
      await loadMessages(state.currentChatId!);
    }
  }

  Future<void> sendMessage({
    required String senderMobile,
    required String receiverMobile,
    required String content,
  }) async {
    if (state.isSending) return;

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
          status: MessageStateStatus.loaded,
          error: null,
        );
      },
    );
  }

  void addMessage(MessageEntity message) {
    final updatedMessages = List<MessageEntity>.from(state.messages);
    updatedMessages.add(message);

    state = state.copyWith(
      messages: updatedMessages,
      status: MessageStateStatus.loaded,
    );
  }

  void clearMessages() {
    state = const MessageState();
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message ?? 'Server error occurred';
      case NetworkFailure:
        return 'Network error occurred. Please check your connection.';
      case ValidationFailure:
        return (failure as ValidationFailure).message ?? 'Validation error';
      case CacheFailure:
        return 'Cache error occurred';
      default:
        return 'An unexpected error occurred';
    }
  }
}

// State Notifier Providers
final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final getCachedChatsUsecase = ref.watch(getCachedChatsUsecaseProvider);
  final findOrCreateChatUsecase = ref.watch(findOrCreateChatUsecaseProvider);
  return ChatNotifier(getCachedChatsUsecase, findOrCreateChatUsecase);
});

final messageProvider =
    StateNotifierProvider<MessageNotifier, MessageState>((ref) {
  final getChatMessagesUsecase = ref.watch(getChatMessagesUsecaseProvider);
  final sendMessageUsecase = ref.watch(sendMessageUsecaseProvider);
  return MessageNotifier(getChatMessagesUsecase, sendMessageUsecase);
});

// Helper providers for specific states
final chatLoadingProvider = Provider<bool>((ref) {
  return ref.watch(chatProvider.select((state) => state.isLoading));
});

final chatErrorProvider = Provider<String?>((ref) {
  return ref.watch(chatProvider.select((state) => state.error));
});

final filteredChatsProvider = Provider<List<ChatEntity>>((ref) {
  return ref.watch(chatProvider.select((state) => state.filteredChats));
});

final messageLoadingProvider = Provider<bool>((ref) {
  return ref.watch(messageProvider.select((state) => state.isLoading));
});

final messageSendingProvider = Provider<bool>((ref) {
  return ref.watch(messageProvider.select((state) => state.isSending));
});

final messageErrorProvider = Provider<String?>((ref) {
  return ref.watch(messageProvider.select((state) => state.error));
});
