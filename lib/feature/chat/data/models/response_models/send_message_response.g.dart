// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SendMessageResponseImpl _$$SendMessageResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SendMessageResponseImpl(
      chatId: (json['chatId'] as num?)?.toInt(),
      message: json['message'] == null
          ? null
          : Message.fromJson(json['message'] as Map<String, dynamic>),
      chat: json['chat'] == null
          ? null
          : SendMessageResponseChat.fromJson(
              json['chat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SendMessageResponseImplToJson(
        _$SendMessageResponseImpl instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'message': instance.message,
      'chat': instance.chat,
    };

_$SendMessageResponseChatImpl _$$SendMessageResponseChatImplFromJson(
        Map<String, dynamic> json) =>
    _$SendMessageResponseChatImpl(
      id: (json['id'] as num?)?.toInt(),
      user1: json['user1'] == null
          ? null
          : User.fromJson(json['user1'] as Map<String, dynamic>),
      user2: json['user2'] == null
          ? null
          : User.fromJson(json['user2'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SendMessageResponseChatImplToJson(
        _$SendMessageResponseChatImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user1': instance.user1,
      'user2': instance.user2,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      mobile: json['mobile'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'username': instance.username,
      'password': instance.password,
      'isActive': instance.isActive,
    };

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: (json['id'] as num?)?.toInt(),
      chat: json['chat'] == null
          ? null
          : MessageChat.fromJson(json['chat'] as Map<String, dynamic>),
      sender: json['sender'] == null
          ? null
          : Sender.fromJson(json['sender'] as Map<String, dynamic>),
      content: json['content'] as String?,
      isSent: json['isSent'] as bool?,
      isDelivered: json['isDelivered'] as bool?,
      isReadByReceiver: json['isReadByReceiver'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      readAt: json['readAt'],
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chat': instance.chat,
      'sender': instance.sender,
      'content': instance.content,
      'isSent': instance.isSent,
      'isDelivered': instance.isDelivered,
      'isReadByReceiver': instance.isReadByReceiver,
      'createdAt': instance.createdAt?.toIso8601String(),
      'readAt': instance.readAt,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$MessageChatImpl _$$MessageChatImplFromJson(Map<String, dynamic> json) =>
    _$MessageChatImpl(
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MessageChatImplToJson(_$MessageChatImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

_$SenderImpl _$$SenderImplFromJson(Map<String, dynamic> json) => _$SenderImpl(
      mobile: json['mobile'] as String?,
    );

Map<String, dynamic> _$$SenderImplToJson(_$SenderImpl instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
    };
