// To parse this JSON data, do
//
//     final sendMessageRequest = sendMessageRequestFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'send_message_request.freezed.dart';
part 'send_message_request.g.dart';

SendMessageRequest sendMessageRequestFromJson(String str) => SendMessageRequest.fromJson(json.decode(str));

String sendMessageRequestToJson(SendMessageRequest data) => json.encode(data.toJson());

@freezed
class SendMessageRequest with _$SendMessageRequest {
    const factory SendMessageRequest({
        String? senderMobile,
        String? receiverMobile,
        String? content,
    }) = _SendMessageRequest;

    factory SendMessageRequest.fromJson(Map<String, dynamic> json) => _$SendMessageRequestFromJson(json);
}
