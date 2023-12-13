part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Loading extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

class LoginSuccessed extends AuthenticationState {}

class LoginFirstTime extends AuthenticationState {}

class UnAuthenticated extends AuthenticationState {}

class AuthenticatedError extends AuthenticationState {
  final String error;

  const AuthenticatedError(this.error);
  @override
  List<Object> get props => [error];
}
