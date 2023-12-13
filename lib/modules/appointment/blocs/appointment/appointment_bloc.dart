import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/modules/appointment/repos/appointment_repo.dart';
import 'package:equatable/equatable.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepo appointmentRepo;
  DateTime date = DateTime(DateTime.now().year, DateTime.now().month);

  int pageNum = 1;
  int pageSize = 30;
  int? status;
  AppointmentBloc({required this.appointmentRepo})
      : super(AppointmentLoading()) {
    on<GetAppointmentRequested>(_onGetAppointmentRequested);
    on<RefreshAppointmentRequested>(_onRefreshAppointmentRequested);
    on<GetAppointmentByIdRequested>(_onGetAppointmentByIdRequested);
    on<UpdateAppointmentRequested>(_onUpdateAppointmentRequested);
    on<GetListConfirmAppointment>(_onGetListConfirmAppointment);
    on<GetListAppointmentCalendar>(_onGetListAppointmentCalendar);
    on<CreateAppointmentRequested>(_onCreateAppointmentRequested);
    on<SearchAppointmentByMonth>(_onSearchAppointmentByMonth);
    on<RefuseAppointmentRequested>(_onRefuseAppointmentRequested);
    // on<GetListToCreateAppointment>(_onGetListToCreateAppointment);
  }

  // FutureOr<void> _onGetAppointmentRequested(
  //     GetAppointmentRequested event, Emitter<AppointmentState> emit) async {
  //   try {
  //     if (event.isInit!) {
  //       emit(AppointmentLoading());
  //     }
  //     final state = this.state;

  //     if (status != event.status) {
  //       emit(AppointmentLoading());
  //       status = event.status;
  //       pageNum = 1;
  //       final appointments = await appointmentRepo.getListAppointment(
  //           pageNum, pageSize, event.status, event.name);

  //       // add(GetBrandByIdRequested(appointments[index].brandId));
  //       // add(GetAppointmentByIdRequested(appointments[].id));
  //       emit(AppointmentLoaded(appointments: appointments));
  //     }
  //     if (state is AppointmentLoading) {
  //       pageNum = 1;
  //       final appointments = await appointmentRepo.getListAppointment(
  //           pageNum, pageSize, event.status, event.name);
  //       emit(AppointmentLoaded(appointments: appointments));
  //     } else {
  //       if (state is AppointmentLoaded) {
  //         final appointments = await appointmentRepo.getListAppointment(
  //             ++pageNum, pageSize, status, event.name);

  //         if (appointments.isEmpty) {
  //           emit(state.copyWith(hasReachedMax: true));
  //         } else {
  //           emit(state.copyWith(
  //               appointments: state.appointments + appointments));
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     emit(AppointmentError(e.toString()));
  //   }
  // }

  FutureOr<void> _onGetAppointmentRequested(
      GetAppointmentRequested event, Emitter<AppointmentState> emit) async {
    final state = this.state;
    if (event.isInit) {
      emit(AppointmentLoading());
    }
    try {
      if (state is AppointmentLoading || event.isInit) {
        pageNum = 1;
        final appointments =
            await appointmentRepo.getListAppointment(pageNum, pageSize);
        emit(AppointmentLoaded(appointments: appointments));
      } else {
        if (state is AppointmentLoaded) {
          final appointments =
              await appointmentRepo.getListAppointment(++pageNum, pageSize);

          if (appointments.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
          } else {
            if (pageNum > 1) {
              emit(state.copyWith(
                  appointments: state.appointments + appointments));
            } else {
              emit(AppointmentLoaded(appointments: appointments));
            }
          }
        }
      }
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  FutureOr<void> _onRefreshAppointmentRequested(
      RefreshAppointmentRequested event, Emitter<AppointmentState> emit) async {
    try {
      add(SearchAppointmentByMonth(
          event.startDayOfMonth, event.endDayOfMonth, true));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  FutureOr<void> _onGetAppointmentByIdRequested(
      GetAppointmentByIdRequested event, Emitter<AppointmentState> emit) async {
    final state = this.state;
    if (state is AppointmentConfirmLoaded ||
        state is AppointmentLoaded ||
        event.isInit) {
      try {
        emit(AppointmentLoading());
        final appointment = await appointmentRepo.getAppointmentById(event.id);
        emit(AppointmentIdLoaded(appointment: appointment));
      } catch (e) {
        emit(AppointmentError(e.toString()));
      }
    }
  }

  FutureOr<void> _onUpdateAppointmentRequested(
      UpdateAppointmentRequested event, Emitter<AppointmentState> emit) async {
    final state = this.state;
    // if (state is AppointmentConfirmLoaded || state is AppointmentLoaded) {
    try {
      emit(AppointmentLoading());
      await appointmentRepo.updateAppointment(event.appointment);

      emit(UpdateAppointmentSuccess());

      // await propertyForRentRepo.updateImage(event.image, event.property.id!);

      // await propertyForRentRepo.deleteMedia(
      //     event.mediaAdd!, event.mediaSaved!);
      // propertyForRentRepo.getPropertyForRentById(id)
      // emit(PropertyForRentLoading());
      // add();
      // Future.delayed(const Duration(milliseconds: 500), () {
// });
      add(SearchAppointmentByMonth(AppFormat.startDayOfMonth(date),
          AppFormat.endDayOfMonth(date), true));

      // var appointment =
      //     await appointmentRepo.getListConfirmAppointment(pageNum, pageSize);
      // var count = await appointmentRepo.getListAppointmentConfirm();

      // await Future<void>.delayed(const Duration(seconds: 1));

      // emit(
      //     AppointmentConfirmLoaded(appointments: appointment, number: count));
      // emit(AppointmentLoading());
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
    // }
  }

  FutureOr<void> _onGetListConfirmAppointment(
      GetListConfirmAppointment event, Emitter<AppointmentState> emit) async {
    final state = this.state;
    if (event.isInit) {
      emit(AppointmentLoading());
    }
    try {
      if (state is AppointmentLoading || event.isInit) {
        pageNum = 1;

        final appointments =
            await appointmentRepo.getListConfirmAppointment(pageNum, pageSize);
        var count = await appointmentRepo.getListAppointmentConfirm();
        emit(AppointmentConfirmLoaded(
            appointments: appointments, number: count));
      } else {
        if (state is AppointmentConfirmLoaded) {
          final appointments = await appointmentRepo.getListConfirmAppointment(
              ++pageNum, pageSize);

          if (appointments.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
          } else {
            if (pageNum > 1) {
              emit(state.copyWith(
                  appointments: state.appointments + appointments));
            } else {
              var count = await appointmentRepo.getListAppointmentConfirm();
              emit(AppointmentConfirmLoaded(
                  appointments: appointments, number: count));
            }
          }
        }
      }
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  FutureOr<void> _onGetListAppointmentCalendar(
      GetListAppointmentCalendar event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    try {
      final appointments = await appointmentRepo.getListAppointmentCalendar(
          event.startDate, event.endDate);
      emit(AppointmentLoaded(appointments: appointments));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  FutureOr<void> _onCreateAppointmentRequested(
      CreateAppointmentRequested event, Emitter<AppointmentState> emit) async {
    try {
      emit(AppointmentLoading());
      // final appointment =
      await appointmentRepo.createAppointment(event.appointment);
      // event.appointment.id = appointment.id;

      // await appointmentRepo.addListPropertyToAppointment(
      //     event.appointment.id!,
      //    );
      emit(CreateAppointmentSuccess());
      // emit(AppointmentLoading());

      add(SearchAppointmentByMonth(AppFormat.startDayOfMonth(date),
          AppFormat.endDayOfMonth(date), true));
      // emit(AppointmentLoaded(appointments: appointments));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  // FutureOr<void> _onSearchAppointmentByMonth(
  //     SearchAppointmentByMonth event, Emitter<AppointmentState> emit) async {
  //   emit(AppointmentLoading());

  //   try {
  //     final appointments = await appointmentRepo.searchAppointmentByMonth(

  //         1, pageSize, event.startDayOfMonth, event.endDayOfMonth);
  //     emit(AppointmentLoaded(appointments: appointments));

  //   } catch (e) {
  //     emit(AppointmentError(e.toString()));
  //   }
  // }

  FutureOr<void> _onSearchAppointmentByMonth(
      SearchAppointmentByMonth event, Emitter<AppointmentState> emit) async {
    // emit(AppointmentLoading());
    final state = this.state;

    try {
      if (event.isInit) {
        emit(AppointmentLoading());

        final appointments = await appointmentRepo.searchAppointmentByMonth(
            1, pageSize, event.startDayOfMonth, event.endDayOfMonth);
        emit(AppointmentLoaded(appointments: appointments));
      } else {
        if (state is AppointmentLoaded) {
          final appointments = await appointmentRepo.searchAppointmentByMonth(
              ++pageNum, pageSize, event.startDayOfMonth, event.endDayOfMonth);
          if (appointments.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
          } else {
            if (pageNum > 1) {
              emit(state.copyWith(
                  appointments: state.appointments + appointments));
            } else {
              emit(AppointmentLoaded(appointments: appointments));
            }
          }
        }
      }
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  // FutureOr<void> _onGetListToCreateAppointment(
  //     GetListToCreateAppointment event, Emitter<AppointmentState> emit) async {
  //   emit(AppointmentLoading());
  //   try {
  //     final appointments =
  //         await appointmentRepo.getListToCreateAppointment(event.date);
  //     emit(AppointmentLoaded(appointments: appointments));
  //   } catch (e) {
  //     emit(AppointmentError(e.toString()));
  //   }
  // }

  FutureOr<void> _onRefuseAppointmentRequested(
      RefuseAppointmentRequested event, Emitter<AppointmentState> emit) async {
    try {
      emit(AppointmentLoading());
      await appointmentRepo.updateAppointment(event.appointment);

      emit(RefuseAppointmentSuccess());

      // await propertyForRentRepo.updateImage(event.image, event.property.id!);

      // await propertyForRentRepo.deleteMedia(
      //     event.mediaAdd!, event.mediaSaved!);
      // propertyForRentRepo.getPropertyForRentById(id)
      // emit(PropertyForRentLoading());
      // add();
      // Future.delayed(const Duration(milliseconds: 500), () {
// });
      add(SearchAppointmentByMonth(AppFormat.startDayOfMonth(date),
          AppFormat.endDayOfMonth(date), true));

      // var appointment =
      //     await appointmentRepo.getListConfirmAppointment(pageNum, pageSize);
      // var count = await appointmentRepo.getListAppointmentConfirm();

      // await Future<void>.delayed(const Duration(seconds: 1));

      // emit(
      //     AppointmentConfirmLoaded(appointments: appointment, number: count));
      // emit(AppointmentLoading());
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }
}
