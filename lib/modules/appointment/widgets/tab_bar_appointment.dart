import 'package:badges/badges.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/appointment/blocs/appointment_confirm/appointment_confirm_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBarAppointment extends StatefulWidget {
  const TabBarAppointment({
    Key? key,
    required this.size,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final Size size;
  final TabController _tabController;

  @override
  State<TabBarAppointment> createState() => _TabBarAppointmentState();
}

class _TabBarAppointmentState extends State<TabBarAppointment> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      child: TabBar(
        tabs: [
          const Tab(
            child: Text(
              "Danh sách",
              style: TxtStyle.textTabBar,
            ),
          ),
          BlocBuilder<AppointmentConfirmBloc, AppointmentConfirmState>(
            buildWhen: (previous, current) =>
                previous != current && current is AppointmentComfirmLoaded,
            builder: (context, state) {
              // BlocProvider.of<AppointmentBloc>(context)
              //     .add(const GetAppointmentRequested(1, "", true));

              if (state is AppointmentComfirmLoaded) {
                if (state.number != 0) {
                  return Badge(
                    toAnimate: false,
                    position: BadgePosition.topEnd(top: 1, end: -34),
                    badgeContent: Text(state.number.toString()),
                    child: const Tab(
                      child: Text(
                        "Xác nhận lịch hẹn",
                        style: TxtStyle.textTabBar,
                      ),
                    ),
                  );
                }
              }
              return const Text(
                "Xác nhận lịch hẹn",
                style: TxtStyle.textTabBar,
              );
            },
          ),
        ],
        controller: widget._tabController,
        labelStyle: TxtStyle.textTabBar,
        unselectedLabelStyle: TxtStyle.textTabBar,
        indicatorColor: AppColor.primaryColor,
        indicatorWeight: 3,
      ),
    );
  }
}
