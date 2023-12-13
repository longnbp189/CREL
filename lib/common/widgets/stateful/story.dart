// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:crel_mobile/config/configs.dart';
// import 'package:flutter/material.dart';

// class Story extends StatefulWidget {
//   final String? name;
//   final String? imageStory;
//   const Story({Key? key, this.name, this.imageStory}) : super(key: key);

//   @override
//   State<Story> createState() => _StoryState();
// }

// class _StoryState extends State<Story> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.only(right: 15),
//       child: Container(
//         width: size.width / 2.5,
//         height: size.height / 4.5,
//         decoration: const BoxDecoration(shape: BoxShape.rectangle),
//         child: Stack(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: CachedNetworkImage(
//                 fit: BoxFit.cover,
//                 imageUrl: widget.imageStory!,
//                 placeholder: (context, url) =>
//                     const CircularProgressIndicator(),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//               ),
//             ),
//             // const PageShadow(),
//             Positioned(
//                 left: size.width / 2.5 * 0.05,
//                 top: size.width / 3.2,
//                 child: Row(
//                   children: [
//                     const ItemOnline(
//                       avatarUrl:
//                           'https:/ae01.alicdn.com/kf/HTB1USU9KVXXXXXFaXXXq6xXFXXXc/Bleach-10th-Division-Captain-Toshiro-Hitsugaya-Cosplay-Trang-Ph-c-Mi-n-Ph-V-n-Chuy.jpg_Q90.jpg_.webp',
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       widget.name!.toString(),
//                       style: TxtStyle.heading5Blue
//                           .copyWith(fontWeight: FontWeight.bold),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     )
//                   ],
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
