part of 'profile_bloc.dart';

enum ProfileStatus { initial, successfull, failure, updating }

class ProfileState extends Equatable {

  final User? user;
  final Profile? profile;
  final ProfileStatus status;
  

  const ProfileState({this.user, this.profile, this.status = ProfileStatus.initial});

  ProfileState copyWith({
    User? user,
    Profile? profile,
    ProfileStatus? status,
  }){
    return ProfileState(user:user?? this.user, profile: profile?? this.profile, status: status ?? this.status);
  }

  @override
  List<Object> get props => [];
}
