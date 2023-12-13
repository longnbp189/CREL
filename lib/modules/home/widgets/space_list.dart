// import 'package:crel_mobile/common/widgets/stateful/custom_carousel_image_property.dart';
// import 'package:crel_mobile/common/widgets/stateless/container_boder.dart';
// import 'package:crel_mobile/config/configs.dart';
// import 'package:crel_mobile/models/models.dart';
// import 'package:flutter/material.dart';

// class SpaceList extends StatelessWidget {
//   final List<Space> space;
//   const SpaceList({Key? key, required this.space}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 36,
//       child: ListView.builder(
//           shrinkWrap: true,
//           scrollDirection: Axis.horizontal,
//           itemCount: space.length,
//           itemBuilder: (context, index) {
//             return InkWell(
//               onTap: () {
//                 showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return NewWidget(
//                         area: space[index].area ?? 0,
//                         floor: space[index].floor ?? "0",
//                         medias: space[index].media,
//                       );
//                     });
//               },
//               child: ContainerBoder(
//                 boder: 10,
//                 width: 1,
//                 colorWidth: AppColor.primaryColor,
//                 child: Text(
//                   space[index].name.toString(),
//                   style: TxtStyle.heading3,
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }

// class NewWidget extends StatelessWidget {
//   final String floor;
//   final double area;
//   final List<Media>? medias;
//   const NewWidget(
//       {Key? key, required this.floor, required this.area, required this.medias})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: Stack(children: [
//         // CachedNetworkImage(
//         //   height: 200,
//         //   fit: BoxFit.cover,
//         //   imageUrl:
//         //       "https://www.savills.com.vn/_images/thaibuilding-20190911.jpg",
//         //   placeholder: (context, url) => const CircularProgressIndicator(),
//         //   errorWidget: (context, url, error) => const Icon(Icons.error),
//         // ),
//         // const CustomCarouselCopy(),
//         // Container(
//         //   height: 200,
//         //   decoration: BoxDecoration(
//         //       gradient: LinearGradient(
//         //           begin: Alignment.topCenter,
//         //           end: Alignment.bottomCenter,
//         //           colors: [Colors.transparent, AppColor.boderColor])),
//         // ),
//         CustomCarouselImageProperty(
//           media: medias,
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8),
//           child: Row(
//             children: [
//               const Icon(Icons.build),
//               const SizedBox(width: 5),
//               Expanded(
//                   child: Text(
//                 floor,
//                 style: TxtStyle.heading4.copyWith(fontWeight: FontWeight.bold),
//               )),
//               const Icon(Icons.build),
//               const SizedBox(width: 5),
//               Text(
//                 area.toString() + " m\u00B2",
//                 style: TxtStyle.heading4.copyWith(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         )
//       ]),
//     );
//   }
// }
