// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class ButtonOrange extends StatelessWidget {
//   final String? title;
//   final Icon? icon;
//   const ButtonOrange({Key? key, required this.title, this.icon})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Container(
//       // / height: size.height * 0.05,

//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           gradient: const LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               colors: [
//                 txt.orangeLight,
//                 AppColor.orangeStrong,
//               ])),
//       child: Row(children: [
//         const Expanded(
//           flex: 3,
//           child: Center(
//               child: FaIcon(
//             FontAwesomeIcons.googlePlusG,
//             color: Colors.white,
//             size: 24,
//           )),
//         ),
//         Expanded(
//           flex: 8,
//           child: Text(
//             title.toString(),
//             style: AppStyles.h3,
//           ),
//         ),
//       ]),
//     );
//   }
// }
