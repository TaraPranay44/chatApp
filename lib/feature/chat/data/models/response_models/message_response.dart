// To parse this JSON data, do
//
//     final messageResponse = messageResponseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'message_response.freezed.dart';
part 'message_response.g.dart';

MessageResponse messageResponseFromJson(String str) => MessageResponse.fromJson(json.decode(str));

String messageResponseToJson(MessageResponse data) => json.encode(data.toJson());

@freezed
class MessageResponse with _$MessageResponse {
    const factory MessageResponse({
        List<Message>? messages,
        int? total,
        int? page,
        int? totalPages,
    }) = _MessageResponse;

    factory MessageResponse.fromJson(Map<String, dynamic> json) => _$MessageResponseFromJson(json);
}

@freezed
class Message with _$Message {
    const factory Message({
        int? id,
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
class Sender with _$Sender {
    const factory Sender({
        String? mobile,
        String? username,
        String? password,
        bool? isActive,
    }) = _Sender;

    factory Sender.fromJson(Map<String, dynamic> json) => _$SenderFromJson(json);
}
