// import 'package:crel_mobile/config/text_style.dart';
// import 'package:crel_mobile/models/models.dart';
// import 'package:crel_mobile/modules/profile/widgets/team_info.dart';
// import 'package:flutter/material.dart';

// class StaffTeam extends StatelessWidget {
//   // final List<StaffTeam> staffTeams;
//   final List<Team> team;
//   const StaffTeam({
//     Key? key,
//     required this.team,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         shrinkWrap: true,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         itemCount: team.length,
//         itemBuilder: (context, index) {
//           // return Text(team[index].staffTeams![3].staff!.name.toString());
//           return Column(
//             children: [
//               const Text(
//                 "Quản lý",
//                 style: TxtStyle.heading3,
//               ),
//               TeamInfo(
//                   staffTeam: team[index]
//                       .areaManagerTeams!
//                       .where((element) => element.isManager!)
//                       .toList()),
//               const Text(
//                 "Thành viên",
//                 style: TxtStyle.heading3,
//               ),
//               TeamInfo(
//                   staffTeam: team[index]
//                       .areaManagerTeams!
//                       .where((element) => element.isManager! == false)
//                       .toList()),
//             ],
//           );
//         });
//   }
// }
