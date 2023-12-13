import 'package:crel_mobile/modules/appointment/blocs/appointment/appointment_bloc.dart';
import 'package:crel_mobile/modules/appointment/blocs/appointment_confirm/appointment_confirm_bloc.dart';
import 'package:crel_mobile/modules/appointment/widgets/appointment_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarViewTwoAppointment extends StatefulWidget {
  const TabBarViewTwoAppointment({Key? key}) : super(key: key);

  @override
  State<TabBarViewTwoAppointment> createState() =>
      _TabBarViewTwoAppointmentState();
}

class _TabBarViewTwoAppointmentState extends State<TabBarViewTwoAppointment> {
  final ScrollController _scrollController = ScrollController();

  DateTime date = DateTime(DateTime.now().year, DateTime.now().month);

  @override
  void initState() {
    context.read<AppointmentBloc>().add(const GetListConfirmAppointment(true));
    context.read<AppointmentConfirmBloc>().add(GetAppointmentConfirm());
    //   ..add(GetAppointmentConfirm());
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppointmentList(
      onRefresh: _onRefresh,
      scrollController: _scrollController,

      // state: state,
    );
  }

  Future<void> _onRefresh() async {
    context.read<AppointmentBloc>().add(const GetListConfirmAppointment(true));
    // _appointmentBloc.add(const RefreshAppointmentRequested(1, ""));
    context.read<AppointmentConfirmBloc>().add(GetAppointmentConfirm());
  }

  void _onScroll() {
    FocusManager.instance.primaryFocus?.unfocus();
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      // ignore: avoid_single_cascade_in_expression_statements
      context.read<AppointmentBloc>()
        ..add(const GetListConfirmAppointment(false));
    }
  }
}
