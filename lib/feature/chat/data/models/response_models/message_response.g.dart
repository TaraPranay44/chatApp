// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageResponseImpl _$$MessageResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageResponseImpl(
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MessageResponseImplToJson(
        _$MessageResponseImpl instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'total': instance.total,
      'page': instance.page,
      'totalPages': instance.totalPages,
    };

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: (json['id'] as num?)?.toInt(),
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
      'sender': instance.sender,
      'content': instance.content,
      'isSent': instance.isSent,
      'isDelivered': instance.isDelivered,
      'isReadByReceiver': instance.isReadByReceiver,
      'createdAt': instance.createdAt?.toIso8601String(),
      'readAt': instance.readAt,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$SenderImpl _$$SenderImplFromJson(Map<String, dynamic> json) => _$SenderImpl(
      mobile: json['mobile'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$$SenderImplToJson(_$SenderImpl instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'username': instance.username,
      'password': instance.password,
      'isActive': instance.isActive,
    };
