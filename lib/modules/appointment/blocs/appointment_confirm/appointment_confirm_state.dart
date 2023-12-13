part of 'appointment_confirm_bloc.dart';

abstract class AppointmentConfirmState extends Equatable {
  const AppointmentConfirmState();

  @override
  List<Object> get props => [];
}

class AppointmentConfirmLoading extends AppointmentConfirmState {}
// class AppointmentIdLoaded extends AppointmentConfirmState {
//   final Appointment appointment;

//   const AppointmentIdLoaded({required this.appointment});
//   @override
//   List<Object> get props => [appointment];
// }

class AppointmentComfirmLoaded extends AppointmentConfirmState {
  final int number;

  const AppointmentComfirmLoaded({required this.number});
  @override
  List<Object> get props => [number];
}

// class AppointmentLoaded extends AppointmentState {
//   final List<Appointment> appointments;
//   final bool hasReachedMax;
//   final int? status;

//   const AppointmentLoaded(
//       {this.appointments = const <Appointment>[],
//       this.hasReachedMax = false,
//       this.status});

//   AppointmentLoaded copyWith(
//       {List<Appointment>? appointments, bool? hasReachedMax, int? status}) {
//     return AppointmentLoaded(
//         appointments: appointments ?? this.appointments,
//         hasReachedMax: hasReachedMax ?? this.hasReachedMax,
//         status: status ?? this.status);
//   }

//   @override
//   List<Object> get props => [appointments, hasReachedMax];
// }

class AppointmentConfirmError extends AppointmentConfirmState {
  final String error;

  const AppointmentConfirmError(this.error);
  @override
  List<Object> get props => [error];
}
