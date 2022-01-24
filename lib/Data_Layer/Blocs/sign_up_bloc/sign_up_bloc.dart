import 'package:mobile/Data_Layer/Blocs/form_submission_status.dart';
import 'package:mobile/Data_Layer/Blocs/validationCubit.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';

import 'sign_up_event.dart';
import 'sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository userRepository;
  final ValidationCubit validationCubit;

  SignUpBloc({required this.userRepository, required this.validationCubit})
      : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    // email updated
    if (event is SignUpEmailChanged) {
      yield state.copyWith(email: event.email);

      // p1 updated
    } else if (event is SignUpPassword1Changed) {
      yield state.copyWith(password1: event.password1);

      //p2 updated
    } else if (event is SignUpPassword2Changed) {
      yield state.copyWith(password2: event.password2);

      //form submittem
    } else if (event is SignUpSubmittedWithoutConfirmaation) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final User user = await userRepository.register(
            email: event.email,
            password1: event.password1,
            password2: event.password2);
        yield state.copyWith(formStatus: SubmissionSuccess());
        validationCubit.showUserProfileCompletion(user);
        
      } catch (e) {
        yield state.copyWith(
            formStatus: SubmissionFaiiled('Your Submission Failed '));
      }
    }
  }
}
