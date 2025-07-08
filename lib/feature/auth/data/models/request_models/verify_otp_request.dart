// To parse this JSON data, do
//
//     final verifyOtpRequest = verifyOtpRequestFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'verify_otp_request.freezed.dart';
part 'verify_otp_request.g.dart';

VerifyOtpRequest verifyOtpRequestFromJson(String str) => VerifyOtpRequest.fromJson(json.decode(str));

String verifyOtpRequestToJson(VerifyOtpRequest data) => json.encode(data.toJson());

@freezed
class VerifyOtpRequest with _$VerifyOtpRequest {
    const factory VerifyOtpRequest({
        String? phone,
        String? email,
        String? code,
    }) = _VerifyOtpRequest;

    factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) => _$VerifyOtpRequestFromJson(json);
}
