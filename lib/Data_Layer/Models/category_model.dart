import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/nonprofit_project_model.dart';
part 'category_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Category {
  Category({
    this.projects,
    this.projectCount,
    this.nonprofitCount,
    this.id,
    this.name,
    this.image,
    this.information,
    this.nonprofitList,
  });
  @JsonKey(name: 'nonprofit_count')
  int? nonprofitCount;
  @JsonKey(name: 'project_count')
  int? projectCount;
  List<NonProfitProject>? projects;
  int? id;
  @JsonKey(name: 'all_nonprofits')
  List<NonProfitRep>? nonprofitList;
  String? name;
  String? image;
  String? information;

  factory Category.fromJson(Map<String, dynamic> data) =>
      _$CategoryFromJson(data);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
