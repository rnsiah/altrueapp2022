part of 'shirt_order_bloc_bloc.dart';

abstract class ShirtOrderBlocState extends Equatable {}

class OrderEmpty extends ShirtOrderBlocState {
  @override
  List<Object?> get props => [];
}

class OrderInProgress extends ShirtOrderBlocState {
  final ShirtColor? color;
  final int? quantity;
  final ShirtSize? size;
  final String? shirtImageUrl;

  OrderInProgress({this.color, this.quantity, this.size, this.shirtImageUrl});

  OrderInProgress copyWith(
      {ShirtColor? color,
      int? quantity,
      ShirtSize? size,
      String? shirtImageUrl}) {
    return OrderInProgress(
        color: color ?? this.color,
        quantity: quantity ?? this.quantity,
        shirtImageUrl: shirtImageUrl ?? this.shirtImageUrl,
        size: size ?? this.size);
  }

  @override
  List<Object> get props => [color!, quantity!, size!, shirtImageUrl!];
}

class OrderSubmitted extends ShirtOrderBlocState {
  @override
  List<Object> get props => [];
}

class OrderError extends ShirtOrderBlocState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
