part of 'company_list_bloc.dart';

abstract class CompanyListEvent extends Equatable {
  const CompanyListEvent();

  @override
  List<Object> get props => [];
}

class CompanyListFetchedByCategory extends CompanyListEvent {
  final Category category;
  final User user;

  CompanyListFetchedByCategory({required this.category, required this.user});

  @override
  List<Object> get props => [category, user];
}

class FeaturedCompanyListFetched extends CompanyListEvent {}

class FetchCompanyList extends CompanyListEvent {
  final User user;
  FetchCompanyList({required this.user});

  @override
  List<Object> get props => [user];
}

class FetchCompanyListByCategory extends CompanyListEvent {
  final Category category;

  FetchCompanyListByCategory({required this.category});
}
