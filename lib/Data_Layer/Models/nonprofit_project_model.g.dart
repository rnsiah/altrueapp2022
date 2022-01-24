// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nonprofit_project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NonProfitProject _$NonProfitProjectFromJson(Map<String, dynamic> json) {
  return NonProfitProject(
    json['information'] as String,
    json['fundraising_goal'] as String,
    json['title'] as String,
  )
    ..supporters = (json['supporters'] as List<dynamic>?)
        ?.map((e) => ProfileRepresentation.fromJson(e as Map<String, dynamic>))
        .toList()
    ..followers = (json['followers'] as List<dynamic>?)
        ?.map((e) => ProfileRepresentation.fromJson(e as Map<String, dynamic>))
        .toList()
    ..nonprofit = json['nonprofit'] == null
        ? null
        : NonProfit.fromJson(json['nonprofit'] as Map<String, dynamic>)
    ..cause = json['cause'] == null
        ? null
        : Category.fromJson(json['cause'] as Map<String, dynamic>)
    ..atrocity = json['atrocity'] == null
        ? null
        : Atrocity.fromJson(json['atrocity'] as Map<String, dynamic>);
}

Map<String, dynamic> _$NonProfitProjectToJson(NonProfitProject instance) =>
    <String, dynamic>{
      'information': instance.information,
      'title': instance.title,
      'supporters': instance.supporters?.map((e) => e.toJson()).toList(),
      'followers': instance.followers?.map((e) => e.toJson()).toList(),
      'nonprofit': instance.nonprofit?.toJson(),
      'cause': instance.cause?.toJson(),
      'atrocity': instance.atrocity?.toJson(),
      'fundraising_goal': instance.fundraisingGoal,
    };