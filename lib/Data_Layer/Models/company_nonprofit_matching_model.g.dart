// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_nonprofit_matching_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyNonProfitMatchRelationship _$CompanyNonProfitMatchRelationshipFromJson(
    Map<String, dynamic> json) {
  return CompanyNonProfitMatchRelationship(
    fundingLimit: (json['funding_limit'] as num).toDouble(),
    matchLevel: json['match_level'] as int,
    nonProfit: NonProfitRep.fromJson(json['nonprofit'] as Map<String, dynamic>),
    totalRaised: (json['total_raised'] as num).toDouble(),
  );
}

Map<String, dynamic> _$CompanyNonProfitMatchRelationshipToJson(
        CompanyNonProfitMatchRelationship instance) =>
    <String, dynamic>{
      'match_level': instance.matchLevel,
      'total_raised': instance.totalRaised,
      'funding_limit': instance.fundingLimit,
      'nonprofit': instance.nonProfit.toJson(),
    };
