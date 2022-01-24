// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_donation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyDonation _$CompanyDonationFromJson(Map<String, dynamic> json) {
  return CompanyDonation(
    ForProfitCompany.fromJson(json['company'] as Map<String, dynamic>),
    json['donation_date'] as String,
    Profile.fromJson(json['user_matched'] as Map<String, dynamic>),
    (json['amount'] as num).toDouble(),
    json['atrocity'] == null
        ? null
        : Atrocity.fromJson(json['atrocity'] as Map<String, dynamic>),
    json['nonprofit'] == null
        ? null
        : NonProfit.fromJson(json['nonprofit'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CompanyDonationToJson(CompanyDonation instance) =>
    <String, dynamic>{
      'company': instance.company.toJson(),
      'amount': instance.amount,
      'atrocity': instance.atrocity?.toJson(),
      'nonprofit': instance.nonprofit?.toJson(),
      'user_matched': instance.userMatched.toJson(),
      'donation_date': instance.donationDate,
    };