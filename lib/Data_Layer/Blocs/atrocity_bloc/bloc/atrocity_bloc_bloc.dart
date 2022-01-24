import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:mobile/Data_Layer/Models/category_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';

import 'package:mobile/Data_Layer/Repoositories/atrocity_repositories.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';
import 'package:mobile/Presentation/Widgets/hompage/Featured_Atrocities/swiper.dart';

part 'atrocity_bloc_event.dart';
part 'atrocity_bloc_state.dart';

class AtrocityBlocBloc extends Bloc<AtrocityBlocEvent, AtrocityBlocState> {
  AtrocityRepository atrocityRepository;
  UserRepository userRepository = UserRepository();

  AtrocityBlocBloc({required this.atrocityRepository})
      : super(AtrocityBlocState()) {
    fetchAtrocitiesonStart();
  }

  fetchAtrocitiesonStart() async {
    User? user = await userRepository.userDao.getCurrentUser(0);
    if (user != null) {
      try {
        List<Atrocity> all = await atrocityRepository.getAtrocities();
        List<Atrocity> featured =
            await atrocityRepository.getFeaturedAtrocities();
        if (featured.length > 0) {
          emit(AtrocityBlocState(
              featuredAtrocities: featured,
              status: AtrocityStatus.success,
              atrocities: all));
        } else {
          emit(AtrocityBlocState(status: AtrocityStatus.failure));
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Stream<AtrocityBlocState> mapEventToState(
    AtrocityBlocEvent event,
  ) async* {
    if (event is AtrocityListFetched) {
      List<Atrocity> atrocity = await atrocityRepository.getAtrocities();

      for (var i = 0; i < atrocity.length; i++)
        yield state.copyWith(
            atrocities: atrocity, status: AtrocityStatus.success);
    }
    if (event is AtrocityItemFteched) {
      await atrocityRepository.getAtrocity(event.atrocity.id!);
    }
    if (event is AtrocityListFetchedByCategory) {
      yield state.copyWith(categoryChange: false);
      try {
        List<Atrocity> atrocityList =
            await atrocityRepository.getAtrocityListByCategory(event.category);
        if (atrocityList.length > 0) {
          AtrocityBlocState newState = state.copyWith(
              atrocities: state.atrocities,
              atrocityCategoryList: atrocityList,
              status: AtrocityStatus.success,
              categoryChange: true);
          yield newState;
        }
      } catch (e) {
        print(e.toString());
      }
      if (event is FeaturedAtrocities) {
        yield state.copyWith(status: AtrocityStatus.initial);
        try {
          List<Atrocity> atrocityList =
              await atrocityRepository.getFeaturedAtrocities();
          yield state.copyWith(
              featuredAtrocities: atrocityList, status: AtrocityStatus.success);
        } catch (e) {
          print(e.toString());
        }
      }
    }
  }
}
