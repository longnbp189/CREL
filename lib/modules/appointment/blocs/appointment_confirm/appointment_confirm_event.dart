part of 'appointment_confirm_bloc.dart';

abstract class AppointmentConfirmEvent extends Equatable {
  const AppointmentConfirmEvent();

  @override
  List<Object> get props => [];
}

class GetAppointmentConfirm extends AppointmentConfirmEvent {}
