import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/appointment/blocs/appointment/appointment_bloc.dart';
import 'package:crel_mobile/modules/appointment/blocs/appointment_confirm/appointment_confirm_bloc.dart';
import 'package:crel_mobile/modules/appointment/repos/appointment_repo.dart';
import 'package:crel_mobile/modules/appointment/widgets/calender.dart';
import 'package:crel_mobile/modules/appointment/widgets/tab_bar_appointment.dart';
import 'package:crel_mobile/modules/appointment/widgets/tab_bar_view_appointment.dart';
import 'package:crel_mobile/modules/home/blocs/brand/brand_bloc.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isCalendar = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<AppointmentConfirmBloc>().add(GetAppointmentConfirm());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      // child: BlocProvider<AppointmentBloc>(
      //   create: (context) => AppointmentBloc(
      //       appointmentRepo: RepositoryProvider.of<AppointmentRepo>(context)),
      child: Scaffold(
          appBar: AppBar(
              actions: [
                IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      setState(() {
                        isCalendar = !isCalendar;
                      });
                    },
                    icon: !isCalendar
                        ? SvgPicture.asset(
                            'assets/icons/calendar.svg',
                            color: Colors.white,
                          )
                        : const Icon(Icons.list))
              ],
              backgroundColor: AppColor.primaryColor,
              title: const Text(
                "Quản lý lịch hẹn",
                style: TxtStyle.textAppBar,
              )),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColor.primaryColor,
            onPressed: () {
              context.read<BrandBloc>().add(const GetBrandRequested(true));
              context
                  .read<PropertyForRentBloc>()
                  .add(const GetPropertyForRentRequested(2, "", true));
              Navigator.pushNamed(context, AppRouter.createAppointment);
            },
            child: const FaIcon(
              FontAwesomeIcons.plus,
            ),
            // label: const Text('Approve'),
          ),
          body: !isCalendar
              ? Container(
                  color: AppColor.backgroundColor,
                  child: Column(
                    children: [
                      BlocProvider<AppointmentBloc>(
                        create: (context) => AppointmentBloc(
                            appointmentRepo:
                                RepositoryProvider.of<AppointmentRepo>(context))
                          ..add(const GetListConfirmAppointment(true)),
                        child: TabBarAppointment(
                            size: size, tabController: _tabController),
                      ),
                      TabBarViewAppointment(
                          tabController: _tabController, size: size)
                    ],
                  ),
                )
              : BlocProvider<AppointmentBloc>(
                  create: (context) => AppointmentBloc(
                      appointmentRepo:
                          RepositoryProvider.of<AppointmentRepo>(context))
                    ..add(GetListAppointmentCalendar(
                        DateTime.now().add(const Duration(days: -40)),
                        DateTime.now().add(const Duration(days: 40)))),
                  child: const Calender(),
                )),
      // ),
    );
  }
}
