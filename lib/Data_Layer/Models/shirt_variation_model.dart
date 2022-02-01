import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/Data_Layer/Models/shirt_color_model.dart';

part 'shirt_variation_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ShirtVariation {
  int shirt;
  ShirtColor color;
  String image;

  ShirtVariation(
      {required this.color, required this.image, required this.shirt});

  factory ShirtVariation.fromJson(Map<String, dynamic> data) =>
      _$ShirtVariationFromJson(data);

  Map<String, dynamic> toJson() => _$ShirtVariationToJson(this);
}
