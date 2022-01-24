part of 'create_company_bloc.dart';

class CreateCompanyState extends Equatable {
  final String companyName;
  final Profile? profile;
  final String missionStatement;
  final String companyAddress;
  final String description;
  final String facebook;
  final String instagram;
  final dynamic logo;
  final dynamic mainImage;
  final String wehsite;
  final String yearStarted;
  final FormSubmissionStatus? formStatus;
  CreateCompanyState(
      {this.profile,
      this.formStatus = const InitialFormStatus(),
      this.wehsite = '',
      this.companyAddress = '',
      this.companyName = '',
      this.description = '',
      this.facebook = '',
      this.instagram = '',
      this.logo,
      this.missionStatement = '',
      this.mainImage,
      this.yearStarted = ''});

  CreateCompanyState copyWith(
      {String? companyAddress,
      String? companyName,
      String? website,
      String? description,
      String? facebook,
      String? instagram,
      dynamic logo,
      dynamic mainImage,
      String? yearStarted,
      Profile? profile,
      String? missionStatement,
      FormSubmissionStatus? formStatus}) {
    return CreateCompanyState(
        companyAddress: companyAddress ?? this.companyAddress,
        wehsite: website ?? this.wehsite,
        companyName: companyName ?? this.companyName,
        facebook: facebook ?? this.facebook,
        instagram: instagram ?? this.instagram,
        mainImage: mainImage ?? this.mainImage,
        logo: logo ?? this.logo,
        missionStatement: missionStatement ?? this.missionStatement,
        description: description ?? this.description,
        profile: profile ?? this.profile,
        yearStarted: yearStarted ?? this.yearStarted,
        formStatus: formStatus ?? this.formStatus);
  }

  @override
  List<Object> get props => [
        companyAddress,
        companyName,
        facebook,
        instagram,
        wehsite,
        missionStatement,
        description,
        yearStarted,
        logo,
        mainImage,
      ];
}

class CreateCompanyInitial extends CreateCompanyState {}
