part of 'cart_bloc.dart';

enum CartStatus { initial, loading, loaded, changing }

class CartState extends Equatable {
  final List<OrderItem> cart;
  final CartStatus status;

  const CartState({this.cart = const [], this.status = CartStatus.initial});

  CartState copyWith({List<OrderItem>? cart, CartStatus? status}) {
    return CartState(cart: cart ?? this.cart, status: status ?? this.status);
  }

  @override
  List<Object> get props => [cart, status];
}

class CartInitial extends CartState {}
