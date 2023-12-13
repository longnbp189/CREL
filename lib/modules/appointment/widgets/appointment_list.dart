import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/modules/appointment/blocs/appointment/appointment_bloc.dart';
import 'package:crel_mobile/modules/appointment/blocs/appointment_confirm/appointment_confirm_bloc.dart';
import 'package:crel_mobile/modules/appointment/widgets/item_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppointmentList extends StatefulWidget {
  final ScrollController scrollController;
  final RefreshCallback onRefresh;
  const AppointmentList(
      {Key? key, required this.scrollController, required this.onRefresh})
      : super(key: key);

  @override
  State<AppointmentList> createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime(DateTime.now().year, DateTime.now().month);

    // int count = 0;
    return BlocConsumer<AppointmentBloc, AppointmentState>(
      listener: (context, state) {
        if (state is AppointmentConfirmLoaded) {
          context.read<AppointmentConfirmBloc>().add(GetAppointmentConfirm());
        }
        if (state is AppointmentError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("AppointmentError")));
        }
        // if (state is UpdateAppointmentSuccess) {
        //   // context.read<AppointmentBloc>().add(SearchAppointmentByMonth(
        //   //     AppFormat.startDayOfMonth(date),
        //   //     AppFormat.endDayOfMonth(date),
        //   //     true));
        //   AppFormat.showSnackBar(context, 1, "Cập nhật status thành công");
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, AppRouter.customNavBar, (route) => false,
        //       arguments: 3);
        // }
      },
      builder: (context, state) {
        if (state is AppointmentLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is AppointmentLoaded) {
          return ListAppointment(
            appointments: state.appointments,
            onRefresh: widget.onRefresh,
            scrollController: widget.scrollController,
            hasReachMax: state.hasReachedMax,
          );
        }
        if (state is AppointmentConfirmLoaded) {
          return ListAppointment(
            appointments: state.appointments,
            onRefresh: widget.onRefresh,
            scrollController: widget.scrollController,
            hasReachMax: state.hasReachedMax,
          );
        }
        return Text("$state");
      },
    );
  }
}

class ListAppointment extends StatelessWidget {
  const ListAppointment(
      {Key? key,
      required this.onRefresh,
      required this.scrollController,
      required this.appointments,
      required this.hasReachMax})
      : super(key: key);

  final RefreshCallback onRefresh;
  final ScrollController scrollController;
  final List<Appointment> appointments;
  final bool hasReachMax;

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/empty.svg',
                  height: 250,
                ),
                const Text(
                  "Danh sách trống",
                  style: TxtStyle.heading2,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
          // physics: const AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          // reverse: true,
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          itemCount:
              hasReachMax ? appointments.length : appointments.length + 1,
          itemBuilder: (context, index) {
            if (index >= appointments.length) {
              return (appointments.length >= 9)
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox();
            } else {
              return ItemAppointment(
                // size: size,
                appointment: appointments[index],
                appointment1: index == 0 ? null : appointments[index - 1],
              );
            }
          }),
    );
  }
}
