import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/Data_Layer/Blocs/session_cubit.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Data_Layer/Models/manage_followers_model.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Models/order_item_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;
  final SessionBLoc sessionBLoc;

  ProfileBloc({required this.userRepository, required this.sessionBLoc})
      : super(ProfileState(status: ProfileStatus.initial)) {
    autoUploadProfile();
  }

  autoUploadProfile() async {
    User? user = await userRepository.userDao.getCurrentUser(0);
    if (user != null) {
      try {
        Profile profile = await userRepository.getProfileFromApi(user: user);
        emit(state.copyWith(
            profile: profile, status: ProfileStatus.successfull));
      } catch (e) {
        print(e);
      }
    } else {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }

  fetchQR(Profile profile) {
    return profile.qrCode;
  }

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchProfile) {
      try {
        User? user = await userRepository.userDao.getCurrentUser(0);
        Profile profile = await userRepository.getProfileFromApi(user: user!);
        ProfileState newState = state.copyWith(
            profile: profile, user: user, status: ProfileStatus.successfull);
        yield (newState);
        print('profile has been updated');
      } catch (e) {
        print(e.toString());
      }
      yield state.copyWith(
          profile: state.profile, status: ProfileStatus.failure);
    }
    if (event is FetchProfileAutoLogin) {
      yield (state.copyWith(
          profile: event.profile, status: ProfileStatus.successfull));
    }
    if (event is AddShirt) {
      yield state.copyWith(status: ProfileStatus.updating);
      try {
        await userRepository.addShirtToProfileList(shirt: event.addedShirt);
        Profile profile =
            await userRepository.getProfileFromApi(user: state.user!);
        yield (state.copyWith(
            profile: profile,
            status: ProfileStatus.successfull,
            user: state.user!));
      } catch (e) {
        print(e.toString());
      }
    }
    if (event is AddNonProfit) {
      yield state.copyWith(status: ProfileStatus.updating);
      try {
        await userRepository.addNonProfitToProfileList(
            nonprofit: event.nonProfit);
        Profile profile =
            await userRepository.getProfileFromApi(user: state.user!);
        yield (state.copyWith(
            profile: profile, status: ProfileStatus.successfull));
      } catch (e) {
        print(e.toString());
        yield state.copyWith(status: ProfileStatus.failure);
      }
    }
    if (event is AddAtrocity) {
      yield state.copyWith(status: ProfileStatus.updating);
      try {
        await userRepository.addAtrocityToProfileList(atrocity: event.atrocity);
        Profile profile =
            await userRepository.getProfileFromApi(user: state.user!);
        yield state.copyWith(
            profile: profile, status: ProfileStatus.successfull);
      } catch (e) {
        print(e.toString());
      }
    }
    if (event is ChangeProfilePicture) {
      yield state.copyWith(status: ProfileStatus.updating);
      try {
        await userRepository.changeProfilePicture(
            profilePic: event.profilePicture);
        Profile profile =
            await userRepository.getProfileFromApi(user: state.user!);
        yield state.copyWith(
            profile: state.profile, status: ProfileStatus.successfull);
      } catch (e) {
        print(e.toString());
        yield state.copyWith(status: ProfileStatus.failure);
      }
    }
    if (event is AddFollower) {
      try {
        await userRepository.manageFollowers(
          manageFollower: event.interaction,
          user: state.user!,
        );
        Profile profile =
            await userRepository.getProfileFromApi(user: state.user!);
        yield state.copyWith(
            profile: profile, status: ProfileStatus.successfull);
      } catch (e) {
        e.toString();
        state.copyWith(status: ProfileStatus.failure);
      }
    }

    // if (event is AddProfilePicture){
    //   User? user = await userRepository.userDao.getCurrentUser(0);
    //   Profile profile = await userRepository.getProfileFromApi(user: user!);
    //   try{
    //     await userRepository.add
    //   }
    // }
  }
}
