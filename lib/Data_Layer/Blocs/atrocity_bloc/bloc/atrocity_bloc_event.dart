part of 'atrocity_bloc_bloc.dart';

abstract class AtrocityBlocEvent extends Equatable {
  const AtrocityBlocEvent();

  @override
  List<Object> get props => [];
}

class AtrocityListFetched extends AtrocityBlocEvent {
  AtrocityListFetched();
  List<Object> get props => [];
}

class AtrocityItemFteched extends AtrocityBlocEvent {
  final Atrocity atrocity;

  AtrocityItemFteched({required this.atrocity});

  List<Object> get props => [atrocity];
}

class AtrocityListFetchedByCategory extends AtrocityBlocEvent {
  final Category category;

  AtrocityListFetchedByCategory({required this.category});

  List<Object> get props => [category];
}

class FeaturedAtrocityListFetched extends AtrocityBlocEvent {
  final User user;
  FeaturedAtrocityListFetched({required this.user});
}
