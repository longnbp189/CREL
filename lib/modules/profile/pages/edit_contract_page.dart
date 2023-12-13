// import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:crel_mobile/common/widgets/stateful/chose_brand.dart';
// import 'package:crel_mobile/common/widgets/stateful/chose_owner.dart';
// import 'package:crel_mobile/common/widgets/stateful/chose_property.dart';
// import 'package:crel_mobile/config/app_format.dart';
// import 'package:crel_mobile/config/configs.dart';
// import 'package:crel_mobile/models/contract.dart';
// import 'package:crel_mobile/models/models.dart';
// import 'package:crel_mobile/models/owner.dart';
// import 'package:crel_mobile/modules/appointment/blocs/contract/contract_bloc.dart';
// import 'package:crel_mobile/modules/appointment/pages/create_appointment_page.dart';
// import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_m.dart';
// import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_price.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class EditContractPage extends StatefulWidget {
//   final Contract contract;
//   const EditContractPage({Key? key, required this.contract}) : super(key: key);

//   @override
//   State<EditContractPage> createState() => _EditContractPageState();
// }

// class _EditContractPageState extends State<EditContractPage> {
//   File? image;
//   List<XFile> listImage = [];
//   List<Media> medias = [];
//   bool isHasImage = true;

//   bool isValidDate = true;

//   Brand? returnBrand;
//   callbackBrand(returnData) {
//     setState(() {
//       returnBrand = returnData;
//       isBrand = true;
//     });
//   }

//   Property? returnProperty;
//   callbackProperty(returnData) {
//     setState(() {
//       returnProperty = returnData;
//       _paymentTermController.text = returnProperty!.paymentTerm.toString();
//       _priceController.text =
//           AppFormat.changePriceVN(returnProperty!.price.toString());
//       // callbackOwner(returnProperty!.owners![0]);
//       returnOwner = returnProperty!.owners![0];
//       isProperty = true;
//       isOwner = true;
//     });
//   }

//   Owner? returnOwner;
//   // bool isOwner = true;

//   callbackOwner(returnData) {
//     setState(() {
//       returnOwner = returnData;
//       isOwner = true;
//     });
//   }

//   bool isOwner = true;
//   bool isBrand = true;
//   bool isProperty = true;

