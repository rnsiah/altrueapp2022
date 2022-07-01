import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Data_Layer/Models/category_model.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
part 'nonprofit_project_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NonProfitProject {
  final int? id;
  final String? information;
  final String title;
  final List<ProfileRepresentation>? supporters;
  final List<ProfileRepresentation>? followers;
  final NonProfit? nonprofit;
  final Category? cause;
  final Atrocity? atrocity;
  final double? currentFunds;
  @JsonKey(name: 'is_active')
  final bool? isActive;
  @JsonKey(name: 'fundraising_goal')
  String? fundraisingGoal;

  NonProfitProject(
      {this.id,
      this.currentFunds,
      this.isActive,
      this.information,
      this.atrocity,
      this.cause,
      this.followers,
      this.fundraisingGoal,
      this.nonprofit,
      this.supporters,
      required this.title});

  factory NonProfitProject.fromJson(Map<String, dynamic> data) =>
      _$NonProfitProjectFromJson(data);

  Map<String, dynamic> toJson() => _$NonProfitProjectToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NonProfitProjectCreation {
  final String title;
  final String information;
  final int? atrocity;
  final int? category;
  final int fundraisingGoal;
  final int nonprofit;

  NonProfitProjectCreation(
      {required this.atrocity,
      required this.category,
      required this.fundraisingGoal,
      required this.information,
      required this.nonprofit,
      required this.title});

  Map<String, dynamic> toJson() => _$NonProfitProjectCreationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NonProfitProjectRep {
  int id;
  String title;

  NonProfitProjectRep({required this.id, required this.title});

  factory NonProfitProjectRep.fromJson(Map<String, dynamic> data) =>
      _$NonProfitProjectRepFromJson(data);

  Map<String, dynamic> toJson() => _$NonProfitProjectRepToJson(this);
}
