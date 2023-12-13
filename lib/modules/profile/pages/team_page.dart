// import 'package:crel_mobile/config/configs.dart';
// import 'package:crel_mobile/modules/profile/blocs/team/team_bloc.dart';
// import 'package:crel_mobile/modules/profile/widgets/staff_team.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class TeamPage extends StatefulWidget {
//   const TeamPage({Key? key}) : super(key: key);

//   @override
//   State<TeamPage> createState() => _TeamPageState();
// }

// class _TeamPageState extends State<TeamPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text(
//         "Đội nhóm",
//         style: TxtStyle.heading3.copyWith(color: Colors.white),
//       )),
//       body: SafeArea(
//           child: BlocListener<TeamBloc, TeamState>(
//         listener: (context, state) {
//           if (state is TeamError) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(state.error)));
//           }
//         },
//         child: BlocBuilder<TeamBloc, TeamState>(
//           builder: (context, state) {
//             if (state is TeamLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             if (state is TeamLoaded) {
//               return StaffTeam(team: state.team);
//             } else {
//               return Container(
//                 color: Colors.amber,
//                 // child: Text(state.e),
//               );
//             }
//           },
//         ),
//       )),
//     );
//   }

//   // void _getTeam(context) {
//   //   BlocProvider.of<TeamBloc>(context).add(GetTeamRequested());
//   // }
// }
