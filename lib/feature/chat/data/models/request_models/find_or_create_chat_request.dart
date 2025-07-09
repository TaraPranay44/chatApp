// To parse this JSON data, do
//
//     final findOrCreateChatRequest = findOrCreateChatRequestFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'find_or_create_chat_request.freezed.dart';
part 'find_or_create_chat_request.g.dart';

FindOrCreateChatRequest findOrCreateChatRequestFromJson(String str) => FindOrCreateChatRequest.fromJson(json.decode(str));

String findOrCreateChatRequestToJson(FindOrCreateChatRequest data) => json.encode(data.toJson());

@freezed
class FindOrCreateChatRequest with _$FindOrCreateChatRequest {
    const factory FindOrCreateChatRequest({
        String? user1Id,
        String? user2Id,
    }) = _FindOrCreateChatRequest;

    factory FindOrCreateChatRequest.fromJson(Map<String, dynamic> json) => _$FindOrCreateChatRequestFromJson(json);
}
