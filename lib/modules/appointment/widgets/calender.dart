import 'dart:async';

import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/appointment.dart' as meeting;
import 'package:crel_mobile/modules/appointment/blocs/appointment/appointment_bloc.dart';
import 'package:crel_mobile/modules/appointment/widgets/appointment_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  List<meeting.Appointment> _appointmentDetails = [];
  List<meeting.Appointment> _appointments = [];
  bool isInit = true;
  bool isInitCalendar = true;
  bool isCurrentMonth = true;
  DateTime initDateTime = DateTime.now();

  int nearTime(List<meeting.Appointment> appointment) {
    for (var i = 0; i < appointment.length; i++) {
      if (appointment[i].onDateTime!.compareTo(DateTime.now()) >= 0) {
        return i;
      }
    }
    return appointment.length - 1;
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      setState(() {
        _handlerAppointmentDetail(calendarTapDetails.date!);
      });
    }
  }

  void _handlerAppointmentDetail(DateTime date) {
    _appointmentDetails = _appointments
        .where((element) =>
            date ==
            DateTime(element.onDateTime!.year, element.onDateTime!.month,
                element.onDateTime!.day))
        .toList();
    _appointmentDetails.sort((a, b) => a.onDateTime!.compareTo(b.onDateTime!));
    if (date ==
            DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day) &&
        _appointmentDetails.isNotEmpty) {
      Timer(const Duration(milliseconds: 50), () {
        itemScrollController.scrollTo(
            index: nearTime(_appointmentDetails),
            duration: const Duration(seconds: 1));
      });
    }
  }

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppointmentBloc, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentError) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("AppointmentError")));
          }
          if (state is AppointmentLoaded) {
            Timer(const Duration(milliseconds: 50), () {
              setState(() {
                isCurrentMonth = false;
              });
            });
          }
        },
        buildWhen: (previous, current) {
          return previous != current && isCurrentMonth;
        },
        builder: (context, state) {
          if (state is AppointmentLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AppointmentLoaded) {
            _appointments = state.appointments;
            if (isInit) {
              _handlerAppointmentDetail(DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day));
              isInit = false;
            }
            return SafeArea(
              child: Theme(
                data: ThemeData.light().copyWith(
                    colorScheme: const ColorScheme.light(
                  primary: AppColor.primaryColor,
                )),
                child: Column(
                  children: [
                    SfCalendar(
                      onTap: calendarTapped,
                      view: CalendarView.month,
                      showDatePickerButton: true,
                      monthViewSettings: const MonthViewSettings(
                        showAgenda: false,
                      ),
                      initialSelectedDate: DateTime.now(),
                      initialDisplayDate: initDateTime,
                      dataSource: MeetingDataSource(_appointments),
                      onViewChanged: (ViewChangedDetails details) {
                        DateTime startDate = details.visibleDates[0];
                        DateTime endDate = details
                            .visibleDates[details.visibleDates.length - 1]
                            .add(const Duration(days: 1));
                        initDateTime = details.visibleDates
                            .where((element) => element.day == 15)
                            .first;
                        print(initDateTime.toString());
                        if (!isInitCalendar && !isCurrentMonth) {
                          context.read<AppointmentBloc>().add(
                              GetListAppointmentCalendar(startDate, endDate));
                          isCurrentMonth = true;
                        }
                        isInitCalendar = false;
                      },
                    ),
                    Expanded(
                        child: Container(
                      color: AppColor.backgroundColor,
                      child: ScrollablePositionedList.builder(
                        itemScrollController: itemScrollController,
                        itemPositionsListener: itemPositionsListener,
                        itemCount: _appointmentDetails.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AppointmentDetail(
                                          appointment:
                                              _appointmentDetails[index],
                                        ));
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            AppFormat.parseTime(
                                                _appointmentDetails[index]
                                                    .onDateTime
                                                    .toString()),
                                            style: TxtStyle.heading4.copyWith(
                                                fontWeight: FontWeight.bold),
                                          ))),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                      flex: 12,
                                      child: IntrinsicHeight(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                width: 5,
                                                decoration: BoxDecoration(
                                                  color: AppFormat
                                                      .statusColorAppointment(
                                                          _appointmentDetails[
                                                                  index]
                                                              .status!),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            _appointmentDetails[
                                                                    index]
                                                                .brand!
                                                                .name
                                                                .toString(),
                                                            style: TxtStyle
                                                                .heading4,
                                                          ),
                                                          Text(
                                                            AppFormat.phoneFormat(
                                                                _appointmentDetails[
                                                                        index]
                                                                    .brand!
                                                                    .phoneNumber
                                                                    .toString()),
                                                            style: TxtStyle
                                                                .heading4,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        AppFormat.getAddress(
                                                            _appointmentDetails[
                                                                    index]
                                                                .property!),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            TxtStyle.heading4,
                                                      ),
                                                      // Align(
                                                      //   alignment: Alignment.centerRight,
                                                      //   child: Text(
                                                      //     _appointmentDetails[index]
                                                      //             .brand!
                                                      //             .name
                                                      //             .toString() +
                                                      //         " <" +
                                                      //         _appointmentDetails[index]
                                                      //             .brand!
                                                      //             .phoneNumber
                                                      //             .toString() +
                                                      //         ">",
                                                      //     style: TxtStyle.heading4,
                                                      //   ),
                                                      // ),
                                                      // Text(
                                                      //   _appointmentDetails[index]
                                                      //       .property!
                                                      //       .name
                                                      //       .toString(),
                                                      //   style: TxtStyle.heading4,
                                                      //   maxLines: 2,
                                                      //   overflow: TextOverflow.ellipsis,
                                                      // ),
                                                      // Text(
                                                      //   AppFormat.getAddress(
                                                      //       _appointmentDetails[index]
                                                      //           .property!),
                                                      //   style: TxtStyle.heading4,
                                                      //   maxLines: 2,
                                                      //   overflow: TextOverflow.ellipsis,
                                                      // )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ))
                  ],
                ),
              ),
            );
          }
          return Text("$state");
        },
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<meeting.Appointment> source) {
    appointments = [];
    for (var element in source) {
      appointments!.add(Appointment(
          startTime: element.onDateTime!,
          endTime: element.onDateTime!,
          subject: element.brand!.name.toString(),
          color: AppFormat.statusColorAppointment(element.status!)));
    }
    // appointments = source;
  }
}
