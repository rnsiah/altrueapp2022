import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/Data_Layer/Models/category_model.dart';
import 'package:mobile/Data_Layer/Models/company_atrocity_matching_model.dart';
import 'package:mobile/Data_Layer/Models/company_coupon_model.dart';
import 'package:mobile/Data_Layer/Models/company_location_model.dart';
import 'package:mobile/Data_Layer/Models/company_nonprofit_matching_model.dart';
import 'package:mobile/Data_Layer/Models/country_model.dart';
import 'package:mobile/Data_Layer/Models/link_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';

part 'company_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ForProfitCompany {
  int id;
  String name;
  String logo;
  @JsonKey(name: 'year_started')
  String yearStarted;
  String mission;
  @JsonKey(name: 'website_address')
  String websiteAddress;
  String slug;
  List<Category>? categories;
  List<CompanyNonProfit>? nonprofits;
  List<CompanyAtrocity>? atrocities;
  Profile? owner;
  List<Profile>? contributors;
  String description;
  String headquarters;
  List<CompanyStore>? locations;
  String image;
  List<Link>? links;
  double? totalDonated;
  List<CompanyCoupon>? coupons;
  @JsonKey(name: 'atrocityRelationships')
  List<CompanyAtrocityMatchRelationShip>? atrocityMatchRelationships;
  @JsonKey(name: 'nonprofitRelationships')
  List<CompanyNonProfitMatchRelationship>? nonprofitMatchRelationships;
  int? totalDonationCount;
  ForProfitCompany(
      this.image,
      this.totalDonationCount,
      this.links,
      this.id,
      this.logo,
      this.mission,
      this.yearStarted,
      this.name,
      this.description,
      this.headquarters,
      this.owner,
      this.totalDonated,
      this.slug,
      this.websiteAddress,
      this.coupons,
      [this.atrocities,
      this.atrocityMatchRelationships,
      this.nonprofitMatchRelationships,
      this.categories,
      this.locations,
      this.nonprofits,
      this.contributors]);

  factory ForProfitCompany.fromJson(Map<String, dynamic> data) =>
      _$ForProfitCompanyFromJson(data);

  Map<String, dynamic> toJson() => _$ForProfitCompanyToJson(this);
}

@JsonSerializable()
class CompanyAtrocity {
  final int id;
  final String title;
  final List<Category> category;
  final Country country;

  CompanyAtrocity({
    required this.id,
    required this.title,
    required this.category,
    required this.country,
  });

  factory CompanyAtrocity.fromJson(Map<String, dynamic> data) =>
      _$CompanyAtrocityFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyAtrocityToJson(this);
}

@JsonSerializable()
class CompanyNonProfit {
  final int id;
  final String name;
  final String logo;

  CompanyNonProfit({required this.id, required this.logo, required this.name});

  factory CompanyNonProfit.fromJson(Map<String, dynamic> data) =>
      _$CompanyNonProfitFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyNonProfitToJson(this);
}

@JsonSerializable()
class CompanyCompletion {
  final String companyName;
  final Profile profile;
  final String? missionStatement;
  final String companyAddress;
  final String description;
  final String? facebook;
  final String? instagram;
  final dynamic logo;
  final dynamic mainImage;
  final String? wehsite;
  final String yearStarted;

  CompanyCompletion(
      {required this.companyAddress,
      required this.companyName,
      required this.description,
      this.facebook,
      this.instagram,
      required this.logo,
      required this.mainImage,
      this.missionStatement,
      required this.profile,
      this.wehsite,
      required this.yearStarted});

  factory CompanyCompletion.fromJson(Map<String, dynamic> data) =>
      _$CompanyCompletionFromJson(data);

  Map<String, dynamic> toJson() => _$CompanyCompletionToJson(this);
}
