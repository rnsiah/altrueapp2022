// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForProfitCompany _$ForProfitCompanyFromJson(Map<String, dynamic> json) =>
    ForProfitCompany(
      json['image'] as String,
      json['totalDonationCount'] as int?,
      (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['id'] as int,
      json['logo'] as String,
      json['mission'] as String,
      json['year_started'] as String,
      json['name'] as String,
      json['description'] as String,
      json['headquarters'] as String,
      json['owner'] == null
          ? null
          : Profile.fromJson(json['owner'] as Map<String, dynamic>),
      (json['totalDonated'] as num?)?.toDouble(),
      json['slug'] as String,
      json['website_address'] as String,
      (json['coupons'] as List<dynamic>?)
          ?.map((e) => CompanyCoupon.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['atrocities'] as List<dynamic>?)
          ?.map((e) => CompanyAtrocity.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['atrocityRelationships'] as List<dynamic>?)
          ?.map((e) => CompanyAtrocityMatchRelationShip.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      (json['nonprofitRelationships'] as List<dynamic>?)
          ?.map((e) => CompanyNonProfitMatchRelationship.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['locations'] as List<dynamic>?)
          ?.map((e) => CompanyStore.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['nonprofits'] as List<dynamic>?)
          ?.map((e) => CompanyNonProfit.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['contributors'] as List<dynamic>?)
          ?.map((e) => Profile.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForProfitCompanyToJson(ForProfitCompany instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'year_started': instance.yearStarted,
      'mission': instance.mission,
      'website_address': instance.websiteAddress,
      'slug': instance.slug,
      'categories': instance.categories?.map((e) => e.toJson()).toList(),
      'nonprofits': instance.nonprofits?.map((e) => e.toJson()).toList(),
      'atrocities': instance.atrocities?.map((e) => e.toJson()).toList(),
      'owner': instance.owner?.toJson(),
      'contributors': instance.contributors?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'headquarters': instance.headquarters,
      'locations': instance.locations?.map((e) => e.toJson()).toList(),
      'image': instance.image,
      'links': instance.links?.map((e) => e.toJson()).toList(),
      'totalDonated': instance.totalDonated,
      'coupons': instance.coupons?.map((e) => e.toJson()).toList(),
      'atrocityRelationships':
          instance.atrocityMatchRelationships?.map((e) => e.toJson()).toList(),
      'nonprofitRelationships':
          instance.nonprofitMatchRelationships?.map((e) => e.toJson()).toList(),
      'totalDonationCount': instance.totalDonationCount,
    };

CompanyAtrocity _$CompanyAtrocityFromJson(Map<String, dynamic> json) =>
    CompanyAtrocity(
      id: json['id'] as int,
      title: json['title'] as String,
      category: (json['category'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      country: Country.fromJson(json['country'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompanyAtrocityToJson(CompanyAtrocity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'country': instance.country,
    };

CompanyNonProfit _$CompanyNonProfitFromJson(Map<String, dynamic> json) =>
    CompanyNonProfit(
      id: json['id'] as int,
      logo: json['logo'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CompanyNonProfitToJson(CompanyNonProfit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
    };

CompanyCompletion _$CompanyCompletionFromJson(Map<String, dynamic> json) =>
    CompanyCompletion(
      companyAddress: json['address'] as String,
      companyName: json['name'] as String,
      description: json['description'] as String,
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      missionStatement: json['mission'] as String?,
      profile: Profile.fromJson(json['owner'] as Map<String, dynamic>),
      wehsite: json['website_address'] as String?,
      yearStarted: json['year_started'] as String,
    );

Map<String, dynamic> _$CompanyCompletionToJson(CompanyCompletion instance) =>
    <String, dynamic>{
      'name': instance.companyName,
      'owner': instance.profile.toJson(),
      'mission': instance.missionStatement,
      'address': instance.companyAddress,
      'description': instance.description,
      'facebook': instance.facebook,
      'instagram': instance.instagram,
      'website_address': instance.wehsite,
      'year_started': instance.yearStarted,
    };
