import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/Data_Layer/Models/category_model.dart';
import 'package:mobile/Data_Layer/Models/country_model.dart';
import 'atrocity_model.dart';
part 'shirt_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Shirt {
  Shirt(
      {this.id,
      this.name,
      this.price,
      this.country,
      this.shirtImage,
      this.slug,
      this.atrocity,
      this.originalImage,
      this.category,
      this.altrueInfo,
      this.otherShirts});

  final int? id;
  final String? name;
  double? price;
  Country? country;
  @JsonKey(name: 'shirt_image')
  String? shirtImage;
  @JsonKey(name: 'atrocityList')
  List<Atrocity>? atrocity;
  String? slug;
  @JsonKey(name: 'original_image')
  String? originalImage;
  Category? category;
  @JsonKey(name: 'altrue_story', required: false)
  String? altrueInfo;
  @JsonKey(name: 'similar_shirts')
  List<Shirt>? otherShirts;

  factory Shirt.fromJson(Map<String, dynamic> data) => _$ShirtFromJson(data);

  Map<String, dynamic> toJson() => _$ShirtToJson(this);

  String getShirt() {
    if (atrocity != null && atrocity!.length > 1) {
      for (Atrocity atro in atrocity!) {
        return atro.title.toString();
      }
    }
    return 'nthing';
  }

  shirtRepresentation(Shirt shirt) {
    return shirt.name;
  }
}
