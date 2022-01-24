import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';

part 'order_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderItem {
  @JsonKey(name: 'ordered_shirt')
  Shirt shirt;
  int quantity;

  OrderItem({required this.quantity, required this.shirt});

  factory OrderItem.fromJson(Map<String, dynamic> data) =>
      _$OrderItemFromJson(data);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
