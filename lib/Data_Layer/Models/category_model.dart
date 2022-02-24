import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
part 'category_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Category {
  Category({
    required this.nonprofitCount,
    required this.id,
    required this.name,
    required this.image,
    required this.information,
    required this.nonprofitList,
  });
  @JsonKey(name: 'nonprofit_count')
  int? nonprofitCount;
  int id;
  @JsonKey(name: 'all_nonprofits')
  List<NonProfitRep>? nonprofitList;
  String name;
  String image;
  String information;

  factory Category.fromJson(Map<String, dynamic> data) =>
      _$CategoryFromJson(data);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
