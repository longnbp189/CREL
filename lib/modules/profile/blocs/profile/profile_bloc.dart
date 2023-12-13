import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:crel_mobile/models/broker.dart';
import 'package:crel_mobile/modules/authentication/repos/authentication_repo.dart';
import 'package:crel_mobile/modules/profile/repos/profile_repo.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo profileRepo;
  final AuthenticationRepo? authenticationRepo;

  ProfileBloc({required this.profileRepo, this.authenticationRepo})
      : super(ProfileLoading()) {
    on<GetProfileRequested>(_onGetProfileRequested);
    on<UpdateProfile>(_onUpdateProfileRequested);
    on<UpdateAvatar>(_onUpdateAvatarRequested);
    on<UpdatePassword>(_onUpdatePassword);
    on<ResetPassword>(_onResetPassword);
  }

  void _onGetProfileRequested(
      GetProfileRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      var user = await profileRepo.getProfile();

      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
      // authenticationRepo!.signOut();
    }
  }

  void _onUpdateProfileRequested(
      UpdateProfile event, Emitter<ProfileState> emit) async {
    // emit(ProfileLoading());
    final state = this.state;
    // if (state is ProfileLoaded) {
    try {
      emit(ProfileLoading());
      await profileRepo.updateProfile(event.user);
      if (event.image != null) {
        await profileRepo.updateAvatar(event.image!);
      }
      emit(SuccessSaveUser());
      // var user = await profileRepo.getProfile();
      // emit(ProfileLoaded(user));
      add(GetProfileRequested());
    } catch (e) {
      emit(FaildSaveUser(e.toString()));
      // emit(ProfileLoaded(event.user));
    }
    // }
  }

  void _onUpdateAvatarRequested(
      UpdateAvatar event, Emitter<ProfileState> emit) async {
    final state = this.state;
    if (state is ProfileLoaded) {
      try {
        emit(ProfileLoading());
        await profileRepo.updateAvatar(event.image);
        var user = await profileRepo.getProfile();
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    }
  }

  void _onUpdatePassword(
      UpdatePassword event, Emitter<ProfileState> emit) async {
    final state = this.state;
    // if (state is ProfileLoaded) {
    try {
      // emit(ProfileLoading());
      await profileRepo.updatePassword(event.oldPassword, event.newPassword);
      // var user = await profileRepo.getProfile();
      // emit(ProfileLoaded(user));
      emit(SuccessChangePassword());
      add(GetProfileRequested());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
    // }
  }

  FutureOr<void> _onResetPassword(
      ResetPassword event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());
      await profileRepo.resetPassword(event.email);
      emit(SuccessSendEmail());

      // var user = await profileRepo.getProfile();
      // emit(ProfileLoaded(user));
      // } on FormatException catch (e) {
      //   if (e.message == "404") {
      //     emit(const ResetProfileError("nhap lai di con"));
      //   }
      //   emit(ProfileError(e.toString()));
      // }

    } catch (e) {
      emit(ResetPasswordError(e.toString()));
    }
  }
}
