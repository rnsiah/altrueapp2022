part of 'shirt_order_bloc_bloc.dart';

abstract class ShirtOrderBlocEvent extends Equatable {
  const ShirtOrderBlocEvent();

  @override
  List<Object> get props => [];
}

class ShirtChange extends ShirtOrderBlocEvent {
  final Shirt shirt;

  ShirtChange({required this.shirt});
}

class ShirtColorChange extends ShirtOrderBlocEvent {
  final ShirtColor shirtColor;
  ShirtColorChange({required this.shirtColor});
}

class ShirtPictureChange extends ShirtOrderBlocEvent {
  final Shirt shirt;
  final ShirtVariation shirtVariation;
  ShirtPictureChange({required this.shirt, required this.shirtVariation});
}

class ShirtQuantityIncrement extends ShirtOrderBlocEvent {
  final int quantity;
  ShirtQuantityIncrement(this.quantity);
}

class ShirtQuantityDecrement extends ShirtOrderBlocEvent {
  final int quantity;
  ShirtQuantityDecrement(this.quantity);
}

class ShirtSizeChange extends ShirtOrderBlocEvent {
  final ShirtSize shirtSize;
  ShirtSizeChange({required this.shirtSize});
}

class ShirtQuantityChange extends ShirtOrderBlocEvent {
  final int quantity;
  ShirtQuantityChange({required this.quantity});
}

class ShirtOrderSubmitted extends ShirtOrderBlocEvent {
  final Shirt shirt;
  final ShirtSize size;
  final int quantity;
  final ShirtColor color;

  ShirtOrderSubmitted({
    required this.color,
    required this.quantity,
    required this.shirt,
    required this.size,
  });
}

class ShirtOrderCanceled extends ShirtOrderBlocEvent {}
