// To parse this JSON data, do
//
//     final chatResponse = chatResponseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'chat_response.freezed.dart';
part 'chat_response.g.dart';

ChatResponse chatResponseFromJson(String str) => ChatResponse.fromJson(json.decode(str));

String chatResponseToJson(ChatResponse data) => json.encode(data.toJson());

@freezed
class ChatResponse with _$ChatResponse {
    const factory ChatResponse({
        int? id,
        User? user1,
        User? user2,
    }) = _ChatResponse;

    factory ChatResponse.fromJson(Map<String, dynamic> json) => _$ChatResponseFromJson(json);
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
