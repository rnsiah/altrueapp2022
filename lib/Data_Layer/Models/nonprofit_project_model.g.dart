// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nonprofit_project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NonProfitProject _$NonProfitProjectFromJson(Map<String, dynamic> json) =>
    NonProfitProject(
      id: json['id'] as int?,
      currentFunds: (json['currentFunds'] as num?)?.toDouble(),
      isActive: json['is_active'] as bool?,
      information: json['information'] as String?,
      atrocity: json['atrocity'] == null
          ? null
          : Atrocity.fromJson(json['atrocity'] as Map<String, dynamic>),
      cause: json['cause'] == null
          ? null
          : Category.fromJson(json['cause'] as Map<String, dynamic>),
      followers: (json['followers'] as List<dynamic>?)
          ?.map(
              (e) => ProfileRepresentation.fromJson(e as Map<String, dynamic>))
          .toList(),
      fundraisingGoal: json['fundraising_goal'] as String?,
      nonprofit: json['nonprofit'] == null
          ? null
          : NonProfit.fromJson(json['nonprofit'] as Map<String, dynamic>),
      supporters: (json['supporters'] as List<dynamic>?)
          ?.map(
              (e) => ProfileRepresentation.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$NonProfitProjectToJson(NonProfitProject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'information': instance.information,
      'title': instance.title,
      'supporters': instance.supporters?.map((e) => e.toJson()).toList(),
      'followers': instance.followers?.map((e) => e.toJson()).toList(),
      'nonprofit': instance.nonprofit?.toJson(),
      'cause': instance.cause?.toJson(),
      'atrocity': instance.atrocity?.toJson(),
      'currentFunds': instance.currentFunds,
      'is_active': instance.isActive,
      'fundraising_goal': instance.fundraisingGoal,
    };

NonProfitProjectCreation _$NonProfitProjectCreationFromJson(
        Map<String, dynamic> json) =>
    NonProfitProjectCreation(
      atrocity: json['atrocity'] as int?,
      category: json['category'] as int?,
      fundraisingGoal: json['fundraisingGoal'] as int,
      information: json['information'] as String,
      nonprofit: json['nonprofit'] as int,
      title: json['title'] as String,
    );

Map<String, dynamic> _$NonProfitProjectCreationToJson(
        NonProfitProjectCreation instance) =>
    <String, dynamic>{
      'title': instance.title,
      'information': instance.information,
      'atrocity': instance.atrocity,
      'category': instance.category,
      'fundraisingGoal': instance.fundraisingGoal,
      'nonprofit': instance.nonprofit,
    };

NonProfitProjectRep _$NonProfitProjectRepFromJson(Map<String, dynamic> json) =>
    NonProfitProjectRep(
      id: json['id'] as int,
      title: json['title'] as String,
    );

Map<String, dynamic> _$NonProfitProjectRepToJson(
        NonProfitProjectRep instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
