// import 'package:crel_mobile/common/widgets/stateless/avatar.dart';
// import 'package:crel_mobile/utils/app_colors.dart';
// import 'package:flutter/material.dart';

// class ItemOnline extends StatelessWidget {
//   final String? avatarUrl;

//   const ItemOnline({Key? key, this.avatarUrl}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Stack(
//       children: [
//         Container(
//             width: size.width * 0.085,
//             height: size.height * 0.085,
//             decoration: const ShapeDecoration(
//                 shape: CircleBorder(
//                     side: BorderSide(width: 2, color: AppColor.boderAvatar)))),
//         Positioned(
//           left: size.width / 120,
//           top: size.width / 16.5,
//           child: Avatar(
//             avatarUrl: avatarUrl,
//             sizeAvatar: 24,
//           ),
//         )
//       ],
//     );
//   }
// }
