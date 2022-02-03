import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/Data_Layer/Models/companies_supporting.dart';
import 'package:mobile/Data_Layer/Models/link_model.dart';
import 'package:mobile/Data_Layer/Models/nonprofit_project_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';

import 'atrocity_model.dart';
import 'category_model.dart';
import 'shirt_model.dart';
part 'non_profit_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NonProfit {
  NonProfit({
    required this.id,
    required this.name,
    required this.logo,
    this.description,
    this.yearStarted,
    this.missionStatement,
    this.projects,
    this.visionStatement,
    this.websiteUrl,
    this.category,
    this.slug,
    this.atrocity,
    this.shirtList,
    this.mainImage,
    this.balance,
    this.companiesSupporting,
    this.contributors,
    this.owner,
    this.links,
  });

  final int id;
  final String name;
  String logo;
  @JsonKey(required: false)
  String? description;
  @JsonKey(name: 'year_started', required: false)
  int? yearStarted;
  @JsonKey(name: 'mission_statement', required: false)
  String? missionStatement;
  @JsonKey(name: "vision_statement", required: false)
  String? visionStatement;
  @JsonKey(name: "website_url", required: false)
  String? websiteUrl;
  @JsonKey(required: false)
  List<Category>? category;
  String? slug;
  @JsonKey(name: 'atrocity_List', required: false)
  List<Atrocity>? atrocity;
  @JsonKey(required: false)
  List<Shirt>? shirtList;
  @JsonKey(name: 'main_image', required: false)
  String? mainImage;
  @JsonKey(name: 'total_balance', required: false)
  double? balance;
  List<CompaniesSupporting>? companiesSupporting;
  List<Profile>? contributors;
  Profile? owner;
  List<Link>? links;
  List<NonProfitProject>? projects;

  factory NonProfit.fromJson(Map<String, dynamic> data) =>
      _$NonProfitFromJson(data);

  Map<String, dynamic> toJson() => _$NonProfitToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NonProfitCompletion {
  @JsonKey(name: 'owner')
  final Profile profile;
  @JsonKey(name: 'year_started')
  final int yearStarted;
  final String name;
  @JsonKey(name: 'mission_statement')
  final String missionStatement;
  @JsonKey(name: 'vision_statement')
  final String visionStatement;
  final String? facebook;
  @JsonKey(name: 'website_url')
  final String? website;
  final String? instagram;
  final String description;
  // final dynamic logo;
  // final dynamic mainImage;

  NonProfitCompletion(

      // this.logo,
      // this.mainImage, {
      {
    this.website,
    this.instagram,
    required this.profile,
    required this.name,
    required this.description,
    required this.facebook,
    required this.missionStatement,
    required this.visionStatement,
    required this.yearStarted,
  });

  factory NonProfitCompletion.fromJson(Map<String, dynamic> data) =>
      _$NonProfitCompletionFromJson(data);

  Map<String, dynamic> toJson() => _$NonProfitCompletionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NonProfitRep {
  final int id;
  final String name;
  final String logo;

  NonProfitRep({required this.id, required this.logo, required this.name});

  factory NonProfitRep.fromJson(Map<String, dynamic> data) =>
      _$NonProfitRepFromJson(data);

  Map<String, dynamic> toJson() => _$NonProfitRepToJson(this);
}
