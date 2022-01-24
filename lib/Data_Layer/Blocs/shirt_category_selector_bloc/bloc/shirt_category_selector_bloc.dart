import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shirt_category_selector_event.dart';
part 'shirt_category_selector_state.dart';

class ShirtCategorySelectorBloc extends Bloc<ShirtCategorySelectorEvent, ShirtCategorySelectorState> {
  ShirtCategorySelectorBloc() : super(ShirtCategorySelectorInitial());

  @override
  Stream<ShirtCategorySelectorState> mapEventToState(
    ShirtCategorySelectorEvent event,
  ) async* {
  }
}
