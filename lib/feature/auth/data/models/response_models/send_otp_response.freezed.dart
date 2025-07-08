// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_otp_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SendOtpResponse _$SendOtpResponseFromJson(Map<String, dynamic> json) {
  return _SendOtpResponse.fromJson(json);
}

/// @nodoc
mixin _$SendOtpResponse {
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this SendOtpResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SendOtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SendOtpResponseCopyWith<SendOtpResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendOtpResponseCopyWith<$Res> {
  factory $SendOtpResponseCopyWith(
          SendOtpResponse value, $Res Function(SendOtpResponse) then) =
      _$SendOtpResponseCopyWithImpl<$Res, SendOtpResponse>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class _$SendOtpResponseCopyWithImpl<$Res, $Val extends SendOtpResponse>
    implements $SendOtpResponseCopyWith<$Res> {
  _$SendOtpResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SendOtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SendOtpResponseImplCopyWith<$Res>
    implements $SendOtpResponseCopyWith<$Res> {
  factory _$$SendOtpResponseImplCopyWith(_$SendOtpResponseImpl value,
          $Res Function(_$SendOtpResponseImpl) then) =
      __$$SendOtpResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$SendOtpResponseImplCopyWithImpl<$Res>
    extends _$SendOtpResponseCopyWithImpl<$Res, _$SendOtpResponseImpl>
    implements _$$SendOtpResponseImplCopyWith<$Res> {
  __$$SendOtpResponseImplCopyWithImpl(
      _$SendOtpResponseImpl _value, $Res Function(_$SendOtpResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SendOtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$SendOtpResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendOtpResponseImpl implements _SendOtpResponse {
  const _$SendOtpResponseImpl({this.message});

  factory _$SendOtpResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendOtpResponseImplFromJson(json);

  @override
  final String? message;

  @override
  String toString() {
    return 'SendOtpResponse(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendOtpResponseImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SendOtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendOtpResponseImplCopyWith<_$SendOtpResponseImpl> get copyWith =>
      __$$SendOtpResponseImplCopyWithImpl<_$SendOtpResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendOtpResponseImplToJson(
      this,
    );
  }
}

abstract class _SendOtpResponse implements SendOtpResponse {
  const factory _SendOtpResponse({final String? message}) =
      _$SendOtpResponseImpl;

  factory _SendOtpResponse.fromJson(Map<String, dynamic> json) =
      _$SendOtpResponseImpl.fromJson;

  @override
  String? get message;

  /// Create a copy of SendOtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendOtpResponseImplCopyWith<_$SendOtpResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
