import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/Data_Layer/Models/category_model.dart';
import 'package:mobile/Data_Layer/Models/company_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/company_repository.dart';

part 'company_list_event.dart';
part 'company_list_state.dart';

class CompanyListBloc extends Bloc<CompanyListEvent, CompanyListState> {
  final CompanyRepository companyRepository;
  CompanyListBloc({required this.companyRepository})
      : super(CompanyListState());

  @override
  Stream<CompanyListState> mapEventToState(CompanyListEvent event) async* {
    if (event is FetchCompanyList) {
      List<ForProfitCompany> company =
          await companyRepository.getCompanyList(user: event.user);

      yield state.copyWith(
          companies: company, status: CompanyListStatus.success);
    }
    if (event is CompanyListFetchedByCategory) {
      yield (CompanyListState(status: CompanyListStatus.loading));
      try {
        List<ForProfitCompany> company =
            await companyRepository.getCompanyListByCategory(
                user: event.user, category: event.category);
        if (company.length > 1) {
          yield CompanyListState(
              companies: company, status: CompanyListStatus.success);
        }
      } catch (e) {
        yield CompanyListFailed();
      }
    }
  }
}
