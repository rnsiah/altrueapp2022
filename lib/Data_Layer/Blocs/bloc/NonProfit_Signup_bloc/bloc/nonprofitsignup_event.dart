part of 'nonprofitsignup_bloc.dart';

class NonprofitsignupEvent extends Equatable {
  NonprofitsignupEvent();

  @override
  List<Object> get props => [];
}

class NonProfitNameChangeOnForm extends NonprofitsignupEvent {
  final String npName;

  NonProfitNameChangeOnForm({required this.npName});

  @override
  List<Object> get props => [npName];
}

class NonProfitAddressChangeOnForm extends NonprofitsignupEvent {
  final String npAddress;
  NonProfitAddressChangeOnForm({required this.npAddress});

  @override
  List<Object> get props => [npAddress];
}

class NonProfitInstagramChangeOnForm extends NonprofitsignupEvent {
  final String npInstagram;

  NonProfitInstagramChangeOnForm({required this.npInstagram});

  @override
  List<Object> get props => [npInstagram];
}

class NonProfitFacebookChangeOnForm extends NonprofitsignupEvent {
  final String npFacebook;

  NonProfitFacebookChangeOnForm({required this.npFacebook});

  @override
  List<Object> get props => [npFacebook];
}

class NonProfitStateChangeOnForm extends NonprofitsignupEvent {
  final String npState;
  NonProfitStateChangeOnForm({required this.npState});

  @override
  List<Object> get props => [npState];
}

class NonProfitMissionStatementChangeOnForm extends NonprofitsignupEvent {
  final String npMission;

  NonProfitMissionStatementChangeOnForm({required this.npMission});

  @override
  List<Object> get props => [npMission];
}

class NonProfitVisionStatementChangeOnForm extends NonprofitsignupEvent {
  final String npVision;

  NonProfitVisionStatementChangeOnForm({required this.npVision});

  @override
  List<Object> get props => [npVision];
}

class NonProfitWebsiteChangeOnForm extends NonprofitsignupEvent {
  final String npWebsite;

  NonProfitWebsiteChangeOnForm({required this.npWebsite});
  @override
  List<Object> get props => [npWebsite];
}

class NonProfitDescriptionChangeOnForm extends NonprofitsignupEvent {
  final String npDescription;

  NonProfitDescriptionChangeOnForm({required this.npDescription});

  @override
  List<Object> get props => [npDescription];
}

class NonProfitLogoChangeOnForm extends NonprofitsignupEvent {
  final dynamic npLogo;

  NonProfitLogoChangeOnForm({required this.npLogo});

  @override
  List<Object> get props => [];
}

class NonProfitMainImageChangeOnForm extends NonprofitsignupEvent {
  final dynamic npMainImage;

  NonProfitMainImageChangeOnForm({required this.npMainImage});

  @override
  List<Object> get props => [npMainImage];
}

class NonProfitYearStartedChangeOnForm extends NonprofitsignupEvent {
  final int npYearStarted;

  NonProfitYearStartedChangeOnForm({required this.npYearStarted});

  @override
  List<Object> get props => [npYearStarted];
}

class NonProfitSignUpFormCompletion extends NonprofitsignupEvent {
  final String name;
  final String website;
  final String mission;
  final String vision;
  final int yearStarteed;
  final String description;
  final Profile profile;

  final String? facebook;
  final String? instagram;

  NonProfitSignUpFormCompletion({
    required this.name,
    this.instagram,
    this.facebook,
    required this.profile,
    required this.mission,
    required this.vision,
    required this.description,
    required this.website,
    required this.yearStarteed,
  });

  @override
  List<Object> get props =>
      [name, mission, profile, vision, description, website, yearStarteed];
}

class NonProfitCreationError extends NonprofitsignupEvent {
  final String errorMessage;
  NonProfitCreationError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
