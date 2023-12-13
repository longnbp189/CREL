// import 'dart:io';

// import 'package:crel_mobile/config/configs.dart';
// import 'package:crel_mobile/models/models.dart';
// import 'package:crel_mobile/modules/home/blocs/brand/brand_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// class CreateContract extends StatefulWidget {
//   final Property propertyForRent;
//   const CreateContract({Key? key, required this.propertyForRent})
//       : super(key: key);

//   @override
//   State<CreateContract> createState() => _CreateContractState();
// }

// class _CreateContractState extends State<CreateContract> {
//   final _searchController = TextEditingController();
//   List<Brand> listBrand = [];
//   String nameBrand = "Chọn thương hiệu";
//   String expiredDate = "Chọn hạn thuê";
//   File? _pickedImage;
//   bool isHasBrand = true;
//   bool dateLoaded = true;
//   bool isHasDateLoaded = true;

//   String nameeeeeeeeee = "";

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         createContractDialog(context);
//       },
//       child: Container(
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
//             color: AppColor.primaryColor,
//           ),
//           height: 52,
//           alignment: Alignment.center,
//           child: Text(
//               (widget.propertyForRent.status == 3 ||
//                       widget.propertyForRent.status == 4)
//                   ? "Đã có hợp đồng"
//                   : "Tạo hợp đồng",
//               style: TxtStyle.heading3.copyWith(color: Colors.white))),
//     );
//   }

