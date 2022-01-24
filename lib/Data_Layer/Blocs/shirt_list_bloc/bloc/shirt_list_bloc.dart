import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/Data_Layer/Blocs/shirt_bloc/bloc/shirt_bloc.dart';
import 'package:mobile/Data_Layer/Models/category_model.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Repoositories/category_repository.dart';
import 'package:mobile/Data_Layer/Repoositories/shirt_repository.dart';

part 'shirt_list_event.dart';
part 'shirt_list_state.dart';

class ShirtListBloc extends Bloc<ShirtListEvent, ShirtListState> {
  final ShirtRepository shirtRepository;
  ShirtBloc shirtBloc;
  CategoryRepository categoryRepository;

  ShirtListBloc({
    required this.shirtRepository,
    required this.categoryRepository,
    required this.shirtBloc,
  }) : super(UnknownShirtItem()) {
    // attemptShirt();
  }

  // void attemptShirt() async {
  //   final Shirt shirt = await shirtRepository.fetchShirt(id);
  // }

  @override
  Stream<ShirtListState> mapEventToState(
    ShirtListEvent event,
  ) async* {
    if (event is ShirtListChanged) {
      yield ShirtListLoading();
      try {
        List<Category> categoryList =
            await categoryRepository.fetchCatgegories();

        List<Shirt> povertyShirts =
            await shirtRepository.fetchShirtByCategory(event.category);
        if (povertyShirts.length > 1) {
          yield WorldPovertryShirtList(
              shirtList: povertyShirts, status: ShirtsLoaded.complete);
        } else {
          List<Shirt> allshirts = await shirtRepository.fetchShirtList();
          yield WorldPovertryShirtList(
              shirtList: allshirts, status: ShirtsLoaded.complete);
        }
      } catch (e) {
        yield ShirtListFailure(
            status: ShirtsLoaded.incomplete, message: e.toString());
      }
    }
  }
}
