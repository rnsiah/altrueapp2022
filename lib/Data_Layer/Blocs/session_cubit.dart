import 'dart:async';
import 'dart:core';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/session_event_bloc.dart';
import 'package:mobile/Data_Layer/Blocs/session_state.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';

class SessionBLoc extends Bloc<SessionEvent, SessionState> {
  final UserRepository userRepository;

  SessionBLoc({
    required this.userRepository,
  }) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    final sessionOpen = await userRepository.hasToken();

    if (sessionOpen == true) {
      User? user = await userRepository.userDao.getCurrentUser(0);
      if (user != null) {
        if (user.hasProfile == 0) {
          // ignore: invalid_use_of_visible_for_testing_member
          emit(Authenticated(
            user: user,
          ));
        } else if (user.hasProfile == 1) {
          await userRepository.getUpdatedUserFromApi(user);
          Profile profile = await userRepository.getProfileFromApi(user: user);
          emit(AuthenticatedWithProfile(
              profile: profile, status: ProfileComplete.complete, user: user));
        }
      }
    }
    if (sessionOpen == false) {
      showAuthProcess();
    }
  }

  void logInUser({required User user}) {
    user = User(
        altid: user.altid,
        email: user.email,
        key: user.key,
        hasProfile: 0,
        id: user.id);
  }

  void showProfileComplete({required User user}) =>
      emit(Authenticated(user: user));

  void showAuthProcess() => emit(Unauthenticated());

  void showSession(User loggedInUser) async {
    User loggedinUser = User(
        hasProfile: loggedInUser.hasProfile,
        id: loggedInUser.id,
        email: loggedInUser.email,
        altid: loggedInUser.altid,
        key: loggedInUser.key);
    emit(Authenticated(user: loggedinUser));
  }

  void signOut() {
    userRepository.deleteToken(localid: 0);
    emit(Unauthenticated());
  }

  @override
  Stream<SessionState> mapEventToState(SessionEvent event) async* {
    if (event is Apploaded) {
      yield* _mapAppLoadedToState(event);
    }
    if (event is LoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }
    if (event is LoggedOut) {
      _mapUserLoggedOutToState(event);
    }
    if (event is ProfileBeingCompleted) {
      yield* _mapUserProfileEditToState(event);
    }
  }

  Stream<SessionState> _mapUserProfileEditToState(
      ProfileBeingCompleted event) async* {
    yield Authenticated(user: event.user);
  }

  Stream<SessionState> _mapAppLoadedToState(Apploaded event) async* {
    yield AuthtLoading();
    try {
      await Future.delayed(Duration(milliseconds: 700));
      final currentUser = await userRepository.userDao.getCurrentUser(0);
      if (currentUser != null && currentUser.hasProfile == 1) {
        Profile profile =
            await userRepository.getProfileFromApi(user: currentUser);

        yield AuthenticatedWithProfile(
            profile: profile,
            user: currentUser,
            status: ProfileComplete.complete);
      } else if (currentUser != null && currentUser.hasProfile == 0) {
        yield Authenticated(user: currentUser);
      } else {
        yield Unauthenticated();
      }
    } catch (e) {
      yield AuthFailure(message: e.toString());
    }
  }

  Stream<SessionState> _mapUserLoggedInToState(LoggedIn event) async* {
    final profileCheck =
        await userRepository.userDao.checkIfProfileComplete(event.user.altid!);

    if (profileCheck == 0) {
      yield Authenticated(user: event.user);
    }
    Profile profile = await userRepository.getProfileFromApi(user: event.user);
    yield AuthenticatedWithProfile(
        profile: profile, user: event.user, status: ProfileComplete.incomplete);
  }

  Stream<SessionState> _mapUserLoggedOutToState(LoggedOut event) async* {
    signOut();
  }
}