//   Future<dynamic> createContractDialog(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState2) => Dialog(
//             insetPadding: const EdgeInsets.all(16),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Container(
//                 // width: AppFormat.width(context),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 // height: 100,
//                 child: (!dateLoaded)
//                     ? const Center(
//                         child: CircularProgressIndicator(),
//                       )
//                     : Wrap(
//                         children: [
//                           Column(
//                             children: [
//                               Text(
//                                 "Tạo hợp đồng",
//                                 style: TxtStyle.heading3
//                                     .copyWith(color: AppColor.primaryColor),
//                               ),
//                               const SizedBox(
//                                 height: 8,
//                               ),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         "Mặt bằng: ",
//                                         style: TxtStyle.heading4,
//                                       )),
//                                   Expanded(
//                                       flex: 5,
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             border: Border.all(
//                                                 color: Colors.black)),
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 16, vertical: 8),
//                                           child: Text(
//                                             widget.propertyForRent.name!,
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: TxtStyle.heading4,
//                                           ),
//                                         ),
//                                       ))
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 8,
//                               ),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Expanded(
//                                       flex: 2,
//                                       child: Text(
//                                         "Địa điểm: ",
//                                         style: TxtStyle.heading4,
//                                       )),
//                                   Expanded(
//                                       flex: 5,
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             border: Border.all(
//                                                 color: Colors.black)),
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 16, vertical: 8),
//                                           child: Text(
//                                               widget.propertyForRent.location!
//                                                   .address!,
//                                               maxLines: 2,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: TxtStyle.heading4),
//                                         ),
//                                       ))
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 8,
//                               ),
//                               choseBrand(setState2),
//                               (!isHasBrand)
//                                   ? Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 4),
//                                       child: Row(
//                                         children: const [
//                                           Expanded(flex: 2, child: SizedBox()),
//                                           Expanded(
//                                             flex: 5,
//                                             child: Padding(
//                                               padding:
//                                                   EdgeInsets.only(left: 16),
//                                               child: Text(
//                                                 "Vui Lòng chọn thương hiệu",
//                                                 style: TextStyle(
//                                                     color: Colors.red,
//                                                     fontSize: 14),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   : const SizedBox(
//                                       height: 8,
//                                     ),
//                               choseDate(setState2),
//                               (!isHasDateLoaded)
//                                   ? Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 4),
//                                       child: Row(
//                                         children: [
//                                           const Expanded(
//                                               flex: 2, child: SizedBox()),
//                                           Expanded(
//                                             flex: 5,
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 16),
//                                               child: Text(
//                                                 expiredDate == ""
//                                                     ? "Không đọc được hình ảnh"
//                                                     : "Vui Lòng chọn ngày",
//                                                 style: const TextStyle(
//                                                     color: Colors.red,
//                                                     fontSize: 14),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   : const SizedBox(
//                                       height: 8,
//                                     ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   const Expanded(flex: 7, child: SizedBox()),
//                                   GestureDetector(
//                                     onTap: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: SizedBox(
//                                       height: 32,
//                                       width: 60,
//                                       child: Center(
//                                         child: Text("Hủy",
//                                             style: TxtStyle.heading3.copyWith(
//                                               color: AppColor.primaryColor,
//                                             )),
//                                       ),
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       setState2(() {
//                                         if (nameBrand == "Chọn thương hiệu" ||
//                                             nameBrand.isEmpty) {
//                                           isHasBrand = false;
//                                         } else {
//                                           isHasBrand = true;
//                                         }
//                                         if (expiredDate == "Chọn hạn thuê" ||
//                                             expiredDate.isEmpty) {
//                                           isHasDateLoaded = false;
//                                         } else {
//                                           isHasDateLoaded = true;
//                                         }
//                                       });

//                                       if (isHasDateLoaded == true &&
//                                           isHasBrand == true) {
//                                         confirmContract(context);
//                                       }
//                                     },
//                                     child: SizedBox(
//                                       height: 32,
//                                       width: 60,
//                                       child: Center(
//                                         child: Text("Tạo",
//                                             style: TxtStyle.heading3.copyWith(
//                                               color: AppColor.primaryColor,
//                                             )),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Row choseDate(StateSetter setState2) {
//     return Row(
//       children: [
//         const Expanded(
//             flex: 2,
//             child: Text(
//               "Hạn thuê: ",
//               style: TxtStyle.heading4,
//             )),
//         Expanded(
//             flex: 5,
//             child: InkWell(
//               onTap: () {
//                 // setState(() async {
//                 //   outputText = await pickImage(
//                 //     ImageSource.gallery,
//                 //     pickedImage,
//                 //   );
//                 // });
//                 // setState(() {
//                 // pickImage(ImageSource.gallery, pickedImage, setState2);
//                 // });
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.black)),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: Text(expiredDate,
//                       overflow: TextOverflow.ellipsis,
//                       style: TxtStyle.heading4),
//                 ),
//               ),
//             ))
//       ],
//     );
//   }

//   Row choseBrand(StateSetter setState2) {
//     return Row(
//       children: [
//         const Expanded(
//             flex: 2,
//             child: Text(
//               "Thương hiệu: ",
//               style: TxtStyle.heading4,
//             )),
//         Expanded(
//             flex: 5,
//             child: BlocConsumer<BrandBloc, BrandState>(
//               listener: (context, state) {
//                 if (state is BrandError) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("BrandError")));
//                 }
//               },
//               builder: (context, state) {
//                 if (state is BrandLoading) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 if (state is BrandLoaded) {
//                   return InkWell(
//                     onTap: () {
//                       listBrand = state.brands;
//                       showModalBottomSheet(
//                         isScrollControlled: true,
//                         context: context,
//                         builder: (context) {
//                           return StatefulBuilder(
//                             builder: (context, setState1) =>
//                                 DraggableScrollableSheet(
//                               expand: false,
//                               builder: (context, scrollController) => Column(
//                                 children: [
//                                   Container(
//                                     color: AppColor.boderColor,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         IconButton(
//                                             onPressed: () {
//                                               _searchController.clear();
//                                               Navigator.of(context).pop();
//                                             },
//                                             icon: const Icon(Icons.close)),
//                                         Text(
//                                           "Nhập tên Thương hiệu",
//                                           style: TxtStyle.heading4.copyWith(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         const IconButton(
//                                             onPressed: null,
//                                             icon: Icon(
//                                               Icons.close,
//                                               color: Colors.transparent,
//                                             )),
//                                       ],
//                                     ),
//                                   ),
//                                   // const SearchBarBrand(
//                                   //     title: "Nhập từ khóa để lọc"),

//                                   Container(
//                                     height: 40,
//                                     alignment: Alignment.centerLeft,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         border: Border.all(
//                                             width: 1,
//                                             color: AppColor.boderColor)),
//                                     child: TextField(
//                                       onChanged: (value) {
//                                         setState1(() {
//                                           listBrand = state.brands
//                                               .where((brandtName) => brandtName
//                                                   .name!
//                                                   .toLowerCase()
//                                                   .contains(
//                                                       value.toLowerCase()))
//                                               .toList();
//                                         });
//                                       },
//                                       controller: _searchController,
//                                       cursorColor: AppColor.secondColor,
//                                       style: const TextStyle(
//                                           color: AppColor.secondColor),
//                                       decoration: const InputDecoration(
//                                         isDense: true,
//                                         border: InputBorder.none,
//                                         prefixIcon: Icon(
//                                           Icons.search,
//                                           color: AppColor.textColor,
//                                           size: 24,
//                                         ),
//                                       ),
//                                     ),
//                                   ),

//                                   Expanded(
//                                     child: ListView.builder(
//                                         // physics: const NeverScrollableScrollPhysics(),
//                                         shrinkWrap: true,
//                                         itemCount: listBrand.length,
//                                         controller: scrollController,
//                                         itemBuilder: (context, index) {
//                                           return InkWell(
//                                             onTap: () {
//                                               setState2(() {
//                                                 isHasBrand = true;

//                                                 nameBrand =
//                                                     listBrand[index].name!;
//                                                 _searchController.clear();
//                                               });
//                                               Navigator.pop(context, nameBrand);
//                                             },
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                   border: Border(
//                                                 top: BorderSide(
//                                                   color: AppColor.boderColor,
//                                                   width: 1,
//                                                 ),
//                                                 bottom: BorderSide(
//                                                   color: AppColor.boderColor,
//                                                   width: 1,
//                                                 ),
//                                               )),
//                                               child: Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(
//                                                     horizontal: 16,
//                                                     vertical: 8,
//                                                   ),
//                                                   child: Text(
//                                                     listBrand[index]
//                                                         .name
//                                                         .toString(),
//                                                     style: TxtStyle.heading4,
//                                                   )),
//                                             ),
//                                           );
//                                         }),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.black)),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 8),
//                         child: Text(nameBrand,
//                             overflow: TextOverflow.ellipsis,
//                             style: TxtStyle.heading4),
//                       ),
//                     ),
//                   );
//                 } else {
//                   return Text("$state");
//                 }
//               },
//             ))
//       ],
//     );
//   }

//   Future<dynamic> confirmContract(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         insetPadding: const EdgeInsets.all(16),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Wrap(
//               children: [
//                 Column(
//                   children: [
//                     Text(
//                       "Xác nhận hợp đồng",
//                       style: TxtStyle.heading3
//                           .copyWith(color: AppColor.primaryColor),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                             flex: 2,
//                             child: Text(
//                               "Mặt bằng: ",
//                               style: TxtStyle.heading4,
//                             )),
//                         Expanded(
//                             flex: 5,
//                             child: Text(
//                               widget.propertyForRent.name!,
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               style: TxtStyle.heading4,
//                             ))
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                             flex: 2,
//                             child: Text(
//                               "Địa điểm: ",
//                               style: TxtStyle.heading4,
//                             )),
//                         Expanded(
//                             flex: 5,
//                             child: Text(
//                                 widget.propertyForRent.location!.address!,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TxtStyle.heading4))
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                             flex: 2,
//                             child: Text(
//                               "Thương hiệu: ",
//                               style: TxtStyle.heading4,
//                             )),
//                         Expanded(
//                             flex: 5,
//                             child: Text(nameBrand,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TxtStyle.heading4))
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Expanded(
//                             flex: 2,
//                             child: Text(
//                               "Hạn thuê: ",
//                               style: TxtStyle.heading4,
//                             )),
//                         Expanded(
//                             flex: 5,
//                             child: Text(expiredDate,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TxtStyle.heading4))
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         const Expanded(flex: 7, child: SizedBox()),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: SizedBox(
//                             height: 32,
//                             width: 60,
//                             child: Center(
//                               child: Text("Hủy",
//                                   style: TxtStyle.heading3.copyWith(
//                                     color: AppColor.primaryColor,
//                                   )),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(
//                                 context, AppRouter.propertyDetail,
//                                 arguments: widget.propertyForRent);
//                           },
//                           child: SizedBox(
//                             height: 32,
//                             width: 80,
//                             child: Center(
//                               child: Text("Xác nhận",
//                                   style: TxtStyle.heading3.copyWith(
//                                     color: AppColor.primaryColor,
//                                   )),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<dynamic> pickImage(
//       source, Function(File) imgFile, StateSetter setState2) async {
//     ImagePicker imgPicker = ImagePicker();
//     setState2(() {
//       dateLoaded = false;
//     });
//     XFile? file = await imgPicker.pickImage(source: source);
//     if (file == null) return;
//     var t = await imgFile(File(file.path));

//     setState2(() {
//       isHasDateLoaded = true;
//       if (t == "") {
//         isHasDateLoaded = false;
//       }
//       expiredDate = t;
//       dateLoaded = true;
//     });
//   }

//   // Future<String> pickedImage(File file) async {
//   //   setState(() {
//   //     _pickedImage = file;
//   //   });
//   //   InputImage inputImage = InputImage.fromFile(file);
//   //   //code to recognize image
//   //   return await processImageForConversion(inputImage);
//   // }

//   // Future<String> processImageForConversion(inputImage) async {
//   //   // setState(() {
//   //   //   outputText = "";
//   //   // });
//   //   final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//   //   final RecognizedText recognizedText =
//   //       await textRecognizer.processImage(inputImage);
//   //   String text = "";
//   //   for (TextBlock block in recognizedText.blocks) {
//   //     if (AppFormat.nonUnicode(block.text).contains("cap ngay:")) {
//   //       text = AppFormat.nonUnicode(block.text).trim().split(" ").last;
//   //       // setState(() {
//   //       //   // outputText += text + "\n";
//   //       //   outputText = text;
//   //       // });
//   //     }
//   //   }
//   //   text = AppFormat.tryParseDate(text);
//   //   print("done");
//   //   return text;
//   //   // Navigator.pop(context,)
//   // }
// }
