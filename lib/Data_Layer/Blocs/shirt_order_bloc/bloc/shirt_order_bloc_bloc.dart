import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Blocs/form_submission_status.dart';
import 'package:mobile/Data_Layer/Models/order_item_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_color_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_size_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_variation_model.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';

part 'shirt_order_bloc_event.dart';
part 'shirt_order_bloc_state.dart';

class ShirtOrderBlocBloc
    extends Bloc<ShirtOrderBlocEvent, ShirtOrderBlocState> {
  UserRepository userRepository = UserRepository();

  ShirtOrderBlocBloc()
      : super(OrderInProgress(quantity: 0, shirtImageUrl: '')) {
    on<ShirtQuantityChange>(_shirtQuantityChange);
    on<ShirtOrderSubmitted>(_orderSubmitted);
    on<ShirtColorChange>(_shirtColorChange);
    on<ShirtSizeChange>(_shirtSizeChange);
    on<ShirtPictureChange>(_shirtPictureChange);
  }

  void _shirtPictureChange(
      ShirtPictureChange event, Emitter<ShirtOrderBlocState> emit) async {
    final state = this.state;
    try {
      if (state is OrderInProgress) {
        String url = event.shirtVariation.image;
        ShirtOrderBlocState newState = state.copyWith(shirtImageUrl: url);
        emit(newState);
      }
    } catch (e) {
      e.toString();
    }
  }

  void _shirtSizeChange(
      ShirtSizeChange event, Emitter<ShirtOrderBlocState> emit) async {
    final state = this.state;
    if (state is OrderInProgress) {
      try {
        ShirtSize newSize = event.shirtSize;
        ShirtOrderBlocState newState = state.copyWith(size: newSize);
        emit(newState);
      } catch (e) {
        e.toString();
      }
    }
    emit(OrderError());
  }

  void _shirtColorChange(
      ShirtColorChange event, Emitter<ShirtOrderBlocState> emit) async {
    final state = this.state;
    if (state is OrderInProgress) {
      try {
        ShirtColor color = event.shirtColor;
        ShirtOrderBlocState newState = state.copyWith(color: color);
        emit(newState);
      } catch (e) {
        e.toString();
      }
    }
    emit(OrderError());
  }

  void _shirtQuantityChange(
      ShirtQuantityChange event, Emitter<ShirtOrderBlocState> emit) async {
    final state = this.state;
    if (state is OrderInProgress) {
      try {
        int newQuantity = event.quantity;
        ShirtOrderBlocState newState = state.copyWith(quantity: newQuantity);
        emit(newState);
      } catch (e) {
        e.toString();
      }
    }
    emit(OrderError());
  }

  void _orderSubmitted(
      ShirtOrderSubmitted event, Emitter<ShirtOrderBlocState> emit) async {
    final state = this.state;
    if (state is OrderInProgress) {
      OrderItem newItem = OrderItem(
          color: state.color!,
          shirt: event.shirt,
          size: state.size!,
          quantity: state.quantity!);

      emit(OrderSubmitted());
      try {
        await userRepository.addToCart(newItem);
      } catch (e) {
        e.toString();
      }
    }
    emit(OrderError());
  }
}
