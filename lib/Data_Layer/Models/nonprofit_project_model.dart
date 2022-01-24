import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Data_Layer/Models/category_model.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
part 'nonprofit_project_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NonProfitProject {
  String information;
  String title;
  List<ProfileRepresentation>? supporters;
  List<ProfileRepresentation>? followers;
  NonProfit? nonprofit;
  Category? cause;
  Atrocity? atrocity;
  @JsonKey(name: 'fundraising_goal')
  String fundraisingGoal;

  NonProfitProject(this.information, this.fundraisingGoal, this.title);

  factory NonProfitProject.fromJson(Map<String, dynamic> data) =>
      _$NonProfitProjectFromJson(data);

  Map<String, dynamic> toJson() => _$NonProfitProjectToJson(this);
}
