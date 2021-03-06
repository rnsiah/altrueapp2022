part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfile extends ProfileEvent {
  final Profile profile;
  FetchProfile({required this.profile});
}

class LoadQR extends ProfileEvent {
  final Profile profile;
  LoadQR({required this.profile});
}

class FetchProfileAutoLogin extends ProfileEvent {
  final Profile profile;
  FetchProfileAutoLogin({required this.profile});
}

class AddShirt extends ProfileEvent {
  final Shirt addedShirt;
  AddShirt({required this.addedShirt});
}

class DeleteShirt extends ProfileEvent {
  final Shirt deletedShirt;
  DeleteShirt({required this.deletedShirt});
}

class AddAtrocity extends ProfileEvent {
  final Atrocity atrocity;
  AddAtrocity({required this.atrocity});
}

class AddNonProfit extends ProfileEvent {
  final NonProfit nonProfit;
  AddNonProfit({required this.nonProfit});
}

class ChangeProfilePicture extends ProfileEvent {
  final XFile profilePicture;
  ChangeProfilePicture({required this.profilePicture});
}

class AddUserToFollow extends ProfileEvent {
  final int profileToFollow;
  AddUserToFollow({required this.profileToFollow});
}

class AddOrderItem extends ProfileEvent {
  final OrderItem orderItem;
  AddOrderItem({required this.orderItem});
}

class SubmitOrderItems extends ProfileEvent {
  final List<OrderItem> orderItems;
  SubmitOrderItems({required this.orderItems});
}

class AddFollower extends ProfileEvent {
  final ManageFollower interaction;

  AddFollower({required this.interaction});
}

class RemoveFollower extends ProfileEvent {
  final ManageFollower interaction;
  RemoveFollower({required this.interaction});
}

class LogOut extends ProfileEvent {}
