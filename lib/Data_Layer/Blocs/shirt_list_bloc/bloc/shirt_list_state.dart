part of 'shirt_list_bloc.dart';

enum ShirtsLoaded { incomplete, complete }

abstract class ShirtListState extends Equatable {
  const ShirtListState();

  @override
  List<Object> get props => [];
}

class UnknownShirtItem extends ShirtListState {}

class RefugeeShirtList extends ShirtListState {
  final List<Shirt> shirtList;
  final ShirtsLoaded status;
  RefugeeShirtList({required this.shirtList, required this.status});

  @override
  List<Object> get props => [shirtList, status];
}

class WorldPovertryShirtList extends ShirtListState {
  final List<Shirt> shirtList;
  final ShirtsLoaded status;

  WorldPovertryShirtList({required this.shirtList, required this.status});

  @override
  List<Object> get props => [shirtList, status];
}

class ShirtListFailure extends ShirtListState {
  final ShirtsLoaded status;
  final String message;
  ShirtListFailure({required this.status, required this.message});

  @override
  List<Object> get props => [message, status];
}

class ShirtListLoading extends ShirtListState {}
