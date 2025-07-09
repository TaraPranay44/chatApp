// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SendMessageRequestImpl _$$SendMessageRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SendMessageRequestImpl(
      senderMobile: json['senderMobile'] as String?,
      receiverMobile: json['receiverMobile'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$$SendMessageRequestImplToJson(
        _$SendMessageRequestImpl instance) =>
    <String, dynamic>{
      'senderMobile': instance.senderMobile,
      'receiverMobile': instance.receiverMobile,
      'content': instance.content,
    };
