// To parse this JSON data, do
//
//     final sendMessageResponse = sendMessageResponseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'send_message_response.freezed.dart';
part 'send_message_response.g.dart';

SendMessageResponse sendMessageResponseFromJson(String str) => SendMessageResponse.fromJson(json.decode(str));

String sendMessageResponseToJson(SendMessageResponse data) => json.encode(data.toJson());

@freezed
class SendMessageResponse with _$SendMessageResponse {
    const factory SendMessageResponse({
        int? chatId,
        Message? message,
        SendMessageResponseChat? chat,
    }) = _SendMessageResponse;

    factory SendMessageResponse.fromJson(Map<String, dynamic> json) => _$SendMessageResponseFromJson(json);
}

@freezed
class SendMessageResponseChat with _$SendMessageResponseChat {
    const factory SendMessageResponseChat({
        int? id,
        User? user1,
        User? user2,
    }) = _SendMessageResponseChat;

    factory SendMessageResponseChat.fromJson(Map<String, dynamic> json) => _$SendMessageResponseChatFromJson(json);
}

@freezed
class User with _$User {
    const factory User({
        String? mobile,
        String? username,
        String? password,
        bool? isActive,
    }) = _User;

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Message with _$Message {
    const factory Message({
        int? id,
        MessageChat? chat,
        Sender? sender,
        String? content,
        bool? isSent,
        bool? isDelivered,
        bool? isReadByReceiver,
        DateTime? createdAt,
        dynamic readAt,
        DateTime? updatedAt,
    }) = _Message;

    factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}

@freezed
class MessageChat with _$MessageChat {
    const factory MessageChat({
        int? id,
    }) = _MessageChat;

    factory MessageChat.fromJson(Map<String, dynamic> json) => _$MessageChatFromJson(json);
}

@freezed
class Sender with _$Sender {
    const factory Sender({
        String? mobile,
    }) = _Sender;

    factory Sender.fromJson(Map<String, dynamic> json) => _$SenderFromJson(json);
}
