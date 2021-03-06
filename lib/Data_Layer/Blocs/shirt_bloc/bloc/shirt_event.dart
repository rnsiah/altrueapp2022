part of 'shirt_bloc.dart';

abstract class ShirtEvent extends Equatable {
  const ShirtEvent();

  @override
  List<Object> get props => [];
}

class FetchShirts extends ShirtEvent {}

class FetchShirt extends ShirtEvent {
  final Shirt shirt;
  FetchShirt({required this.shirt});

  @override
  List<Object> get props => [shirt];
}

class FetchShirtByCategory extends ShirtEvent {
  final Category category;

  FetchShirtByCategory({required this.category});

  @override
  List<Object> get props => [category];
}
