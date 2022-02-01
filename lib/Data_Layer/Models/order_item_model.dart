import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/Data_Layer/Models/shirt_color_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_size_model.dart';

part 'order_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderItem {
  @JsonKey(name: 'ordered_shirt')
  Shirt shirt;
  int quantity;
  ShirtSize size;
  ShirtColor color;
  int? id;

  OrderItem(
      {required this.quantity,
      required this.shirt,
      required this.color,
      required this.size});

  factory OrderItem.fromJson(Map<String, dynamic> data) =>
      _$OrderItemFromJson(data);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'shirt': shirt.name,
      'quantity': quantity,
      'size': size.size,
      'color': color.color
    };
  }

  @override
  String toString() {
    return 'OrderItem(shirt: ${shirt.name}, quantity:$quantity, size:${size.size}, color:${color.color})';
  }
}

@JsonSerializable()
class Cart {
  final List<OrderItem> items;

  Cart({required this.items});

  factory Cart.fromDatabaseJson(Map<String, dynamic> data) =>
      _$CartFromJson(data);

  Map<String, dynamic> toDatabaseJson() => _$CartToJson(this);

  int getLength() => items.length;
}
