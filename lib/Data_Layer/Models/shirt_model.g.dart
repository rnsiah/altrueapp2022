// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shirt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shirt _$ShirtFromJson(Map<String, dynamic> json) {
  return Shirt(
    id: json['id'] as int?,
    name: json['name'] as String?,
    price: (json['price'] as num?)?.toDouble(),
    country: json['country'] == null
        ? null
        : Country.fromJson(json['country'] as Map<String, dynamic>),
    shirtImage: json['shirt_image'] as String?,
    slug: json['slug'] as String?,
    atrocity: (json['atrocityList'] as List<dynamic>?)
        ?.map((e) => Atrocity.fromJson(e as Map<String, dynamic>))
        .toList(),
    originalImage: json['original_image'] as String?,
    category: json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
    altrueInfo: json['altrue_story'] as String?,
    otherShirts: (json['similar_shirts'] as List<dynamic>?)
        ?.map((e) => Shirt.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ShirtToJson(Shirt instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'country': instance.country?.toJson(),
      'shirt_image': instance.shirtImage,
      'atrocityList': instance.atrocity?.map((e) => e.toJson()).toList(),
      'slug': instance.slug,
      'original_image': instance.originalImage,
      'category': instance.category?.toJson(),
      'altrue_story': instance.altrueInfo,
      'similar_shirts': instance.otherShirts?.map((e) => e.toJson()).toList(),
    };
