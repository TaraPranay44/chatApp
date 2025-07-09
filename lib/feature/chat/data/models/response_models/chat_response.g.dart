// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatResponseImpl _$$ChatResponseImplFromJson(Map<String, dynamic> json) =>
    _$ChatResponseImpl(
      id: (json['id'] as num?)?.toInt(),
      user1: json['user1'] == null
          ? null
          : User.fromJson(json['user1'] as Map<String, dynamic>),
      user2: json['user2'] == null
          ? null
          : User.fromJson(json['user2'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChatResponseImplToJson(_$ChatResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user1': instance.user1,
      'user2': instance.user2,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      mobile: json['mobile'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'username': instance.username,
      'password': instance.password,
      'isActive': instance.isActive,
    };
