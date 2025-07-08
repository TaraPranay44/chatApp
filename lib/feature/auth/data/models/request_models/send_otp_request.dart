// To parse this JSON data, do
//
//     final sendOtpRequest = sendOtpRequestFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'send_otp_request.freezed.dart';
part 'send_otp_request.g.dart';

SendOtpRequest sendOtpRequestFromJson(String str) => SendOtpRequest.fromJson(json.decode(str));

String sendOtpRequestToJson(SendOtpRequest data) => json.encode(data.toJson());

@freezed
class SendOtpRequest with _$SendOtpRequest {
    const factory SendOtpRequest({
        required String email,
        required String phone,
    }) = _SendOtpRequest;

    factory SendOtpRequest.fromJson(Map<String, dynamic> json) => _$SendOtpRequestFromJson(json);
}
