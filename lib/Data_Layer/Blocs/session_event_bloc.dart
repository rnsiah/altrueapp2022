import 'package:equatable/equatable.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';

abstract class SessionEvent extends Equatable {}

class ProfileBeingCompleted extends SessionEvent {
  final User user;
  final ProfileCompletion profileCompletion;

  ProfileBeingCompleted(
    this.user,
    this.profileCompletion,
  );
  List<Object> get props => [user, profileCompletion];
}

class Apploaded extends SessionEvent{
  @override
  List<Object?> get props => throw UnimplementedError();
}



class LoggedIn extends SessionEvent {
  final User user;

  LoggedIn({required this.user});

  List<Object> get props => [user];
}

class LoggedOut extends SessionEvent{
  @override
  
  List<Object?> get props => throw UnimplementedError();
  
  
}
