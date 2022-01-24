part of 'shirt_list_bloc.dart';

abstract class ShirtListEvent extends Equatable {}

class ShirtListChanged extends ShirtListEvent {
  final Category category;

  ShirtListChanged({required this.category});

  List<Object> get props => [category];
}
