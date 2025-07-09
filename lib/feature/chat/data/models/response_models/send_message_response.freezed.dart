// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_message_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SendMessageResponse _$SendMessageResponseFromJson(Map<String, dynamic> json) {
  return _SendMessageResponse.fromJson(json);
}

/// @nodoc
mixin _$SendMessageResponse {
  int? get chatId => throw _privateConstructorUsedError;
  Message? get message => throw _privateConstructorUsedError;
  SendMessageResponseChat? get chat => throw _privateConstructorUsedError;

  /// Serializes this SendMessageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SendMessageResponseCopyWith<SendMessageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendMessageResponseCopyWith<$Res> {
  factory $SendMessageResponseCopyWith(
          SendMessageResponse value, $Res Function(SendMessageResponse) then) =
      _$SendMessageResponseCopyWithImpl<$Res, SendMessageResponse>;
  @useResult
  $Res call({int? chatId, Message? message, SendMessageResponseChat? chat});

  $MessageCopyWith<$Res>? get message;
  $SendMessageResponseChatCopyWith<$Res>? get chat;
}

/// @nodoc
class _$SendMessageResponseCopyWithImpl<$Res, $Val extends SendMessageResponse>
    implements $SendMessageResponseCopyWith<$Res> {
  _$SendMessageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = freezed,
    Object? message = freezed,
    Object? chat = freezed,
  }) {
    return _then(_value.copyWith(
      chatId: freezed == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message?,
      chat: freezed == chat
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as SendMessageResponseChat?,
    ) as $Val);
  }

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageCopyWith<$Res>? get message {
    if (_value.message == null) {
      return null;
    }

    return $MessageCopyWith<$Res>(_value.message!, (value) {
      return _then(_value.copyWith(message: value) as $Val);
    });
  }

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SendMessageResponseChatCopyWith<$Res>? get chat {
    if (_value.chat == null) {
      return null;
    }

    return $SendMessageResponseChatCopyWith<$Res>(_value.chat!, (value) {
      return _then(_value.copyWith(chat: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SendMessageResponseImplCopyWith<$Res>
    implements $SendMessageResponseCopyWith<$Res> {
  factory _$$SendMessageResponseImplCopyWith(_$SendMessageResponseImpl value,
          $Res Function(_$SendMessageResponseImpl) then) =
      __$$SendMessageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? chatId, Message? message, SendMessageResponseChat? chat});

  @override
  $MessageCopyWith<$Res>? get message;
  @override
  $SendMessageResponseChatCopyWith<$Res>? get chat;
}

/// @nodoc
class __$$SendMessageResponseImplCopyWithImpl<$Res>
    extends _$SendMessageResponseCopyWithImpl<$Res, _$SendMessageResponseImpl>
    implements _$$SendMessageResponseImplCopyWith<$Res> {
  __$$SendMessageResponseImplCopyWithImpl(_$SendMessageResponseImpl _value,
      $Res Function(_$SendMessageResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = freezed,
    Object? message = freezed,
    Object? chat = freezed,
  }) {
    return _then(_$SendMessageResponseImpl(
      chatId: freezed == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as Message?,
      chat: freezed == chat
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as SendMessageResponseChat?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendMessageResponseImpl implements _SendMessageResponse {
  const _$SendMessageResponseImpl({this.chatId, this.message, this.chat});

  factory _$SendMessageResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendMessageResponseImplFromJson(json);

  @override
  final int? chatId;
  @override
  final Message? message;
  @override
  final SendMessageResponseChat? chat;

  @override
  String toString() {
    return 'SendMessageResponse(chatId: $chatId, message: $message, chat: $chat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMessageResponseImpl &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.chat, chat) || other.chat == chat));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chatId, message, chat);

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMessageResponseImplCopyWith<_$SendMessageResponseImpl> get copyWith =>
      __$$SendMessageResponseImplCopyWithImpl<_$SendMessageResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendMessageResponseImplToJson(
      this,
    );
  }
}

abstract class _SendMessageResponse implements SendMessageResponse {
  const factory _SendMessageResponse(
      {final int? chatId,
      final Message? message,
      final SendMessageResponseChat? chat}) = _$SendMessageResponseImpl;

  factory _SendMessageResponse.fromJson(Map<String, dynamic> json) =
      _$SendMessageResponseImpl.fromJson;

  @override
  int? get chatId;
  @override
  Message? get message;
  @override
  SendMessageResponseChat? get chat;

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendMessageResponseImplCopyWith<_$SendMessageResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SendMessageResponseChat _$SendMessageResponseChatFromJson(
    Map<String, dynamic> json) {
  return _SendMessageResponseChat.fromJson(json);
}

/// @nodoc
mixin _$SendMessageResponseChat {
  int? get id => throw _privateConstructorUsedError;
  User? get user1 => throw _privateConstructorUsedError;
  User? get user2 => throw _privateConstructorUsedError;

  /// Serializes this SendMessageResponseChat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SendMessageResponseChat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SendMessageResponseChatCopyWith<SendMessageResponseChat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendMessageResponseChatCopyWith<$Res> {
  factory $SendMessageResponseChatCopyWith(SendMessageResponseChat value,
          $Res Function(SendMessageResponseChat) then) =
      _$SendMessageResponseChatCopyWithImpl<$Res, SendMessageResponseChat>;
  @useResult
  $Res call({int? id, User? user1, User? user2});

  $UserCopyWith<$Res>? get user1;
  $UserCopyWith<$Res>? get user2;
}

/// @nodoc
class _$SendMessageResponseChatCopyWithImpl<$Res,
        $Val extends SendMessageResponseChat>
    implements $SendMessageResponseChatCopyWith<$Res> {
  _$SendMessageResponseChatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SendMessageResponseChat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user1 = freezed,
    Object? user2 = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user1: freezed == user1
          ? _value.user1
          : user1 // ignore: cast_nullable_to_non_nullable
              as User?,
      user2: freezed == user2
          ? _value.user2
          : user2 // ignore: cast_nullable_to_non_nullable
              as User?,
    ) as $Val);
  }

  /// Create a copy of SendMessageResponseChat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user1 {
    if (_value.user1 == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user1!, (value) {
      return _then(_value.copyWith(user1: value) as $Val);
    });
  }

  /// Create a copy of SendMessageResponseChat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user2 {
    if (_value.user2 == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user2!, (value) {
      return _then(_value.copyWith(user2: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SendMessageResponseChatImplCopyWith<$Res>
    implements $SendMessageResponseChatCopyWith<$Res> {
  factory _$$SendMessageResponseChatImplCopyWith(
          _$SendMessageResponseChatImpl value,
          $Res Function(_$SendMessageResponseChatImpl) then) =
      __$$SendMessageResponseChatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, User? user1, User? user2});

  @override
  $UserCopyWith<$Res>? get user1;
  @override
  $UserCopyWith<$Res>? get user2;
}

/// @nodoc
class __$$SendMessageResponseChatImplCopyWithImpl<$Res>
    extends _$SendMessageResponseChatCopyWithImpl<$Res,
        _$SendMessageResponseChatImpl>
    implements _$$SendMessageResponseChatImplCopyWith<$Res> {
  __$$SendMessageResponseChatImplCopyWithImpl(
      _$SendMessageResponseChatImpl _value,
      $Res Function(_$SendMessageResponseChatImpl) _then)
      : super(_value, _then);

  /// Create a copy of SendMessageResponseChat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user1 = freezed,
    Object? user2 = freezed,
  }) {
    return _then(_$SendMessageResponseChatImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user1: freezed == user1
          ? _value.user1
          : user1 // ignore: cast_nullable_to_non_nullable
              as User?,
      user2: freezed == user2
          ? _value.user2
          : user2 // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendMessageResponseChatImpl implements _SendMessageResponseChat {
  const _$SendMessageResponseChatImpl({this.id, this.user1, this.user2});

  factory _$SendMessageResponseChatImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendMessageResponseChatImplFromJson(json);

  @override
  final int? id;
  @override
  final User? user1;
  @override
  final User? user2;

  @override
  String toString() {
    return 'SendMessageResponseChat(id: $id, user1: $user1, user2: $user2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMessageResponseChatImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user1, user1) || other.user1 == user1) &&
            (identical(other.user2, user2) || other.user2 == user2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, user1, user2);

  /// Create a copy of SendMessageResponseChat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMessageResponseChatImplCopyWith<_$SendMessageResponseChatImpl>
      get copyWith => __$$SendMessageResponseChatImplCopyWithImpl<
          _$SendMessageResponseChatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendMessageResponseChatImplToJson(
      this,
    );
  }
}

abstract class _SendMessageResponseChat implements SendMessageResponseChat {
  const factory _SendMessageResponseChat(
      {final int? id,
      final User? user1,
      final User? user2}) = _$SendMessageResponseChatImpl;

  factory _SendMessageResponseChat.fromJson(Map<String, dynamic> json) =
      _$SendMessageResponseChatImpl.fromJson;

  @override
  int? get id;
  @override
  User? get user1;
  @override
  User? get user2;

  /// Create a copy of SendMessageResponseChat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendMessageResponseChatImplCopyWith<_$SendMessageResponseChatImpl>
      get copyWith => throw _privateConstructorUsedError;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String? get mobile => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String? mobile, String? username, String? password, bool? isActive});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mobile = freezed,
    Object? username = freezed,
    Object? password = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_value.copyWith(
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? mobile, String? username, String? password, bool? isActive});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mobile = freezed,
    Object? username = freezed,
    Object? password = freezed,
    Object? isActive = freezed,
  }) {
    return _then(_$UserImpl(
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl({this.mobile, this.username, this.password, this.isActive});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String? mobile;
  @override
  final String? username;
  @override
  final String? password;
  @override
  final bool? isActive;

  @override
  String toString() {
    return 'User(mobile: $mobile, username: $username, password: $password, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, mobile, username, password, isActive);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {final String? mobile,
      final String? username,
      final String? password,
      final bool? isActive}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String? get mobile;
  @override
  String? get username;
  @override
  String? get password;
  @override
  bool? get isActive;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  int? get id => throw _privateConstructorUsedError;
  MessageChat? get chat => throw _privateConstructorUsedError;
  Sender? get sender => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  bool? get isSent => throw _privateConstructorUsedError;
  bool? get isDelivered => throw _privateConstructorUsedError;
  bool? get isReadByReceiver => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  dynamic get readAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {int? id,
      MessageChat? chat,
      Sender? sender,
      String? content,
      bool? isSent,
      bool? isDelivered,
      bool? isReadByReceiver,
      DateTime? createdAt,
      dynamic readAt,
      DateTime? updatedAt});

  $MessageChatCopyWith<$Res>? get chat;
  $SenderCopyWith<$Res>? get sender;
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? chat = freezed,
    Object? sender = freezed,
    Object? content = freezed,
    Object? isSent = freezed,
    Object? isDelivered = freezed,
    Object? isReadByReceiver = freezed,
    Object? createdAt = freezed,
    Object? readAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      chat: freezed == chat
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as MessageChat?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as Sender?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      isSent: freezed == isSent
          ? _value.isSent
          : isSent // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDelivered: freezed == isDelivered
          ? _value.isDelivered
          : isDelivered // ignore: cast_nullable_to_non_nullable
              as bool?,
      isReadByReceiver: freezed == isReadByReceiver
          ? _value.isReadByReceiver
          : isReadByReceiver // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageChatCopyWith<$Res>? get chat {
    if (_value.chat == null) {
      return null;
    }

    return $MessageChatCopyWith<$Res>(_value.chat!, (value) {
      return _then(_value.copyWith(chat: value) as $Val);
    });
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SenderCopyWith<$Res>? get sender {
    if (_value.sender == null) {
      return null;
    }

    return $SenderCopyWith<$Res>(_value.sender!, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      MessageChat? chat,
      Sender? sender,
      String? content,
      bool? isSent,
      bool? isDelivered,
      bool? isReadByReceiver,
      DateTime? createdAt,
      dynamic readAt,
      DateTime? updatedAt});

  @override
  $MessageChatCopyWith<$Res>? get chat;
  @override
  $SenderCopyWith<$Res>? get sender;
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? chat = freezed,
    Object? sender = freezed,
    Object? content = freezed,
    Object? isSent = freezed,
    Object? isDelivered = freezed,
    Object? isReadByReceiver = freezed,
    Object? createdAt = freezed,
    Object? readAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$MessageImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      chat: freezed == chat
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as MessageChat?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as Sender?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      isSent: freezed == isSent
          ? _value.isSent
          : isSent // ignore: cast_nullable_to_non_nullable
              as bool?,
      isDelivered: freezed == isDelivered
          ? _value.isDelivered
          : isDelivered // ignore: cast_nullable_to_non_nullable
              as bool?,
      isReadByReceiver: freezed == isReadByReceiver
          ? _value.isReadByReceiver
          : isReadByReceiver // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements _Message {
  const _$MessageImpl(
      {this.id,
      this.chat,
      this.sender,
      this.content,
      this.isSent,
      this.isDelivered,
      this.isReadByReceiver,
      this.createdAt,
      this.readAt,
      this.updatedAt});

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  final int? id;
  @override
  final MessageChat? chat;
  @override
  final Sender? sender;
  @override
  final String? content;
  @override
  final bool? isSent;
  @override
  final bool? isDelivered;
  @override
  final bool? isReadByReceiver;
  @override
  final DateTime? createdAt;
  @override
  final dynamic readAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Message(id: $id, chat: $chat, sender: $sender, content: $content, isSent: $isSent, isDelivered: $isDelivered, isReadByReceiver: $isReadByReceiver, createdAt: $createdAt, readAt: $readAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chat, chat) || other.chat == chat) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isSent, isSent) || other.isSent == isSent) &&
            (identical(other.isDelivered, isDelivered) ||
                other.isDelivered == isDelivered) &&
            (identical(other.isReadByReceiver, isReadByReceiver) ||
                other.isReadByReceiver == isReadByReceiver) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other.readAt, readAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      chat,
      sender,
      content,
      isSent,
      isDelivered,
      isReadByReceiver,
      createdAt,
      const DeepCollectionEquality().hash(readAt),
      updatedAt);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  const factory _Message(
      {final int? id,
      final MessageChat? chat,
      final Sender? sender,
      final String? content,
      final bool? isSent,
      final bool? isDelivered,
      final bool? isReadByReceiver,
      final DateTime? createdAt,
      final dynamic readAt,
      final DateTime? updatedAt}) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  int? get id;
  @override
  MessageChat? get chat;
  @override
  Sender? get sender;
  @override
  String? get content;
  @override
  bool? get isSent;
  @override
  bool? get isDelivered;
  @override
  bool? get isReadByReceiver;
  @override
  DateTime? get createdAt;
  @override
  dynamic get readAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageChat _$MessageChatFromJson(Map<String, dynamic> json) {
  return _MessageChat.fromJson(json);
}

/// @nodoc
mixin _$MessageChat {
  int? get id => throw _privateConstructorUsedError;

  /// Serializes this MessageChat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageChat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageChatCopyWith<MessageChat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageChatCopyWith<$Res> {
  factory $MessageChatCopyWith(
          MessageChat value, $Res Function(MessageChat) then) =
      _$MessageChatCopyWithImpl<$Res, MessageChat>;
  @useResult
  $Res call({int? id});
}

/// @nodoc
class _$MessageChatCopyWithImpl<$Res, $Val extends MessageChat>
    implements $MessageChatCopyWith<$Res> {
  _$MessageChatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageChat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageChatImplCopyWith<$Res>
    implements $MessageChatCopyWith<$Res> {
  factory _$$MessageChatImplCopyWith(
          _$MessageChatImpl value, $Res Function(_$MessageChatImpl) then) =
      __$$MessageChatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id});
}

