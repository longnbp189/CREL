part of 'appointment_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

// class GetAppointmentRequested extends AppointmentEvent {
//   final int? status;
//   final String name;
//   final bool? isInit;
//   const GetAppointmentRequested(this.status, this.name, this.isInit);
//   @override
//   List<Object> get props => [];
// }

class GetAppointmentRequested extends AppointmentEvent {
  final bool isInit;
  const GetAppointmentRequested(this.isInit);
  @override
  List<Object> get props => [];
}

class GetListConfirmAppointment extends AppointmentEvent {
  final bool isInit;
  const GetListConfirmAppointment(this.isInit);
  @override
  List<Object> get props => [];
}

class SearchAppointmentByMonth extends AppointmentEvent {
  final DateTime startDayOfMonth;
  final DateTime endDayOfMonth;
  // final int status;
  final bool isInit;
  const SearchAppointmentByMonth(
      this.startDayOfMonth, this.endDayOfMonth, this.isInit);
  @override
  List<Object> get props => [startDayOfMonth, endDayOfMonth, isInit];
}

class GetListAppointmentCalendar extends AppointmentEvent {
  final DateTime startDate;
  final DateTime endDate;
  const GetListAppointmentCalendar(this.startDate, this.endDate);
  @override
  List<Object> get props => [startDate, endDate];
}

class GetListToCreateAppointment extends AppointmentEvent {
  final DateTime date;
  const GetListToCreateAppointment(this.date);
  @override
  List<Object> get props => [date];
}

class UpdateAppointmentRequested extends AppointmentEvent {
  final Appointment appointment;
  const UpdateAppointmentRequested(this.appointment);
  @override
  List<Object> get props => [appointment];
}

class RefuseAppointmentRequested extends AppointmentEvent {
  final Appointment appointment;
  const RefuseAppointmentRequested(this.appointment);
  @override
  List<Object> get props => [appointment];
}

class CreateAppointmentRequested extends AppointmentEvent {
  final Appointment appointment;
  const CreateAppointmentRequested(this.appointment);
  @override
  List<Object> get props => [appointment];
}

// class GetAppointmentConfirm extends AppointmentEvent {
//   // final int? status;
//   final String name;
//   final bool? isInit;
//   const GetAppointmentConfirm(
//       // this.status,
//       this.name,
//       this.isInit);
//   @override
//   List<Object> get props => [];
// }

class GetAppointmentByIdRequested extends AppointmentEvent {
  final int id;
  final bool isInit;

  const GetAppointmentByIdRequested(this.id, this.isInit);
  @override
  List<Object> get props => [id, isInit];
}

class RefreshAppointmentRequested extends AppointmentEvent {
  final DateTime startDayOfMonth;
  final DateTime endDayOfMonth;
  final int status;
  const RefreshAppointmentRequested(
      this.startDayOfMonth, this.endDayOfMonth, this.status);
  @override
  List<Object> get props => [startDayOfMonth, endDayOfMonth, status];
}
