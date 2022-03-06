import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/Data_Layer/Models/order_item_model.dart';
import 'package:mobile/Data_Layer/Models/order_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_color_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_size_model.dart';
import 'package:mobile/Data_Layer/Repoositories/cart_repository.dart';
import 'package:mobile/Data_Layer/Repoositories/shirt_repository.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  UserRepository userRepository = UserRepository();
  CartRepository cartRepository = CartRepository();
  CartBloc() : super(CartState(status: CartStatus.initial)) {
    on<CartBeingLoaded>(_cartBeingLoaded);
    on<CartItemDeleted>(_cartItemDeleted);
    on<CartItemAdded>(_cartItemAdded);
    on<CartItemEdited>(_cartItemEdited);
    on<CartItemQuantityEdited>(_cartItemQuantityEdited);
    on<CartItemColorEdited>(_cartItemColorEdited);
    on<CartItemSizeEdited>(_cartItemSizeEdited);
  }

  void _CartSubmitted(CartSubmitted event, Emitter<CartState> emit) async {}

  void _cartBeingLoaded(CartBeingLoaded event, Emitter<CartState> emit) async {
    CartState state = this.state;
    try {
      List<DatabaseOrderItem> theCart = await userRepository.getCart();
      if (theCart.length > 0) {
        List<OrderItem> transformed =
            await cartRepository.ordersIntoCart(theCart);
        CartState newState =
            state.copyWith(cart: transformed, status: CartStatus.loaded);
        emit(newState);
      } else if (theCart.length == 0) {
        emit(state.copyWith(status: CartStatus.loaded));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _cartItemQuantityEdited(
      CartItemQuantityEdited event, Emitter<CartState> emit) {}

  void _cartItemColorEdited(
      CartItemColorEdited event, Emitter<CartState> emit) {}

  void _cartItemSizeEdited(
      CartItemSizeEdited event, Emitter<CartState> emit) async {}

  void _cartItemEdited(CartItemEdited event, Emitter<CartState> emit) async {
    CartState state = this.state;
    try {
      OrderItem editedOrderItem = OrderItem(
          id: event.orderItem.id,
          quantity: event.qauntity,
          shirt: event.orderItem.shirt,
          color: event.shirtColor,
          size: event.shirtSize);
      cartRepository.editItemInCart(editedOrderItem);
      emit(state.copyWith(status: CartStatus.changing));
    } catch (e) {
      print(e.toString());
    }
    List<DatabaseOrderItem> newCart = await userRepository.getCart();
    List<OrderItem> transformed = await cartRepository.ordersIntoCart(newCart);
    CartState newState =
        state.copyWith(cart: transformed, status: CartStatus.loaded);
    emit(newState);
  }

  void _cartItemAdded(CartItemAdded event, Emitter<CartState> emit) async {
    CartState state = this.state;
  }

  void _cartItemDeleted(CartItemDeleted event, Emitter<CartState> emit) async {
    CartState state = this.state;
    emit(state.copyWith(status: CartStatus.changing));
    try {
      bool didDelete = await userRepository.deleteFromCart(event.item.id!);
      if (didDelete == true) {
        List<DatabaseOrderItem> theCart = await userRepository.getCart();
        if (theCart.length > 0) {
          List<OrderItem> newCart =
              await cartRepository.ordersIntoCart(theCart);
          CartState newState =
              state.copyWith(cart: newCart, status: CartStatus.loaded);
          emit(newState);
        }
        emit(CartState(status: CartStatus.loaded));
      }
    } catch (e) {}
  }
}
