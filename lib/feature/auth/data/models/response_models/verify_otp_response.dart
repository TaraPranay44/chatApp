// To parse this JSON data, do
//
//     final verifyOtpResponse = verifyOtpResponseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'verify_otp_response.freezed.dart';
part 'verify_otp_response.g.dart';

VerifyOtpResponse verifyOtpResponseFromJson(String str) => VerifyOtpResponse.fromJson(json.decode(str));

String verifyOtpResponseToJson(VerifyOtpResponse data) => json.encode(data.toJson());

@freezed
class VerifyOtpResponse with _$VerifyOtpResponse {
    const factory VerifyOtpResponse({
        String? accessToken,
        bool? userCreated,
        int? statusCode,
        String? message,
    }) = _VerifyOtpResponse;

    factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) => _$VerifyOtpResponseFromJson(json);
}
