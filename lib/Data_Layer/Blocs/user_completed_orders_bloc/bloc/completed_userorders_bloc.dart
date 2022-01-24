import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/Data_Layer/Models/order_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Data_Layer/Repoositories/order_repository.dart';
import 'package:mobile/Data_Layer/Repoositories/user_repository.dart';

part 'completed_userorders_event.dart';
part 'completed_userorders_state.dart';

class CompletedUserordersBloc
    extends Bloc<CompletedUserordersEvent, CompletedUserordersState> {
  final OrderRepository orderRepository;
  final UserRepository userRepository;
  CompletedUserordersBloc(
      {required this.orderRepository, required this.userRepository})
      : super(CompletedUserordersState());

  @override
  Stream<CompletedUserordersState> mapEventToState(
    CompletedUserordersEvent event,
  ) async* {
    if (event is FetchCompletedOrders) {
      User? user = await userRepository.userDao.getCurrentUser(0);
      if(user != null){
        List<Order> completedOrders =
          await orderRepository.getUserCompletedOrders(user);
          for(var i =0; i< completedOrders.length; i++){
        
      }
      yield state.copyWith(completedOrders: completedOrders);
      }
      
    }
  }
}
