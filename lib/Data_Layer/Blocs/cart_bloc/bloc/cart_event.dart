part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartSubmitted extends CartEvent {}

class CartItemAdded extends CartEvent {
  final DatabaseOrderItem orderItem;
  CartItemAdded({required this.orderItem});
}

class CartEmptied extends CartEvent {}

class CartBeingLoaded extends CartEvent {}

class CartItemDeleted extends CartEvent {
  final OrderItem item;
  CartItemDeleted({required this.item});
}
