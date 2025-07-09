// features/chat/presentation/screens/individual_chat_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatapp/feature/chat/presentation/providers/chat_provider.dart';
import 'package:chatapp/feature/chat/presentation/widgets/message_bubble.dart';
import 'package:chatapp/feature/chat/presentation/widgets/chat_input.dart';

class IndividualChatScreen extends ConsumerStatefulWidget {
  final int chatId;

  const IndividualChatScreen({
    super.key,
    required this.chatId,
  });

  @override
  ConsumerState<IndividualChatScreen> createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends ConsumerState<IndividualChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(messageProvider.notifier).loadMessages(widget.chatId);
    });
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

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFF00D4AA),
              child: Text(
                'U',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User 2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Online',
                    style: TextStyle(
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
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // TODO: Show more options
            },
          ),
        ],
      ),
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

  Widget _buildMessagesList(MessageState messageState) {
    if (messageState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00D4AA)),
        ),
      );
    }

    if (messageState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: ${messageState.error}',
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _loadMessages(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (messageState.messages.isEmpty) {
      return const Center(
        child: Text(
          'No messages yet.\nSend a message to start the conversation!',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: messageState.messages.length,
      itemBuilder: (context, index) {
        final message = messageState.messages[index];
        return MessageBubble(
          message: message,
          isMe: message.senderId == 'current_user_mobile', // Replace with actual current user check
        );
      },
    );
  }

  void _sendMessage(String content) {
    if (content.trim().isEmpty) return;

    ref.read(messageProvider.notifier).sendMessage(
      senderMobile: 'current_user_mobile', // Replace with actual current user mobile
      receiverMobile: 'other_user_mobile', // Replace with actual other user mobile
      content: content,
    );

    _messageController.clear();
    _scrollToBottom();
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
}