/// @nodoc
class __$$MessageChatImplCopyWithImpl<$Res>
    extends _$MessageChatCopyWithImpl<$Res, _$MessageChatImpl>
    implements _$$MessageChatImplCopyWith<$Res> {
  __$$MessageChatImplCopyWithImpl(
      _$MessageChatImpl _value, $Res Function(_$MessageChatImpl) _then)
      : super(_value, _then);

  /// Create a copy of MessageChat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_$MessageChatImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageChatImpl implements _MessageChat {
  const _$MessageChatImpl({this.id});

  factory _$MessageChatImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageChatImplFromJson(json);

  @override
  final int? id;

  @override
  String toString() {
    return 'MessageChat(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageChatImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of MessageChat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageChatImplCopyWith<_$MessageChatImpl> get copyWith =>
      __$$MessageChatImplCopyWithImpl<_$MessageChatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageChatImplToJson(
      this,
    );
  }
}

abstract class _MessageChat implements MessageChat {
  const factory _MessageChat({final int? id}) = _$MessageChatImpl;

  factory _MessageChat.fromJson(Map<String, dynamic> json) =
      _$MessageChatImpl.fromJson;

  @override
  int? get id;

  /// Create a copy of MessageChat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageChatImplCopyWith<_$MessageChatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Sender _$SenderFromJson(Map<String, dynamic> json) {
  return _Sender.fromJson(json);
}

