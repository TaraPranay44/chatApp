// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'find_or_create_chat_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FindOrCreateChatRequest _$FindOrCreateChatRequestFromJson(
    Map<String, dynamic> json) {
  return _FindOrCreateChatRequest.fromJson(json);
}

/// @nodoc
mixin _$FindOrCreateChatRequest {
  String? get user1Id => throw _privateConstructorUsedError;
  String? get user2Id => throw _privateConstructorUsedError;

  /// Serializes this FindOrCreateChatRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FindOrCreateChatRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FindOrCreateChatRequestCopyWith<FindOrCreateChatRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FindOrCreateChatRequestCopyWith<$Res> {
  factory $FindOrCreateChatRequestCopyWith(FindOrCreateChatRequest value,
          $Res Function(FindOrCreateChatRequest) then) =
      _$FindOrCreateChatRequestCopyWithImpl<$Res, FindOrCreateChatRequest>;
  @useResult
  $Res call({String? user1Id, String? user2Id});
}

/// @nodoc
class _$FindOrCreateChatRequestCopyWithImpl<$Res,
        $Val extends FindOrCreateChatRequest>
    implements $FindOrCreateChatRequestCopyWith<$Res> {
  _$FindOrCreateChatRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FindOrCreateChatRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user1Id = freezed,
    Object? user2Id = freezed,
  }) {
    return _then(_value.copyWith(
      user1Id: freezed == user1Id
          ? _value.user1Id
          : user1Id // ignore: cast_nullable_to_non_nullable
              as String?,
      user2Id: freezed == user2Id
          ? _value.user2Id
          : user2Id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FindOrCreateChatRequestImplCopyWith<$Res>
    implements $FindOrCreateChatRequestCopyWith<$Res> {
  factory _$$FindOrCreateChatRequestImplCopyWith(
          _$FindOrCreateChatRequestImpl value,
          $Res Function(_$FindOrCreateChatRequestImpl) then) =
      __$$FindOrCreateChatRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? user1Id, String? user2Id});
}

/// @nodoc
class __$$FindOrCreateChatRequestImplCopyWithImpl<$Res>
    extends _$FindOrCreateChatRequestCopyWithImpl<$Res,
        _$FindOrCreateChatRequestImpl>
    implements _$$FindOrCreateChatRequestImplCopyWith<$Res> {
  __$$FindOrCreateChatRequestImplCopyWithImpl(
      _$FindOrCreateChatRequestImpl _value,
      $Res Function(_$FindOrCreateChatRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of FindOrCreateChatRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user1Id = freezed,
    Object? user2Id = freezed,
  }) {
    return _then(_$FindOrCreateChatRequestImpl(
      user1Id: freezed == user1Id
          ? _value.user1Id
          : user1Id // ignore: cast_nullable_to_non_nullable
              as String?,
      user2Id: freezed == user2Id
          ? _value.user2Id
          : user2Id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FindOrCreateChatRequestImpl implements _FindOrCreateChatRequest {
  const _$FindOrCreateChatRequestImpl({this.user1Id, this.user2Id});

  factory _$FindOrCreateChatRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$FindOrCreateChatRequestImplFromJson(json);

  @override
  final String? user1Id;
  @override
  final String? user2Id;

  @override
  String toString() {
    return 'FindOrCreateChatRequest(user1Id: $user1Id, user2Id: $user2Id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FindOrCreateChatRequestImpl &&
            (identical(other.user1Id, user1Id) || other.user1Id == user1Id) &&
            (identical(other.user2Id, user2Id) || other.user2Id == user2Id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user1Id, user2Id);

  /// Create a copy of FindOrCreateChatRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FindOrCreateChatRequestImplCopyWith<_$FindOrCreateChatRequestImpl>
      get copyWith => __$$FindOrCreateChatRequestImplCopyWithImpl<
          _$FindOrCreateChatRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FindOrCreateChatRequestImplToJson(
      this,
    );
  }
}

abstract class _FindOrCreateChatRequest implements FindOrCreateChatRequest {
  const factory _FindOrCreateChatRequest(
      {final String? user1Id,
      final String? user2Id}) = _$FindOrCreateChatRequestImpl;

  factory _FindOrCreateChatRequest.fromJson(Map<String, dynamic> json) =
      _$FindOrCreateChatRequestImpl.fromJson;

  @override
  String? get user1Id;
  @override
  String? get user2Id;

  /// Create a copy of FindOrCreateChatRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FindOrCreateChatRequestImplCopyWith<_$FindOrCreateChatRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
