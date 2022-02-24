// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      nonprofitCount: json['nonprofit_count'] as int?,
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      information: json['information'] as String,
      nonprofitList: (json['all_nonprofits'] as List<dynamic>?)
          ?.map((e) => NonProfitRep.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'nonprofit_count': instance.nonprofitCount,
      'id': instance.id,
      'all_nonprofits': instance.nonprofitList?.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'image': instance.image,
      'information': instance.information,
    };
