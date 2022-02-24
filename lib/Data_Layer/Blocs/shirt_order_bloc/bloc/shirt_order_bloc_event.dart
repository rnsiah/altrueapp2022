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
  final Shirt shirt;
  ShirtColorChange({required this.shirtColor, required this.shirt});
}

class ShirtPictureChange extends ShirtOrderBlocEvent {
  final Shirt shirt;
  final ShirtVariation shirtVariation;
  ShirtPictureChange({required this.shirt, required this.shirtVariation});
}

class ShirtQuantityIncrement extends ShirtOrderBlocEvent {
  ShirtQuantityIncrement();
}

class ShirtQuantityDecrement extends ShirtOrderBlocEvent {
  ShirtQuantityDecrement();
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
  final int shirtId;

  ShirtOrderSubmitted({
    required this.color,
    required this.quantity,
    required this.shirtId,
    required this.shirt,
    required this.size,
  });
}

class ShirtOrderColorUpated extends ShirtOrderBlocEvent {
  final ShirtColor color;
  ShirtOrderColorUpated({required this.color});
}

class ShirtOrderStarted extends ShirtOrderBlocEvent {
  final Shirt shirt;
  ShirtOrderStarted({required this.shirt});
}
