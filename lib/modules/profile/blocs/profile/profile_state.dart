part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Broker user;
  const ProfileLoaded(this.user);
  @override
  List<Object> get props => [user];
}

class SuccessSaveUser extends ProfileState {}

class FaildSaveUser extends ProfileState {
  final String error;
  // final Broker user;
  const FaildSaveUser(this.error);
  @override
  List<Object> get props => [error];
}

// class SuccessSaveAvatar extends ProfileState {}

class SuccessSendEmail extends ProfileState {}

class SuccessChangePassword extends ProfileState {}

class ProfileError extends ProfileState {
  final String error;

  const ProfileError(this.error);
  @override
  List<Object> get props => [error];
}

class ResetPasswordError extends ProfileState {
  final String error;

  const ResetPasswordError(this.error);
  @override
  List<Object> get props => [error];
}
