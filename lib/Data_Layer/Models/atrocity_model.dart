import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/Data_Layer/Models/link_model.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';

import 'category_model.dart';
import 'country_model.dart';

part 'atrocity_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Atrocity {
  Atrocity(
      {this.id,
      required this.title,
      this.region,
      this.recentDonors,
      this.info,
      this.imageUrl,
      this.category,
      this.country,
      this.slug,
      this.videoURL,
      this.balance,
      this.shirtList,
      this.nonprofitList});

  String title;
  String? region;
  String? info;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  List<Category>? category;
  Country? country;
  @JsonKey(includeIfNull: true)
  String? slug;
  String? videoURL;
  int? id;
  @JsonKey(name: 'total_balance')
  double? balance;
  @JsonKey(name: 'atrocity_shirt_list')
  List<Shirt>? shirtList;
  @JsonKey(name: 'np_list')
  List<NonProfit>? nonprofitList;
  List<Link>? links;
  List<ProfileRepresentation>? recentDonors;

  factory Atrocity.fromJson(Map<String, dynamic> data) =>
      _$AtrocityFromJson(data);

  Map<String, dynamic> toJson() => _$AtrocityToJson(this);
}

// class _Converter<T> implements JsonConverter<T, Object>{
//   const _Converter();


//   @override
//   T fromJson(Object? json) {
//      if (json is Map<dynamic, String> && json.containsKey('key'))
//       throw UnimplementedError();
//     }
  
//     @override
//     Object toJson(T object) {
//     // TODO: implement toJson
//     throw UnimplementedError();
//   }}

