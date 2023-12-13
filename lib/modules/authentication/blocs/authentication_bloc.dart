import 'package:bloc/bloc.dart';
import 'package:crel_mobile/modules/authentication/repos/authentication_repo.dart';
import 'package:crel_mobile/modules/profile/repos/profile_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepo authenticationRepo;
  final ProfileRepo profileRepo;

  AuthenticationBloc(
      {required this.authenticationRepo, required this.profileRepo})
      : super(UnAuthenticated()) {
    on<SignInRequested>(_onSignInRequested);
    // When User Presses the SignOut Button, we will send the SignOutRequested Event to the AuthBloc to handle it and emit the UnAuthenticated State
    on<SignOutRequested>(_onSignOutRequested);
    on<AppStarted>(_onAppStarted);
  }

  void _onSignInRequested(
      SignInRequested event, Emitter<AuthenticationState> emit) async {
    emit(Loading());
    try {
      // await authenticationRepo.signInWithUsernamePassword(
      //     username: event.email, password: event.password);
      var status =
          await authenticationRepo.loginAPI(event.email, event.password);

      // emit(LoginSuccessed());
      if (status == 2) {
        emit(Authenticated());
      } else {
        emit(LoginFirstTime());
      }
    } catch (e) {
      emit(AuthenticatedError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  void _onSignOutRequested(
      SignOutRequested event, Emitter<AuthenticationState> emit) async {
    // emit(Loading());

    await authenticationRepo.signOut();
    emit(UnAuthenticated());
  }

  void _onAppStarted(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    emit(Loading());
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if (token == null) {
      emit(UnAuthenticated());
    } else {
      var broker = await profileRepo.getProfile();

      if (broker.status == 2) {
        emit(Authenticated());
      } else {
        emit(UnAuthenticated());
      }
    }
  }
}
