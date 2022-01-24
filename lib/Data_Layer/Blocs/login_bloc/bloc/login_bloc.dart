import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/Data_Layer/Blocs/session_cubit.dart';
import 'package:mobile/Data_Layer/Blocs/session_event_bloc.dart';

import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';

import '../../form_submission_status.dart';
import 'login_state.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final SessionBLoc sessionBLoc;

  LoginBloc({required this.userRepository, required this.sessionBLoc})
      : super(LoginState());

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEmailChange) {
      yield state.copyWith(email: event.email);
    } else if (event is LoginPassWordChange) {
      yield state.copyWith(password: event.password);
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        User user = await userRepository.authenticate(
            email: event.email, password: event.password);
        
        yield state.copyWith(formStatus: SubmissionSuccess());
        sessionBLoc.add(LoggedIn(user: user));
      } catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFaiiled('exception'));
      }
    }
  }
}
