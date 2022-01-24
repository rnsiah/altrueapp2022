part of 'company_list_bloc.dart';

enum CompanyListStatus {inital, success, loading ,failed}

 class CompanyListState extends Equatable {
   final List<ForProfitCompany> companies;
   final CompanyListStatus status;

  const CompanyListState({this.companies = const [], this.status=CompanyListStatus.inital});

  CompanyListState copyWith({
    final List<ForProfitCompany>? companies,
    final CompanyListStatus? status
  }){
    return CompanyListState(companies: companies?? this.companies, status: status?? this.status);
  }
  
  @override
  List<Object> get props => [];
}

class CompanyListFailed extends CompanyListState{}