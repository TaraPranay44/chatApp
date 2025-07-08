// To parse this JSON data, do
//
//     final sendOtpResponse = sendOtpResponseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'send_otp_response.freezed.dart';
part 'send_otp_response.g.dart';

SendOtpResponse sendOtpResponseFromJson(String str) => SendOtpResponse.fromJson(json.decode(str));

String sendOtpResponseToJson(SendOtpResponse data) => json.encode(data.toJson());

@freezed
class SendOtpResponse with _$SendOtpResponse {
    const factory SendOtpResponse({
        String? message,
    }) = _SendOtpResponse;

    factory SendOtpResponse.fromJson(Map<String, dynamic> json) => _$SendOtpResponseFromJson(json);
}
