part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileRequested extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final Broker user;
  final File? image;
  const UpdateProfile(this.user, this.image);

  @override
  List<Object> get props => [user];
}

class UpdateAvatar extends ProfileEvent {
  final File image;
  const UpdateAvatar(this.image);

  @override
  List<Object> get props => [image];
}

class UpdatePassword extends ProfileEvent {
  final String oldPassword;
  final String newPassword;
  const UpdatePassword(this.newPassword, this.oldPassword);

  @override
  List<Object> get props => [newPassword, oldPassword];
}

class ResetPassword extends ProfileEvent {
  final String email;
  const ResetPassword(this.email);

  @override
  List<Object> get props => [email];
}


// class SelectMultipleImageEvent extends ProfileEvent {
//   final List<XFile> images;

//   const SelectMultipleImageEvent(this.images);
// }

// class UnSelectMultipleImageEvent extends ProfileEvent {}
