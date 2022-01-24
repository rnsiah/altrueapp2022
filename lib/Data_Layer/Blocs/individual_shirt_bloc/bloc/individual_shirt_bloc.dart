import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Repoositories/shirt_repository.dart';

part 'individual_shirt_event.dart';
part 'individual_shirt_state.dart';

class IndividualShirtBloc
    extends Bloc<IndividualShirtEvent, IndividualShirtState> {
  ShirtRepository shirtRepository;

  IndividualShirtBloc(this.shirtRepository) : super(IndiShirtLoadInProgress());

  @override
  Stream<IndividualShirtState> mapEventToState(
    IndividualShirtEvent event,
  ) async* {
    if (event is IndividualShirtLoaded) {
      try {
        Shirt shirt = await shirtRepository.fetchShirt(event.shirt.id!);
        yield IndiShirtLoadSuccess(shirt: shirt);
      } catch (e) {
        IndiShirtLoadFailure();
      }
      
    }
  }
}
