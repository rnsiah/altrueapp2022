// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'altrue_action_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AltrueAction _$AltrueActionFromJson(Map<String, dynamic> json) => AltrueAction(
      name: json['requirement'] as String?,
      pointsAwarded: json['points_awarded'] as int?,
    );

Map<String, dynamic> _$AltrueActionToJson(AltrueAction instance) =>
    <String, dynamic>{
      'requirement': instance.name,
      'points_awarded': instance.pointsAwarded,
    };
