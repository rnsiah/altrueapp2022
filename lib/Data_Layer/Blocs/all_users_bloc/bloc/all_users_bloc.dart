import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/all_users_repository.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';

part 'all_users_event.dart';
part 'all_users_state.dart';

class AllUsersBloc extends Bloc<AllUsersEvent, AllUsersState> {
  UserRepository userRepository = UserRepository();
  AllUsersRepository allUsersRepository = AllUsersRepository();

  AllUsersBloc({required this.allUsersRepository, required this.userRepository})
      : super(AllUsersState(status: ProfileListStatus.initial));

  @override
  Stream<AllUsersState> mapEventToState(AllUsersEvent event) async* {
    if (event is FetchFindUserList) {
      yield state.copyWith(status: ProfileListStatus.loading);
      try {
        List<ProfileRepresentation> list =
            await allUsersRepository.getAllProfiles();
        yield state.copyWith(
            userList: list, status: ProfileListStatus.successful);
      } catch (e) {
        print(e.toString());
        yield state.copyWith(status: ProfileListStatus.failure);
      }
    }
  }
}