/// @nodoc
mixin _$Sender {
  String? get mobile => throw _privateConstructorUsedError;

  /// Serializes this Sender to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Sender
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SenderCopyWith<Sender> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SenderCopyWith<$Res> {
  factory $SenderCopyWith(Sender value, $Res Function(Sender) then) =
      _$SenderCopyWithImpl<$Res, Sender>;
  @useResult
  $Res call({String? mobile});
}

/// @nodoc
class _$SenderCopyWithImpl<$Res, $Val extends Sender>
    implements $SenderCopyWith<$Res> {
  _$SenderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Sender
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mobile = freezed,
  }) {
    return _then(_value.copyWith(
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SenderImplCopyWith<$Res> implements $SenderCopyWith<$Res> {
  factory _$$SenderImplCopyWith(
          _$SenderImpl value, $Res Function(_$SenderImpl) then) =
      __$$SenderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? mobile});
}

/// @nodoc
class __$$SenderImplCopyWithImpl<$Res>
    extends _$SenderCopyWithImpl<$Res, _$SenderImpl>
    implements _$$SenderImplCopyWith<$Res> {
  __$$SenderImplCopyWithImpl(
      _$SenderImpl _value, $Res Function(_$SenderImpl) _then)
      : super(_value, _then);

  /// Create a copy of Sender
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mobile = freezed,
  }) {
    return _then(_$SenderImpl(
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SenderImpl implements _Sender {
  const _$SenderImpl({this.mobile});

  factory _$SenderImpl.fromJson(Map<String, dynamic> json) =>
      _$$SenderImplFromJson(json);

  @override
  final String? mobile;

  @override
  String toString() {
    return 'Sender(mobile: $mobile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SenderImpl &&
            (identical(other.mobile, mobile) || other.mobile == mobile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, mobile);

  /// Create a copy of Sender
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SenderImplCopyWith<_$SenderImpl> get copyWith =>
      __$$SenderImplCopyWithImpl<_$SenderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SenderImplToJson(
      this,
    );
  }
}

abstract class _Sender implements Sender {
  const factory _Sender({final String? mobile}) = _$SenderImpl;

  factory _Sender.fromJson(Map<String, dynamic> json) = _$SenderImpl.fromJson;

  @override
  String? get mobile;

  /// Create a copy of Sender
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SenderImplCopyWith<_$SenderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
