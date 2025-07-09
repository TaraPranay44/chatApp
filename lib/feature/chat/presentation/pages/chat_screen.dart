// features/chat/presentation/screens/chat_list_screen.dart
import 'package:chatapp/feature/auth/presentation/providers/auth_provider.dart';
import 'package:chatapp/feature/chat/domain/entities/message_entity,dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:chatapp/feature/chat/presentation/providers/chat_provider.dart';
import 'package:chatapp/feature/chat/domain/entities/chat_entity.dart';
import 'package:chatapp/core/router/app_router.dart';

class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key});

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with dummy data since chat list API is not ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chatProvider.notifier).initializeDummyChats();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    final filteredChats = ref.watch(filteredChatsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        title: const Text(
          'Chats',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              // Navigate to create new chat with dummy user
              _startNewChat();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2C2C2C),
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              onChanged: (value) {
                ref.read(chatProvider.notifier).searchChats(value);
              },
            ),
          ),
          // Chat List
          Expanded(
            child: _buildChatList(chatState, filteredChats),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startNewChat,
        backgroundColor: const Color(0xFF00D4AA),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildChatList(ChatState chatState, List<ChatEntity> filteredChats) {
    if (chatState.isLoading && !chatState.isRefreshing) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00D4AA)),
        ),
      );
    }

    if (chatState.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: ${chatState.error}',
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  ref.read(chatProvider.notifier).initializeDummyChats(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00D4AA),
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (chatState.isEmpty || filteredChats.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 16),
            Text(
              filteredChats.isEmpty && chatState.searchQuery != null
                  ? 'No chats found for "${chatState.searchQuery}"'
                  : 'No chats yet',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Start a conversation by tapping the + button',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(chatProvider.notifier).refreshChats(),
      backgroundColor: const Color(0xFF2C2C2C),
      color: const Color(0xFF00D4AA),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: filteredChats.length,
        itemBuilder: (context, index) {
          ref.read(authProvider).user?.phone;
          final chat = filteredChats[index];
          final currentUserId = ref.read(authProvider).user?.phone ??
              ''; // Current user's mobile number
          final otherUser = _getOtherUser(chat, currentUserId);
          final lastMessage = chat.lastMessage;

          return _buildChatItem(
            context,
            chat: chat,
            otherUser: otherUser,
            lastMessage: lastMessage,
          );
        },
      ),
    );
  }

  Widget _buildChatItem(
    BuildContext context, {
    required ChatEntity chat,
    required UserEntity otherUser,
    MessageEntity? lastMessage,
  }) {
    final timeString =
        _formatTime(lastMessage?.createdAt ?? chat.updatedAt ?? DateTime.now());
    final isOnline = otherUser.isActive ?? false;

    return InkWell(
      onTap: () => _navigateToChat(context, chat, otherUser),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[800]!,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFF00D4AA),
                  child: Text(
                    otherUser.username.isNotEmpty
                        ? otherUser.username[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFF1C1C1C), width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    otherUser.username.isNotEmpty
                        ? otherUser.username
                        : 'Unknown User',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage?.content ?? 'No messages yet',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  timeString,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                if (lastMessage != null && !lastMessage.isRead)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF00D4AA),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToChat(
      BuildContext context, ChatEntity chat, UserEntity otherUser) {
    context.goToChat(
      chatId: chat.id,
      chatName: otherUser.username,
      otherUserId: otherUser.mobile,
    );
  }

  void _startNewChat() async {
    // Since chat list API is not ready, we'll create a new dummy chat
    const dummyUserId = '7780451128'; // Another dummy user
    const dummyUserName = 'John Doe';

    final chat = await ref.read(chatProvider.notifier).findOrCreateChat(
          user1Id: '6280790883', // Current user
          user2Id: dummyUserId,
        );

    if (chat != null && mounted) {
      context.goToChat(
        chatId: chat.id,
        chatName: dummyUserName,
        otherUserId: dummyUserId,
      );
    }
  }

  // Helper methods
  UserEntity _getOtherUser(ChatEntity chat, String currentUserId) {
    if (chat.user1.mobile == currentUserId) {
      return chat.user2;
    } else {
      return chat.user1;
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      } else {
        return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      }
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Now';
    }
  }
}
