// import 'package:crel_mobile/modules/appointment/blocs/appointment_bloc.dart';
// import 'package:crel_mobile/modules/appointment/blocs/appointment_confirm_bloc.dart';
// import 'package:crel_mobile/modules/appointment/repos/appointment_repo.dart';
// import 'package:crel_mobile/modules/appointment/widgets/appointment_detail.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> with TickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: MultiBlocProvider(
//           providers: [
//             BlocProvider<AppointmentBloc>(
//               create: (BuildContext context) => AppointmentBloc(
//                   appointmentRepo:
//                       RepositoryProvider.of<AppointmentRepo>(context))
//                 ..add(const GetAppointmentRequested(true)),
//             ),
//             BlocProvider<AppointmentConfirmBloc>(
//               create: (BuildContext context) => AppointmentConfirmBloc(
//                 appointmentRepo:
//                     RepositoryProvider.of<AppointmentRepo>(context),
//               )..add(GetAppointmentConfirm()),
//             ),
//           ],
//           child: Scaffold(
//             appBar: AppBar(
//               title: const Text('TabBar Widget'),
//               bottom: TabBar(
//                 // onTap: (value) {
//                 //   switch (value) {
//                 //     case 0:
//                 //       context
//                 //           .read<AppointmentBloc>()
//                 //           .add(const GetAppointmentRequested(true));
//                 //       break;
//                 //     case 1:
//                 //       context
//                 //           .read<AppointmentBloc>()
//                 //           .add(const GetListConfirmAppointment(true));
//                 //       break;
//                 //   }
//                 // },
//                 controller: _tabController,
//                 tabs: <Widget>[
//                   const Tab(
//                     icon: Icon(Icons.cloud_outlined),
//                   ),
//                   BlocBuilder<AppointmentConfirmBloc, AppointmentConfirmState>(
//                     builder: (context, state) {
//                       if (state is AppointmentComfirmLoaded) {
//                         return Row(
//                           children: [
//                             const Tab(
//                               icon: Icon(Icons.beach_access_sharp),
//                             ),
//                             Text(state.number.toString())
//                           ],
//                         );
//                       }
//                       return Text("$state");
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             body: TabBarView(
//               controller: _tabController,
//               children: <Widget>[
//                 BlocBuilder<AppointmentBloc, AppointmentState>(
//                   builder: (context, state) {
//                     if (state is AppointmentLoaded) {
//                       return ListView.builder(
//                         itemCount: state.appointments.length,
//                         itemBuilder: (context, index) {
//                           return Text(state.appointments[index].id.toString());
//                         },
//                       );
//                     }
//                     return Text("$state");
//                   },
//                 ),
//                 BlocBuilder<AppointmentBloc, AppointmentState>(
//                   builder: (context, state) {
//                     if (state is AppointmentLoaded) {
//                       return ListView.builder(
//                         itemCount: state.appointments.length,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                               onTap: () {
//                                 showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return AppointmentDetail(
//                                         appointment: state.appointments[index],
//                                       );
//                                     });
//                               },
//                               child: Text(
//                                   state.appointments[index].id.toString()));
//                         },
//                       );
//                     }
//                     return Text("$state");
//                   },
//                 ),
//                 // BlocProvider<AppointmentBloc>(
//                 //   create: (context) => AppointmentBloc(
//                 //       appointmentRepo:
//                 //           RepositoryProvider.of<AppointmentRepo>(context))
//                 //     ..add(const GetAppointmentRequested(true)),
//                 //   child: const TabBarViewOneAppointment(),
//                 // ),
//                 // BlocProvider<AppointmentBloc>(
//                 //   create: (context) => AppointmentBloc(
//                 //       appointmentRepo:
//                 //           RepositoryProvider.of<AppointmentRepo>(context))
//                 //     ..add(const GetListConfirmAppointment(true)),
//                 //   child:
//                 // const TabBarViewTwoAppointment(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
