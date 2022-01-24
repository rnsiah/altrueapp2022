import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';

part 'company_nonprofit_matching_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyNonProfitMatchRelationship {
  @JsonKey(name: 'match_level')
  final int matchLevel;
  @JsonKey(name: 'total_raised')
  final double totalRaised;
  @JsonKey(name: 'funding_limit')
  final double fundingLimit;
  @JsonKey(name: 'nonprofit')
  final NonProfitRep nonProfit;

  CompanyNonProfitMatchRelationship(
      {required this.fundingLimit,
      required this.matchLevel,
      required this.nonProfit,
      required this.totalRaised});

  factory CompanyNonProfitMatchRelationship.fromJson(
          Map<String, dynamic> data) =>
      _$CompanyNonProfitMatchRelationshipFromJson(data);

  Map<String, dynamic> toJson() =>
      _$CompanyNonProfitMatchRelationshipToJson(this);
}