//   Future getImage() async {
//     final pickedFile = await ImagePicker().pickMultiImage();
//     setState(() {
//       if (pickedFile != null) {
//         for (var element in pickedFile) {
//           listImage.insert(0, element);
//         }
//         isHasImage = true;
//         print("sadasd");
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   List<Widget> listchoseImage() {
//     List<Widget> widgetImage = [];
//     for (var image in listImage) {
//       widgetImage.add(Stack(
//         alignment: AlignmentDirectional.topEnd,
//         children: [
//           SizedBox(
//               height: 120,
//               width: 120,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.file(File(image.path), fit: BoxFit.cover)),
//               )),
//           Positioned(
//             top: -10,
//             right: -8,
//             child: IconButton(
//                 onPressed: () {
//                   setState(() {
//                     listImage.remove(image);
//                   });
//                 },
//                 icon: const DeleteItemIcon()),
//           ),
//         ],
//       ));
//     }
//     for (var i in medias) {
//       widgetImage.add(Stack(
//         alignment: AlignmentDirectional.topEnd,
//         children: [
//           GestureDetector(
//             onTap: () {
//               FocusManager.instance.primaryFocus?.unfocus();
//               showGeneralDialog(
//                   context: context,
//                   barrierDismissible: true,
//                   barrierLabel: MaterialLocalizations.of(context)
//                       .modalBarrierDismissLabel,
//                   barrierColor: Colors.black45,
//                   transitionDuration: const Duration(milliseconds: 200),
//                   pageBuilder: (BuildContext buildContext, Animation animation,
//                       Animation secondaryAnimation) {
//                     return Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: AppFormat.heightWithoutStatusbar(context),
//                       padding: const EdgeInsets.all(20),
//                       color: Colors.white,
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           Image.network(
//                               "https://miro.medium.com/max/1400/1*h7iAbPrm1RXwdb4_Z9EF9w.png"),
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: const Text(
//                                 "Save",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               // color: const Color(0xFF1BC0C5),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   });
//             },
//             child: SizedBox(
//                 height: 120,
//                 width: 120,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: CachedNetworkImage(
//                         fit: BoxFit.cover,
//                         imageUrl: i.link!,
//                         // tag: ,
//                       )),
//                 )),
//           ),
//           Positioned(
//             top: -10,
//             right: -8,
//             child: IconButton(
//                 onPressed: () {
//                   setState(() {
//                     medias.remove(i);
//                   });
//                 },
//                 icon: const DeleteItemIcon()),
//           ),
//         ],
//       ));
//     }
//     return widgetImage;
//   }

//   final _paymentTermController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     medias.addAll(widget.contract.media!);
//     _paymentTermController.text = widget.contract.paymentTerm.toString();

//     _priceController.text =
//         AppFormat.changePriceVN(widget.contract.price.toString());
//     returnOwner = widget.contract.owner;
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _paymentTermController.dispose();
//     _priceController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     DateTime date = DateTime(widget.contract.endDate!.year,
//         widget.contract.endDate!.month, widget.contract.endDate!.day + 1);
//     DateTime startDate = DateTime(widget.contract.endDate!.year,
//         widget.contract.endDate!.month, widget.contract.endDate!.day + 1);
//     DateTime endDate = DateTime(widget.contract.endDate!.year + 1,
//         widget.contract.endDate!.month, widget.contract.endDate!.day + 1);
//     Future pickDate(BuildContext context, String dateType) async {
//       final chooseDate = await showDatePicker(
//           context: context,
//           builder: (context, child) => Theme(
//                 data: ThemeData.light().copyWith(
//                     colorScheme: const ColorScheme.light(
//                   primary: AppColor.primaryColor,
//                 )),
//                 child: child!,
//               ),
//           initialDate: (dateType == "end") ? endDate : date,
//           firstDate: (dateType == "end") ? endDate : date,
//           lastDate: DateTime(DateTime.now().year + 100));

//       if (chooseDate == null) return;
//       setState(() {
//         if (dateType == "start") {
//           startDate = chooseDate;
//           endDate =
//               DateTime(startDate.year + 1, startDate.month, startDate.day);
//         } else {
//           endDate = chooseDate;
//         }
//       });
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Chỉnh sửa hợp đồng",
//           style: TxtStyle.textAppBar,
//         ),
//         backgroundColor: AppColor.primaryColor,
//         centerTitle: true,
//       ),
//       body: BlocListener<ContractBloc, ContractState>(
//         listener: (context, state) {
//           // if (state is ContractUpdateSuccess) {
//           //   AppFormat.showSnackBar(context, 1, "Cập nhật thành công1111");
//           //   Navigator.pop(context);
//           // }
//         },
//         child: BlocBuilder<ContractBloc, ContractState>(
//           // buildWhen: (previous, current) =>
//           //     previous != current && current is ContractByIdLoaded,
//           builder: (context, state) {
//             if (state is ContractLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             // if (state is ContractByIdLoaded) {
//             // return Column(
//             //   children: [
//             //     // widget.contract.reasonRefuse != null
//             //     //     ? Text(
//             //     //         widget.contract.reasonRefuse.toString(),
//             //     //         style: TxtStyle.heading3.copyWith(
//             //     //             fontWeight: FontWeight.normal,
//             //     //             color: Colors.red),
//             //     //       )
//             //     //     : const SizedBox(),
//             //     Padding(
//             //       padding: const EdgeInsets.only(top: 8.0),
//             //       child: Row(
//             //         crossAxisAlignment: CrossAxisAlignment.start,
//             //         children: [
//             //           const Expanded(
//             //               flex: 2,
//             //               child: Text(
//             //                 "Thương hiệu: ",
//             //                 style: TxtStyle.heading4,
//             //               )),
//             //           Expanded(
//             //               flex: 5,
//             //               child: Text(
//             //                 widget.contract.brand!.name.toString(),
//             //                 maxLines: 2,
//             //                 overflow: TextOverflow.ellipsis,
//             //                 style: TxtStyle.heading4,
//             //               )),
//             //         ],
//             //       ),
//             //     ),
//             //     const SizedBox(
//             //       height: 8,
//             //     ),
//             //     Row(
//             //       crossAxisAlignment: CrossAxisAlignment.start,
//             //       children: [
//             //         const Expanded(
//             //             flex: 2,
//             //             child: Text(
//             //               "Mặt bằng: ",
//             //               style: TxtStyle.heading4,
//             //             )),
//             //         Expanded(
//             //             flex: 5,
//             //             child: Text(
//             //               widget.contract.property!.name.toString(),
//             //               maxLines: 2,
//             //               overflow: TextOverflow.ellipsis,
//             //               style: TxtStyle.heading4,
//             //             )),
//             //       ],
//             //     ),
//             //     const SizedBox(
//             //       height: 8,
//             //     ),
//             //     Row(
//             //       crossAxisAlignment: CrossAxisAlignment.start,
//             //       children: [
//             //         const Expanded(
//             //             flex: 2,
//             //             child: Text(
//             //               "Địa chỉ: ",
//             //               style: TxtStyle.heading4,
//             //             )),
//             //         Expanded(
//             //             flex: 5,
//             //             child: Text(
//             //               widget.contract.property!.location!.address
//             //                   .toString(),
//             //               maxLines: 2,
//             //               overflow: TextOverflow.ellipsis,
//             //               style: TxtStyle.heading4,
//             //             ))
//             //       ],
//             //     ),
//             //     const SizedBox(
//             //       height: 8,
//             //     ),
//             //     Row(
//             //       crossAxisAlignment: CrossAxisAlignment.center,
//             //       children: [
//             //         const Expanded(
//             //             flex: 2,
//             //             child: Text(
//             //               "Ngày bắt đầu: ",
//             //               style: TxtStyle.heading4,
//             //             )),
//             //         Expanded(
//             //             flex: 5,
//             //             child: GestureDetector(
//             //               onTap: () {
//             //                 pickDate(context, "start");
//             //                 isValidDate = true;
//             //               },
//             //               child: Container(
//             //                 decoration: BoxDecoration(
//             //                     borderRadius: BorderRadius.circular(10),
//             //                     border:
//             //                         Border.all(color: AppColor.secondColor)),
//             //                 child: Padding(
//             //                   padding: const EdgeInsets.symmetric(
//             //                       horizontal: 16, vertical: 8),
//             //                   child: Text(
//             //                     widget.contract.reasonCancel == null
//             //                         ? AppFormat.parseDate(
//             //                             startDate.toString())
//             //                         : AppFormat.parseDate(
//             //                             AppFormat.getDateNow().toString()),
//             //                   ),
//             //                 ),
//             //               ),
//             //             ))
//             //       ],
//             //     ),
//             //     const SizedBox(
//             //       height: 8,
//             //     ),
//             //     Row(
//             //       crossAxisAlignment: CrossAxisAlignment.center,
//             //       children: [
//             //         const Expanded(
//             //             flex: 2,
//             //             child: Text(
//             //               "Ngày kết thúc: ",
//             //               style: TxtStyle.heading4,
//             //             )),
//             //         Expanded(
//             //             flex: 5,
//             //             child: GestureDetector(
//             //               onTap: () {
//             //                 pickDate(context, "end");
//             //                 isValidDate = true;
//             //               },
//             //               child: Container(
//             //                 decoration: BoxDecoration(
//             //                     borderRadius: BorderRadius.circular(10),
//             //                     border:
//             //                         Border.all(color: AppColor.secondColor)),
//             //                 child: Padding(
//             //                   padding: const EdgeInsets.symmetric(
//             //                       horizontal: 16, vertical: 8),
//             //                   child: Text(
//             //                     widget.contract.reasonCancel == null
//             //                         ? AppFormat.parseDate(endDate.toString())
//             //                         : AppFormat.parseDate(
//             //                             AppFormat.getDateNow().toString()),
//             //                     style: TxtStyle.heading4,
//             //                   ),
//             //                 ),
//             //               ),
//             //             ))
//             //       ],
//             //     ),
//             //     // isValidDate
//             //     //     ? const SizedBox()
//             //     //     : Padding(
//             //     //         padding: const EdgeInsets.only(top: 8.0),
//             //     //         child: Align(
//             //     //           alignment: Alignment.centerLeft,
//             //     //           child: Text(
//             //     //             "Ngày bắt đầu không được bằng ngày kết thúc",
//             //     //             style: TxtStyle.heading4
//             //     //                 .copyWith(color: Colors.red),
//             //     //           ),
//             //     //         ),
//             //     //       ),
//             //     const SizedBox(
//             //       height: 8,
//             //     ),
//             //     Row(
//             //       crossAxisAlignment: CrossAxisAlignment.start,
//             //       children: [
//             //         const Expanded(
//             //             flex: 2,
//             //             child: Text(
//             //               "Tiền thuê: ",
//             //               style: TxtStyle.heading4,
//             //             )),
//             //         Expanded(
//             //             flex: 5,
//             //             child: Text(
//             //               AppFormat.changePriceVN(widget
//             //                       .contract.property!.price
//             //                       .toString()) +
//             //                   " Triệu/tháng",
//             //               style: TxtStyle.heading4,
//             //             ))
//             //       ],
//             //     ),
//             //     (medias.isEmpty && listImage.isEmpty)
//             //         ? InkWell(
//             //             onTap: () {
//             //               FocusManager.instance.primaryFocus?.unfocus();
//             //               getImage();
//             //             },
//             //             child: Padding(
//             //               padding: const EdgeInsets.symmetric(vertical: 16),
//             //               child: DottedBorder(
//             //                 radius: const Radius.circular(10),
//             //                 borderType: BorderType.RRect,
//             //                 color: AppColor.primaryColor,
//             //                 strokeWidth: 2,
//             //                 dashPattern: const [16, 8],
//             //                 child: Container(
//             //                     height:
//             //                         AppFormat.heightWithoutAppBarAndStatusbar(
//             //                                 context) *
//             //                             0.12,
//             //                     width: AppFormat.width(context),
//             //                     decoration: BoxDecoration(
//             //                       borderRadius: BorderRadius.circular(10),
//             //                       color: AppColor.cardColor,
//             //                     ),
//             //                     child: Padding(
//             //                       padding: const EdgeInsets.all(8.0),
//             //                       child: Column(
//             //                         mainAxisAlignment:
//             //                             MainAxisAlignment.center,
//             //                         children: [
//             //                           const Icon(
//             //                             Icons.camera_alt_rounded,
//             //                             size: 46,
//             //                           ),
//             //                           Text(
//             //                             "Chọn từ 01 đến 10 hình cho hợp đồng",
//             //                             style: TxtStyle.heading4.copyWith(
//             //                               fontWeight: FontWeight.bold,
//             //                             ),
//             //                           )
//             //                         ],
//             //                       ),
//             //                     )),
//             //               ),
//             //             ),
//             //           )
//             //         : Row(
//             //             children: [
//             //               InkWell(
//             //                 onTap: () => getImage(),
//             //                 child: Padding(
//             //                   padding:
//             //                       const EdgeInsets.symmetric(vertical: 16),
//             //                   child: DottedBorder(
//             //                     radius: const Radius.circular(10),
//             //                     borderType: BorderType.RRect,
//             //                     color: AppColor.primaryColor,
//             //                     strokeWidth: 2,
//             //                     dashPattern: const [16, 8],
//             //                     child: Container(
//             //                         height: AppFormat
//             //                                 .heightWithoutAppBarAndStatusbar(
//             //                                     context) *
//             //                             0.12,
//             //                         width: AppFormat
//             //                                 .heightWithoutAppBarAndStatusbar(
//             //                                     context) *
//             //                             0.13,
//             //                         decoration: BoxDecoration(
//             //                           borderRadius: BorderRadius.circular(10),
//             //                           color: AppColor.cardColor,
//             //                         ),
//             //                         child: Padding(
//             //                           padding: const EdgeInsets.all(8.0),
//             //                           child: Column(
//             //                             mainAxisAlignment:
//             //                                 MainAxisAlignment.center,
//             //                             crossAxisAlignment:
//             //                                 CrossAxisAlignment.center,
//             //                             children: [
//             //                               const Icon(
//             //                                 Icons.camera_alt_rounded,
//             //                                 size: 32,
//             //                               ),
//             //                               Text(
//             //                                 "Thêm hình",
//             //                                 style: TxtStyle.heading4.copyWith(
//             //                                   fontWeight: FontWeight.bold,
//             //                                 ),
//             //                               )
//             //                             ],
//             //                           ),
//             //                         )),
//             //                   ),
//             //                 ),
//             //               ),
//             //               Expanded(
//             //                 child: SingleChildScrollView(
//             //                   scrollDirection: Axis.horizontal,
//             //                   child: Row(children: listchoseImage()),
//             //                 ),
//             //               ),
//             //             ],
//             //           ),
//             //     !isHasImage
//             //         ? Padding(
//             //             padding: const EdgeInsets.only(bottom: 12),
//             //             child: Align(
//             //               alignment: Alignment.centerLeft,
//             //               child: Text(
//             //                 "Chọn từ 01 đến 10 hình.",
//             //                 style: TxtStyle.heading5Blue.copyWith(
//             //                     fontSize: 13,
//             //                     color: const Color.fromARGB(255, 228, 0, 0)),
//             //               ),
//             //             ),
//             //           )
//             //         : const SizedBox(),
//             //     const Expanded(child: SizedBox()),
//             //     Padding(
//             //       padding: const EdgeInsets.symmetric(vertical: 16),
//             //       child: SizedBox(
//             //         width: AppFormat.width(context),
//             //         child: ElevatedButton(
//             //           style: TxtStyle.buttonBlue,
//             //           onPressed: () async {
//             //             // var text = await controller.getText();
//             //             if (0 < (medias.length + listImage.length) &&
//             //                 (medias.length + listImage.length) < 11) {
//             //               setState(() {
//             //                 isHasImage = true;
//             //               });
//             //               BlocProvider.of<ContractBloc>(context)
//             //                   .add(UpdateContract(
//             //                       Contract(
//             //                         id: widget.contract.id,
//             //                         // storeId: contract.storeId,
//             //                         startDate: startDate,
//             //                         endDate: endDate,
//             //                         // contactId: widget.contract.contactId,
//             //                         // appointmentId:
//             //                         //     widget.contract.appointmentId,
//             //                         propertyId: widget.contract.propertyId,
//             //                         // appointment: widget.contract.appointment,
//             //                         createDate: DateTime.now(),
//             //                         property: widget.contract.property,
//             //                         status: 1,
//             //                         reasonCancel: null,
//             //                       ),
//             //                       listImage,
//             //                       medias,
//             //                       widget.contract.media));
//             //             } else {
//             //               setState(() {
//             //                 isHasImage = false;
//             //               });
//             //             }
//             //           },
//             //           child: Padding(
//             //             padding: const EdgeInsets.symmetric(vertical: 16),
//             //             child: Text(
//             //               'Cập nhật hợp đồng',
//             //               style:
//             //                   TxtStyle.heading3.copyWith(color: Colors.white),
//             //             ),
//             //           ),
//             //         ),
//             //       ),
//             //     ),
//             //   ],
//             // );
//             // // }
//             // return Text("$state");
//             return SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     Container(
//                       width: AppFormat.width(context),
//                       color: AppColor.boderColor,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 8),
//                         child: Text(
//                           "HÌNH ẢNH",
//                           style: TxtStyle.heading5Blue.copyWith(fontSize: 18),
//                         ),
//                       ),
//                     ),

//                     (listImage.isEmpty && medias.isEmpty)
//                         ? Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                             ),
//                             child: InkWell(
//                               onTap: () {
//                                 FocusManager.instance.primaryFocus?.unfocus();
//                                 getImage();
//                               },
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 16),
//                                 child: DottedBorder(
//                                   radius: const Radius.circular(10),
//                                   borderType: BorderType.RRect,
//                                   color: AppColor.primaryColor,
//                                   strokeWidth: 2,
//                                   dashPattern: const [16, 8],
//                                   child: Container(
//                                       height: AppFormat
//                                               .heightWithoutAppBarAndStatusbar(
//                                                   context) *
//                                           0.12,
//                                       width: AppFormat.width(context),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: AppColor.cardColor,
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             const Icon(
//                                               Icons.camera_alt_rounded,
//                                               size: 46,
//                                             ),
//                                             Text(
//                                               "Chọn từ 01 đến 10 hình cho hợp đồng",
//                                               style: TxtStyle.heading4.copyWith(
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       )),
//                                 ),
//                               ),
//                             ),
//                           )
//                         : Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 8),
//                             child: Row(
//                               children: [
//                                 InkWell(
//                                   onTap: () => getImage(),
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 16),
//                                     child: DottedBorder(
//                                       radius: const Radius.circular(10),
//                                       borderType: BorderType.RRect,
//                                       color: AppColor.primaryColor,
//                                       strokeWidth: 2,
//                                       dashPattern: const [16, 8],
//                                       child: Container(
//                                           height: AppFormat
//                                                   .heightWithoutAppBarAndStatusbar(
//                                                       context) *
//                                               0.12,
//                                           width: AppFormat
//                                                   .heightWithoutAppBarAndStatusbar(
//                                                       context) *
//                                               0.13,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             color: AppColor.cardColor,
//                                           ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               children: [
//                                                 const Icon(
//                                                   Icons.camera_alt_rounded,
//                                                   size: 32,
//                                                 ),
//                                                 Text(
//                                                   "Thêm hình",
//                                                   style: TxtStyle.heading4
//                                                       .copyWith(
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           )),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: SingleChildScrollView(
//                                     scrollDirection: Axis.horizontal,
//                                     child: Row(children: listchoseImage()),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                     !isHasImage
//                         ? Padding(
//                             padding: const EdgeInsets.only(
//                                 bottom: 12, left: 24, right: 16),
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 "Chọn từ 01 đến 10 hình.",
//                                 style: TxtStyle.heading5Blue
//                                     .copyWith(fontSize: 12, color: Colors.red),
//                               ),
//                             ),
//                           )
//                         : const SizedBox(),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       child: ChoseBrand(
//                         callback: callbackBrand,
//                         brand: widget.contract.brand,
//                       ),
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       child: ChoseProperty(
//                           callback: callbackProperty,
//                           property: widget.contract.property),
//                     ),

//                     // Padding(
//                     //   padding: const EdgeInsets.symmetric(
//                     //       horizontal: 16, vertical: 8),
//                     //   child: Row(children: [
//                     //     const Expanded(
//                     //         flex: 2,
//                     //         child: Text(
//                     //           "Địa chỉ: ",
//                     //           style: TxtStyle.heading4,
//                     //         )),
//                     //     Expanded(
//                     //         flex: 5,
//                     //         child: Container(
//                     //             decoration: BoxDecoration(
//                     //                 color: AppColor.boderColor,
//                     //                 borderRadius: BorderRadius.circular(10),
//                     //                 border: Border.all(color: Colors.black)),
//                     //             child: Padding(
//                     //               padding: const EdgeInsets.symmetric(
//                     //                   vertical: 8, horizontal: 8),
//                     //               child: Text(
//                     //                   AppFormat.getAddress(
//                     //                       widget.contract.property!),
//                     //                   overflow: TextOverflow.ellipsis,
//                     //                   maxLines: 2,
//                     //                   style: TxtStyle.heading4),
//                     //             ))),
//                     //   ]),
//                     // ),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       child: ChoseOwner(
//                         callback: callbackOwner,
//                         owner: returnOwner,
//                         property: widget.contract.property,
//                       ),
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       child: CustomTFFRequiredPrice(
//                           type: TextInputType.number,
//                           textController: _priceController,
//                           name: "Giá"),
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       child: CustomTFFRequiredM(
//                         isDisable: false,
//                         isM: 2,
//                         type: TextInputType.name,
//                         textController: _paymentTermController,
//                         name: "Chính sách thanh toán",
//                       ),
//                     ),

//                     const SizedBox(
//                       height: 8,
//                     ),
//                     Container(
//                       width: AppFormat.width(context),
//                       color: AppColor.boderColor,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 8),
//                         child: Text(
//                           "THỜI HẠN VÀ HÌNH ẢNH",
//                           style: TxtStyle.heading5Blue.copyWith(fontSize: 18),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Expanded(
//                               flex: 2,
//                               child: Text(
//                                 "Ngày bắt đầu: ",
//                                 style: TxtStyle.heading4,
//                               )),
//                           Expanded(
//                               flex: 5,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   pickDate(context, "start");
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       border: Border.all(
//                                           color: AppColor.secondColor)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 16, vertical: 8),
//                                     child: Text(
//                                       AppFormat.parseDate(startDate.toString()),
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: TxtStyle.heading4,
//                                     ),
//                                   ),
//                                 ),
//                               ))
//                         ],
//                       ),
//                     ),
//                     // const SizedBox(
//                     //   height: 8,
//                     // ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Expanded(
//                               flex: 2,
//                               child: Text(
//                                 "Ngày kết thúc: ",
//                                 style: TxtStyle.heading4,
//                               )),
//                           Expanded(
//                               flex: 5,
//                               child: GestureDetector(
//                                 onTap: () {
//                                   pickDate(context, "end");
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       border: Border.all(
//                                           color: AppColor.secondColor)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 16, vertical: 8),
//                                     child: Text(
//                                       AppFormat.parseDate(endDate.toString()),
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: TxtStyle.heading4,
//                                     ),
//                                   ),
//                                 ),
//                               ))
//                         ],
//                       ),
//                     ),
//                     // isValidDate
//                     //     ? const SizedBox()
//                     //     : Padding(
//                     //         padding:
//                     //             const EdgeInsets.only(top: 8.0, bottom: 8),
//                     //         child: Text(
//                     //           "Ngày bắt đầu không được bằng hoặc bé hơn ngày kết thúc",
//                     //           style: TxtStyle.heading4
//                     //               .copyWith(color: Colors.red),
//                     //         ),
//                     //       ),

//                     // isProperty
//                     //     ? const SizedBox(
//                     //         height: 8,
//                     //       )
//                     //     : Padding(
//                     //         padding:
//                     //             const EdgeInsets.only(top: 8.0, bottom: 8),
//                     //         child: Align(
//                     //           alignment: Alignment.centerLeft,
//                     //           child: Text(
//                     //             "Mặt bằng này đang còn hợp đồng. Vui lòng chọn ngày khác",
//                     //             style: TxtStyle.heading4
//                     //                 .copyWith(color: Colors.red),
//                     //           ),
//                     //         ),
//                     //       ),
//                     // const Expanded(child: SizedBox()),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       child: SizedBox(
//                         width: AppFormat.width(context),
//                         child: ElevatedButton(
//                           style: TxtStyle.buttonBlue,
//                           onPressed: () async {
//                             final prefs = await SharedPreferences.getInstance();
//                             String? id = prefs.getString("id");

//                             if ((listImage.length + medias.length) > 0 &&
//                                 (listImage.length + medias.length) < 11) {
//                               setState(() {
//                                 isHasImage = true;
//                               });
//                             } else {
//                               setState(() {
//                                 isHasImage = false;
//                               });
//                             }

//                             // if (returnBrand != null) {
//                             //   setState(() {
//                             //     isBrand = true;
//                             //   });
//                             // } else {
//                             //   setState(() {
//                             //     isBrand = false;
//                             //   });
//                             // }

//                             // if (returnOwner != null) {
//                             //   setState(() {
//                             //     isOwner = true;
//                             //   });
//                             // } else {
//                             //   setState(() {
//                             //     isOwner = false;
//                             //   });
//                             // }

//                             // if (returnProperty != null) {
//                             //   setState(() {
//                             //     isProperty = true;
//                             //   });
//                             // } else {
//                             //   setState(() {
//                             //     isProperty = false;
//                             //   });
//                             // }

//                             if (_formKey.currentState!.validate() &&
//                                     // a.isEmpty &&
//                                     // isBrand &&
//                                     // isOwner &&
//                                     // isProperty &&
//                                     isHasImage
//                                 //  && isValidDate
//                                 ) {
//                               // showConfirmContract(context);

//                               BlocProvider.of<ContractBloc>(context).add(
//                                   UpdateContract(
//                                       Contract(
//                                           status: 1,
//                                           id: widget.contract.id,
//                                           // appointmentId: widget.appointment.id,
//                                           // contactId: 1,
//                                           // ownerId: ,
//                                           createDate: DateTime.now(),
//                                           price: double.parse(
//                                                   AppFormat.savePrice(
//                                                       _priceController.text)) *
//                                               1000000,
//                                           ownerId: returnOwner!.id,
//                                           brandId: widget.contract.brandId,
//                                           startDate: startDate,
//                                           endDate: endDate,
//                                           paymentTerm: _paymentTermController
//                                               .text
//                                               .trim(),
//                                           brokerId: int.parse(id.toString()),
//                                           propertyId:
//                                               widget.contract.propertyId),
//                                       listImage,
//                                       // listImage,
//                                       medias,
//                                       widget.contract.media));
//                               // BlocProvider.of<PropertyForRentBloc>(context).add(
//                               //     UpdateStatusProperty(Property(
//                               //         brokerId: widget.property.brokerId,
//                               //         certificates: widget.property.certificates,
//                               //         contacts: widget.property.contacts,
//                               //         createDate: widget.property.createDate,
//                               //         depositTerm: widget.property.depositTerm,
//                               //         description: widget.property.description,
//                               //         direction: widget.property.direction,
//                               //         floor: widget.property.floor,
//                               //         floorArea: widget.property.floorArea,
//                               //         frontage: widget.property.frontage,
//                               //         horizontal: widget.property.horizontal,
//                               //         id: widget.property.id,
//                               //         industryProperties:
//                               //             widget.property.industryProperties,
//                               //         lastUpdateDate: DateTime.now(),
//                               //         location: widget.property.location,
//                               //         locationId: widget.property.locationId,
//                               //         media: widget.property.media,
//                               //         name: widget.property.name,
//                               //         parkingLot: widget.property.parkingLot,
//                               //         paymentTerm: widget.property.paymentTerm,
//                               //         price: widget.property.price,
//                               //         project: widget.property.project,
//                               //         projectId: widget.property.projectId,
//                               //         rejectReason: widget.property.rejectReason,
//                               //         rentalCondition:
//                               //             widget.property.rentalCondition,
//                               //         rentalTerm: widget.property.rentalTerm,
//                               //         roadWidth: widget.property.roadWidth,
//                               //         status: 3,
//                               //         tag: widget.property.tag,
//                               //         type: widget.property.type,
//                               //         vertical: widget.property.vertical)));
//                             }

//                             // BlocProvider.of<ContractBloc>(context).add(CreateContract(
//                             //     Contract(
//                             //         appointmentId: widget.appointment.id,
//                             //         contactId: 1,
//                             //         startDate: startDate,
//                             //         endDate: endDate,
//                             //         propertyId: widget.property.id),
//                             //     Store(
//                             //         brandId: widget.appointment.brandId,
//                             //         locationId: widget.property.locationId,
//                             //         name: (widget.appointment.brand!.name.toString() +
//                             //             " " +
//                             //             widget.property.location!.address.toString()),
//                             //         type: 1,
//                             //         status: 2,
//                             //         startDate: startDate,
//                             //         endDate: endDate,
//                             //         description: "ahihihihihihihihi")));

//                             // Navigator.of(context).pushAndRemoveUntil(
//                             //   MaterialPageRoute(
//                             //       builder: (context) => const CustomNavBar()),
//                             //   (route) => false,
//                             // );
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             child: Text(
//                               'Cập nhật',
//                               style: TxtStyle.heading3
//                                   .copyWith(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
