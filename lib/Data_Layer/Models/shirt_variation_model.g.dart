// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shirt_variation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShirtVariation _$ShirtVariationFromJson(Map<String, dynamic> json) =>
    ShirtVariation(
      color: ShirtColor.fromJson(json['color'] as Map<String, dynamic>),
      image: json['image'] as String,
      shirt: json['shirt'] as int,
    );

Map<String, dynamic> _$ShirtVariationToJson(ShirtVariation instance) =>
    <String, dynamic>{
      'shirt': instance.shirt,
      'color': instance.color.toJson(),
      'image': instance.image,
    };
