import 'package:crel_mobile/modules/appointment/blocs/appointment/appointment_bloc.dart';
import 'package:crel_mobile/modules/appointment/repos/appointment_repo.dart';
import 'package:crel_mobile/modules/appointment/widgets/tab_bar_view_one_appointment.dart';
import 'package:crel_mobile/modules/appointment/widgets/tab_bar_view_two_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarViewAppointment extends StatefulWidget {
  const TabBarViewAppointment({
    Key? key,
    required TabController tabController,
    required this.size,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final Size size;

  @override
  State<TabBarViewAppointment> createState() => _TabBarViewAppointmentState();
}

class _TabBarViewAppointmentState extends State<TabBarViewAppointment> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: widget._tabController,
        children: [
          BlocProvider<AppointmentBloc>(
            create: (context) => AppointmentBloc(
                appointmentRepo:
                    RepositoryProvider.of<AppointmentRepo>(context))
            // ..add(SearchAppointmentByMonth(AppFormat.startDayOfMonth(now),
            // AppFormat.endDayOfMonth(now), 2, true))
            ,
            child: const TabBarViewOneAppointment(),
          ),
          // BlocProvider<AppointmentBloc>(
          //   create: (context) => AppointmentBloc(
          //       appointmentRepo:
          //           RepositoryProvider.of<AppointmentRepo>(context))
          //     ..add(const GetListConfirmAppointment(true)),
          //   child:
          BlocProvider<AppointmentBloc>(
            create: (context) => AppointmentBloc(
                appointmentRepo:
                    RepositoryProvider.of<AppointmentRepo>(context)),
            child: const TabBarViewTwoAppointment(),
          ),
          // ),
        ],
      ),
    );
  }
}
