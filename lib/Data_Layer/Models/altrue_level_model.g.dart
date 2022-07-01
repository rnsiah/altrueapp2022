// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'altrue_level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AltrueLevel _$AltrueLevelFromJson(Map<String, dynamic> json) => AltrueLevel(
      name: json['name'] as String,
      levelNumber: json['level_number'] as int,
      maximumPoints: json['maximum_points'] as int,
      minimumPoints: json['minimum_points'] as int,
    );

Map<String, dynamic> _$AltrueLevelToJson(AltrueLevel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'minimum_points': instance.minimumPoints,
      'maximum_points': instance.maximumPoints,
      'level_number': instance.levelNumber,
    };
