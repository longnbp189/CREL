import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/appointment/blocs/appointment/appointment_bloc.dart';
import 'package:crel_mobile/modules/appointment/blocs/appointment_confirm/appointment_confirm_bloc.dart';
import 'package:crel_mobile/modules/appointment/widgets/appointment_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';

class TabBarViewOneAppointment extends StatefulWidget {
  const TabBarViewOneAppointment({Key? key}) : super(key: key);

  @override
  State<TabBarViewOneAppointment> createState() =>
      _TabBarViewOneAppointmentState();
}

class _TabBarViewOneAppointmentState extends State<TabBarViewOneAppointment> {
  final ScrollController _scrollController = ScrollController();
  late AppointmentBloc _appointmentBloc;
  final TextEditingController _searchController = TextEditingController()
    ..text = "";

  @override
  void initState() {
    _appointmentBloc = context.read<AppointmentBloc>()
      ..add(SearchAppointmentByMonth(AppFormat.startDayOfMonth(date),
          AppFormat.endDayOfMonth(date), true));
    _scrollController.addListener(_onScroll);
    _searchController.text = "";
    context.read<AppointmentConfirmBloc>().add(GetAppointmentConfirm());

    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  DateTime? returnMonth;
  callbackDate(returnData) {
    setState(() {
      returnMonth = returnData;
    });
  }

  DateTime date = DateTime(DateTime.now().year, DateTime.now().month);

  Future pickDate(BuildContext context) async {
    final chooseDate = await showMonthPicker(
        context: context,
        // builder: (context, child) => Theme(
        //       data: ThemeData.light().copyWith(
        //           colorScheme: const ColorScheme.light(
        //         primary: AppColor.primaryColor,
        //       )),
        //       child: child!,
        //     ),
        selectedMonthBackgroundColor: AppColor.primaryColor,
        unselectedMonthTextColor: AppColor.primaryColor,
        initialDate: DateTime.now(),
        // firstDate: DateTime.no(),
        lastDate: DateTime(2100));

    if (chooseDate == null) return;
    setState(() {
      date = chooseDate;

      context.read<AppointmentBloc>().add(SearchAppointmentByMonth(
          AppFormat.startDayOfMonth(date),
          AppFormat.endDayOfMonth(date),
          true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 16, bottom: 8),
          child: GestureDetector(
            onTap: () {
              pickDate(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.boderColor)),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    AppFormat.parseMonth(date.toString()),
                    style: TxtStyle.heading4,
                  )),
            ),
          ),
        ),
        Expanded(
          child: AppointmentList(
            onRefresh: _onRefresh,
            scrollController: _scrollController,
            // state: state,
          ),
        ),
      ],
    );
  }

  Future<void> _onRefresh() async {
    _appointmentBloc.add(RefreshAppointmentRequested(
        AppFormat.startDayOfMonth(date), AppFormat.endDayOfMonth(date), 2));
  }

  void _onScroll() {
    FocusManager.instance.primaryFocus?.unfocus();
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      // ignore: avoid_single_cascade_in_expression_statements
      _appointmentBloc
        ..add(SearchAppointmentByMonth(AppFormat.startDayOfMonth(date),
            AppFormat.endDayOfMonth(date), false));
    }
  }
}
