import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/Data_Layer/Blocs/form_submission_status.dart';
import 'package:mobile/Data_Layer/Models/company_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/company_repository.dart';

part 'create_company_event.dart';
part 'create_company_state.dart';

class CreateCompanyBloc extends Bloc<CreateCompanyEvent, CreateCompanyState> {
  final CompanyRepository companyRepository = CompanyRepository();

  CreateCompanyBloc() : super(CreateCompanyState());

  Stream<CreateCompanyState> mapEventToState(CreateCompanyEvent event) async* {
    if (event is CompanyAddressChange) {
      yield state.copyWith(companyAddress: event.companyAddress);
    } else if (event is CompanyFacebookChange) {
      yield state.copyWith(facebook: event.comFacebook);
    } else if (event is CompanyInstagramChange) {
      yield state.copyWith(instagram: event.comInsta);
    } else if (event is CompanyNameChange) {
      yield state.copyWith(companyName: event.companyName);
    } else if (event is CompanyYearStartedChanged) {
      yield state.copyWith(yearStarted: event.companyYear);
    } else if (event is CompanyMissionChanged) {
      yield state.copyWith(missionStatement: event.comMission);
    } else if (event is CompanyLogoChanged) {
      yield state.copyWith(logo: event.logo);
    } else if (event is CompanyDescriptionChange) {
      yield state.copyWith(description: event.companyDescription);
    } else if (event is CompanyMainImageChange) {
      yield state.copyWith(mainImage: event.compMainImage);
    } else if (event is CompanyWebsiteChange) {
      yield state.copyWith(website: event.companyWebsite);
    } else if (event is CompanyAttemptCreate) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        CompanyCompletion company = CompanyCompletion(
            companyAddress: state.companyAddress,
            companyName: state.companyName,
            description: state.description,
            logo: state.logo,
            instagram: state.instagram,
            facebook: state.facebook,
            mainImage: state.mainImage,
            wehsite: state.wehsite,
            profile: event.profile,
            yearStarted: state.yearStarted);

        bool companyCreated =
            await companyRepository.createCompany(completedCompany: company);

        if (companyCreated == true) {
          state.copyWith(formStatus: SubmissionSuccess());
        }
      } catch (e) {
        state.copyWith(formStatus: SubmissionFaiiled(e.toString()));
        print(e.toString());
      }
    }
  }
}
