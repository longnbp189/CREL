import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crel_mobile/modules/appointment/repos/appointment_repo.dart';
import 'package:equatable/equatable.dart';

part 'appointment_confirm_event.dart';
part 'appointment_confirm_state.dart';

class AppointmentConfirmBloc
    extends Bloc<AppointmentConfirmEvent, AppointmentConfirmState> {
  final AppointmentRepo appointmentRepo;
  AppointmentConfirmBloc({required this.appointmentRepo})
      : super(AppointmentConfirmLoading()) {
    on<GetAppointmentConfirm>(_onGetAppointmentConfirm);
  }

  FutureOr<void> _onGetAppointmentConfirm(GetAppointmentConfirm event,
      Emitter<AppointmentConfirmState> emit) async {
    emit(AppointmentConfirmLoading());
    try {
      // await Future.delayed(const Duration(seconds: 5));
      final number = await appointmentRepo.getListAppointmentConfirm();
      emit(AppointmentComfirmLoaded(number: number));
    } catch (e) {
      emit(AppointmentConfirmError(e.toString()));
    }
  }
}
