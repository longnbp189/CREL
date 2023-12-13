part of 'appointment_bloc.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class AppointmentLoading extends AppointmentState {}

class CreateAppointmentSuccess extends AppointmentState {}

class UpdateAppointmentSuccess extends AppointmentState {}

class RefuseAppointmentSuccess extends AppointmentState {}

class AppointmentIdLoaded extends AppointmentState {
  final Appointment appointment;

  const AppointmentIdLoaded({required this.appointment});
  @override
  List<Object> get props => [appointment];
}

// class AppointmentComfirmLoaded extends AppointmentState {
//   final int number;

//   const AppointmentComfirmLoaded({required this.number});
//   @override
//   List<Object> get props => [number];
// }

class AppointmentLoaded extends AppointmentState {
  final List<Appointment> appointments;
  final bool hasReachedMax;
  final int? status;

  const AppointmentLoaded(
      {this.appointments = const <Appointment>[],
      this.hasReachedMax = false,
      this.status});

  AppointmentLoaded copyWith(
      {List<Appointment>? appointments, bool? hasReachedMax, int? status}) {
    return AppointmentLoaded(
        appointments: appointments ?? this.appointments,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [appointments, hasReachedMax];
}

class AppointmentConfirmLoaded extends AppointmentState {
  final List<Appointment> appointments;
  final bool hasReachedMax;
  final int? status;
  final int number;

  const AppointmentConfirmLoaded(
      {this.appointments = const <Appointment>[],
      this.hasReachedMax = false,
      this.number = 0,
      this.status});

  AppointmentConfirmLoaded copyWith(
      {List<Appointment>? appointments, bool? hasReachedMax, int? status}) {
    return AppointmentConfirmLoaded(
        appointments: appointments ?? this.appointments,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [appointments, hasReachedMax];
}

class AppointmentError extends AppointmentState {
  final String error;

  const AppointmentError(this.error);
  @override
  List<Object> get props => [error];
}
