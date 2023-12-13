part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

// When the user signing in with google this event is called and the [AuthRepository] is called to sign in the user
class SignInRequested extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);
}

// When the user signing out this event is called and the [AuthRepository] is called to sign out the user
class SignOutRequested extends AuthenticationEvent {}
