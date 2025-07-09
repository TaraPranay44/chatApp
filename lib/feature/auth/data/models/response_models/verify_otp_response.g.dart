// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerifyOtpResponseImpl _$$VerifyOtpResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$VerifyOtpResponseImpl(
      accessToken: json['accessToken'] as String?,
      userCreated: json['userCreated'] as bool?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$VerifyOtpResponseImplToJson(
        _$VerifyOtpResponseImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'userCreated': instance.userCreated,
      'statusCode': instance.statusCode,
      'message': instance.message,
    };
