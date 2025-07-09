// features/chat/domain/entities/chat_entity.dart
import 'package:chatapp/feature/chat/domain/entities/message_entity,dart';
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final int id;
  final UserEntity user1;
  final UserEntity user2;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final MessageEntity? lastMessage;

  const ChatEntity({
    required this.id,
    required this.user1,
    required this.user2,
    this.createdAt,
    this.updatedAt,
    this.lastMessage,
  });

  @override
  List<Object?> get props => [
    id,
    user1,
    user2,
    createdAt,
    updatedAt,
    lastMessage,
  ];

  ChatEntity copyWith({
    int? id,
    UserEntity? user1,
    UserEntity? user2,
    DateTime? createdAt,
    DateTime? updatedAt,
    MessageEntity? lastMessage,
  }) {
    return ChatEntity(
      id: id ?? this.id,
      user1: user1 ?? this.user1,
      user2: user2 ?? this.user2,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  // Get the other user (not the current user)
  UserEntity getOtherUser(String currentUserId) {
    return user1.mobile == currentUserId ? user2 : user1;
  }
}

class UserEntity extends Equatable {
  final String mobile;
  final String username;
  final String? password;
  final bool? isActive;
  final String? email;
  final String? avatar;
  final bool isOnline;
  final DateTime? lastSeen;

  const UserEntity({
    required this.mobile,
    required this.username,
    this.password,
    this.isActive,
    this.email,
    this.avatar,
    this.isOnline = false,
    this.lastSeen,
  });

  @override
  List<Object?> get props => [
    mobile,
    username,
    password,
    isActive,
    email,
    avatar,
    isOnline,
    lastSeen,
  ];

  UserEntity copyWith({
    String? mobile,
    String? username,
    String? password,
    bool? isActive,
    String? email,
    String? avatar,
    bool? isOnline,
    DateTime? lastSeen,
  }) {
    return UserEntity(
      mobile: mobile ?? this.mobile,
      username: username ?? this.username,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
}