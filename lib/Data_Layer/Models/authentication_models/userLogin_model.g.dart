// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userLogin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLogin _$UserLoginFromJson(Map<String, dynamic> json) {
  return UserLogin(
    email: json['email'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UserLoginToJson(UserLogin instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

UserSignUpLoginIn _$UserSignUpLoginInFromJson(Map<String, dynamic> json) {
  return UserSignUpLoginIn(
    email: json['email'] as String,
    password: json['password'] as String,
    password2: json['password2'] as String?,
  );
}

Map<String, dynamic> _$UserSignUpLoginInToJson(UserSignUpLoginIn instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'password2': instance.password2,
    };

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
    token: json['token'] as String,
    user: UserInfoFromKey.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'token': instance.token,
      'user': instance.user.toJson(),
    };

UserInfoFromKey _$UserInfoFromKeyFromJson(Map<String, dynamic> json) {
  return UserInfoFromKey(
    profileCreated: json['profile_created'] as bool,
    altid: json['id'] as int,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserInfoFromKeyToJson(UserInfoFromKey instance) =>
    <String, dynamic>{
      'id': instance.altid,
      'email': instance.email,
      'profile_created': instance.profileCreated,
    };
