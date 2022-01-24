// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return OrderItem(
    quantity: json['quantity'] as int,
    shirt: Shirt.fromJson(json['ordered_shirt'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'ordered_shirt': instance.shirt.toJson(),
      'quantity': instance.quantity,
    };
