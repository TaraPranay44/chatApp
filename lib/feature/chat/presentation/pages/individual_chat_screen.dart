
// features/chat/presentation/screens/individual_chat_screen.dart
import 'package:chatapp/feature/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:chatapp/feature/chat/presentation/providers/chat_provider.dart';
import 'package:chatapp/feature/chat/presentation/widgets/message_bubble.dart';
import 'package:chatapp/feature/chat/presentation/widgets/chat_input.dart';

class IndividualChatScreen extends ConsumerStatefulWidget {
  final int chatId;
  final String chatName;
  final String otherUserId;

  const IndividualChatScreen({
    super.key,
    required this.chatId,
    required this.chatName,
    required this.otherUserId,
  });

  @override
  ConsumerState<IndividualChatScreen> createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends ConsumerState<IndividualChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final String currentUserId;

  @override
  void initState() {
    super.initState();
    currentUserId = ref.read(authProvider).user!.id; // Replace with actual current user ID
    _loadMessages();
    _setupScrollListener();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // Load more messages when scrolled to top
        _loadMoreMessages();
      }
    });
  }

  void _loadMessages() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(messageProvider.notifier).loadMessages(widget.chatId);
    });
  }

  void _loadMoreMessages() {
    final messageState = ref.read(messageProvider);
    if (messageState.hasMore && !messageState.isLoading) {
      // TODO: Implement pagination when backend supports it
      // ref.read(messageProvider.notifier).loadMoreMessages(widget.chatId);
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageState = ref.watch(messageProvider);
    final chatState = ref.watch(chatProvider);

    // Listen for message state changes to update chat list
    ref.listen<MessageState>(messageProvider, (previous, next) {
      if (previous?.messages.length != next.messages.length && next.messages.isNotEmpty) {
        // Update the chat list with the latest message
        final latestMessage = next.messages.last;
        ref.read(chatProvider.notifier).updateChatLastMessage(widget.chatId, latestMessage);
        
        // Scroll to bottom when new message is added
        _scrollToBottom();
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: _buildMessagesList(messageState),
          ),
          // Message Input
          ChatInput(
            controller: _messageController,
            onSendMessage: _sendMessage,
            isLoading: messageState.isSending,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF1C1C1C),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => context.pop(),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF00D4AA),
            child: Text(
              widget.chatName.isNotEmpty ? widget.chatName[0].toUpperCase() : '?',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatName.isNotEmpty ? widget.chatName : 'Unknown User',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _getOnlineStatus(),
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.videocam, color: Colors.white),
          onPressed: () {
            // TODO: Implement video call
            _showFeatureNotImplemented('Video call');
          },
        ),
        IconButton(
          icon: const Icon(Icons.call, color: Colors.white),
          onPressed: () {
            // TODO: Implement voice call
            _showFeatureNotImplemented('Voice call');
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onPressed: () {
            _showMoreOptions();
          },
        ),
      ],
    );
  }

  Widget _buildMessagesList(MessageState messageState) {
    if (messageState.isLoading && messageState.messages.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00D4AA)),
        ),
      );
    }

    if (messageState.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Error: ${messageState.error}',
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _loadMessages(),
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

    if (messageState.isEmpty) {
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
            const Text(
              'No messages yet.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Send a message to start the conversation!',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(messageProvider.notifier).refreshMessages(),
      backgroundColor: const Color(0xFF2C2C2C),
      color: const Color(0xFF00D4AA),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: messageState.messages.length + (messageState.isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == 0 && messageState.isLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00D4AA)),
                ),
              ),
            );
          }

          final messageIndex = messageState.isLoading ? index - 1 : index;
          final message = messageState.messages[messageIndex];
          final isMe = message.senderId == currentUserId;

          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: MessageBubble(
              message: message,
              isMe: isMe,
            ),
          );
        },
      ),
    );
  }

  void _sendMessage(String content) {
    if (content.trim().isEmpty) return;

    ref.read(messageProvider.notifier).sendMessage(
      senderMobile: currentUserId,
      receiverMobile: widget.otherUserId,
      content: content.trim(),
    );

    _messageController.clear();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getOnlineStatus() {
    // TODO: Implement real online status
    return 'Online';
  }

  void _showFeatureNotImplemented(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature is not implemented yet'),
        backgroundColor: const Color(0xFF2C2C2C),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.white),
            title: const Text('Chat Info', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              _showFeatureNotImplemented('Chat info');
            },
          ),
          ListTile(
            leading: const Icon(Icons.search, color: Colors.white),
            title: const Text('Search Messages', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              _showFeatureNotImplemented('Search messages');
            },
          ),
          ListTile(
            leading: const Icon(Icons.block, color: Colors.red),
            title: const Text('Block User', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              _showFeatureNotImplemented('Block user');
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Delete Chat', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              _showDeleteConfirmation();
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2C),
        title: const Text('Delete Chat', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to delete this chat? This action cannot be undone.',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showFeatureNotImplemented('Delete chat');
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}