import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/Data_Layer/Models/category_model.dart';
import 'package:mobile/Data_Layer/Models/non_profit_model.dart';
import 'package:mobile/Data_Layer/Repoositories/nonProfit_repository.dart';

part 'nonprofit_event.dart';
part 'nonprofit_state.dart';

class NonprofitBloc extends Bloc<NonprofitEvent, NonprofitState> {
  final NonProfitRespository nonProfitRespository;
  NonprofitBloc({required this.nonProfitRespository})
      : super(NonprofitState(status: NonProfitStatus.initial)) {
    fetchNonProfitsOnLogin();
  }

  fetchNonProfitsOnLogin() async {
    if (state.status == NonProfitStatus.initial) {
      try {
        List<NonProfit> all = await nonProfitRespository.fetchNonProfits();

        if (all.length > 0) {
          NonprofitState newState = state.copyWith(
              nonprofitList: all, status: NonProfitStatus.success);
          emit(newState);
        }
      } catch (e) {
        print(e.toString());
        NonprofitState newState =
            state.copyWith(status: NonProfitStatus.failure);
        emit(newState);
      }
    }
  }

  @override
  Stream<NonprofitState> mapEventToState(
    NonprofitEvent event,
  ) async* {
    if (event is FetchNonProfitList) {
      try {
        List<NonProfit> nonprofitList =
            await nonProfitRespository.fetchNonProfits();
        NonprofitState newState = state.copyWith(
            nonprofitList: nonprofitList, status: NonProfitStatus.success);
        yield newState;
      } catch (e) {
        yield state.copyWith(status: NonProfitStatus.failure);
      }
    }
    if (event is FetchNonProfitItem) {
      try {
        await nonProfitRespository.fetchNonProfit(event.nonProfit.id);
      } catch (e) {
        yield state.copyWith(status: NonProfitStatus.failure);
      }
    }
    if (event is FetchNonProfitsByCategory) {
      NonprofitState newState = state.copyWith(categoryChange: false);
      yield newState;
      try {
        List<NonProfit> categoryList =
            await nonProfitRespository.fetchNonProfitByCategory(event.category);
        if (categoryList.isEmpty) {
          List<NonProfit> allNonProfits =
              await nonProfitRespository.fetchFeaturedNonProfits();
          NonprofitState newState = state.copyWith(
              categoryNonProfitList: allNonProfits,
              nonprofitList: state.nonprofitList,
              status: NonProfitStatus.success);
          yield newState;
        }
        NonprofitState newState = state.copyWith(
            categoryNonProfitList: categoryList,
            categoryChange: true,
            status: NonProfitStatus.success);
        yield newState;
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
