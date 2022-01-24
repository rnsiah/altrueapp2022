// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_picture_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfilePicture _$ProfilePictureFromJson(Map<String, dynamic> json) {
  return ProfilePicture(
    url: json['url'] as String,
    image: json['image'] as String?,
  );
}

Map<String, dynamic> _$ProfilePictureToJson(ProfilePicture instance) =>
    <String, dynamic>{
      'url': instance.url,
      'image': instance.image,
    };
