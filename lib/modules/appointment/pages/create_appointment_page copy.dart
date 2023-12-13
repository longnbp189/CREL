// import 'dart:async';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:crel_mobile/common/widgets/stateful/chose_brand.dart';
// import 'package:crel_mobile/config/app_format.dart';
// import 'package:crel_mobile/config/configs.dart';
// import 'package:crel_mobile/models/models.dart';
// import 'package:crel_mobile/modules/appointment/blocs/appointment/appointment_bloc.dart';
// import 'package:crel_mobile/modules/appointment/pages/add_property_appointment_page.dart';
// import 'package:crel_mobile/modules/appointment/repos/appointment_repo.dart';
// import 'package:crel_mobile/modules/mission/widgets/custom_tff_no_valid.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CreateAppointmentPage extends StatefulWidget {
//   const CreateAppointmentPage({Key? key}) : super(key: key);

//   @override
//   State<CreateAppointmentPage> createState() => _CreateAppointmentPageState();
// }

// class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
//   final _descriptionController = TextEditingController();
//   // List<Brand> listBrand = [];
//   // String nameBrand = "Chọn thương hiệu";
//   List<Property> suggestProperties = [];
//   List<Appointment> appoinment1 = [];
//   List<Appointment> appoinment2 = [];
//   List<Appointment> appoinment3 = [];
//   List<int> suggestInt = [];
//   bool isBrand = true;
//   bool isProperty = true;
//   bool isChoseTime = true; // check trống
//   bool isNotEqualTime = true; // check chọn ngày hẹn không trùng
//   bool isValidTime1 = true; // check đặt giờ hẹn
//   bool isValidTime2 = true; // check đặt giờ hẹn
//   bool isValidTime3 = true; // check đặt giờ hẹn
//   bool isQuantityProperties = true; //check số lượng property xem trong ngày
//   bool isChooseTimeQuantityProperties =
//       true; //check số lượng property xem khi chọn giờ
//   // int listIndexTime = 0;
//   // bool isSelected = true;
//   // int chooseTime = -1;
//   // bool isClicked = false;

//   List<String> freeCurrentTime = [];
//   List<String> selectedChoices = [];
//   // bool time2 = false;
//   // bool time3 = false;
//   DateTime date = DateTime(DateTime.now().year, DateTime.now().month);

//   DateTime? date1;
//   // DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
//   DateTime? date2;
//   // DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
//   DateTime? date3;
//   // DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
//   TimeOfDay? timer1;
//   // TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);
//   TimeOfDay? timer2;
//   // TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);
//   TimeOfDay? timer3;
//   // TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

//   // Future pickTime(BuildContext context, String timerType) async {
//   //   final chooseTime = await showTimePicker(
//   //     context: context,
//   //     builder: (context, child) => Theme(
//   //       data: ThemeData.light().copyWith(
//   //           colorScheme: const ColorScheme.light(
//   //         primary: AppColor.primaryColor,
//   //       )),
//   //       child: child!,
//   //     ),
//   //     initialTime: TimeOfDay.now(),
//   //     // initialEntryMode: TimePickerEntryMode.dial

//   //     // firstDate: DateTime.now(),
//   //     // lastDate: DateTime(2100)
//   //   );

//   //   if (chooseTime == null) return;
//   //   setState(() {
//   //     if (timerType == "timer1") {
//   //       timer1 = chooseTime;
//   //       listChoseTime
//   //           .add(choseDateTimeAppointment(context, "time2", date2, timer2));
//   //     } else if (timerType == "timer2") {
//   //       timer2 = chooseTime;
//   //       listChoseTime
//   //           .add(choseDateTimeAppointment(context, "time3", date3, timer3));
//   //     } else {
//   //       timer3 = chooseTime;
//   //     }
//   //   });
//   // }

//   Future pickDate(BuildContext context, String dateType) async {
//     final chooseDate = await showDatePicker(
//         context: context,
//         builder: (context, child) => Theme(
//               data: ThemeData.light().copyWith(
//                   colorScheme: const ColorScheme.light(
//                 primary: AppColor.primaryColor,
//               )),
//               child: child!,
//             ),
//         initialDate: TimeOfDay.now().hour >= 19
//             ? DateTime.now().add(const Duration(days: 2))
//             : DateTime.now().add(const Duration(hours: 24)),
//         firstDate: TimeOfDay.now().hour >= 19
//             ? DateTime.now().add(const Duration(days: 2))
//             : DateTime.now().add(const Duration(hours: 24)),
//         lastDate: DateTime(2100));

//     if (chooseDate == null) return;
//     // setState(() {
//     if (dateType == "time1") {
//       // pickTime(context, "timer1");
//       date1 = chooseDate;

//       freeCurrentTime = AppFormat.getListFreeTimeAppointment(chooseDate);

//       showDialogChoseTime(context, "timer1");
//     } else if (dateType == "time2") {
//       // pickTime(context, "timer2");
//       date2 = chooseDate;
//       freeCurrentTime = AppFormat.getListFreeTimeAppointment(chooseDate);

//       showDialogChoseTime(context, "timer2");
//     } else {
//       // pickTime(context, "timer3");
//       date3 = chooseDate;
//       freeCurrentTime = AppFormat.getListFreeTimeAppointment(chooseDate);

//       showDialogChoseTime(context, "timer3");
//     }
//     // });

//     //  setState(() {
//     //   if (dateType == "time1") {
//     //     pickTime(context, "timer1");
//     //     date1 = chooseDate;
//     //   } else if (dateType == "time2") {
//     //     pickTime(context, "timer2");
//     //     date2 = chooseDate;
//     //   } else {
//     //     pickTime(context, "timer3");
//     //     date3 = chooseDate;
//     //   }
//     // });
//   }

//   Future<dynamic> showDialogChoseTime(BuildContext context1, String timerType) {
//     return showDialog(
//       context: context1,
//       builder: (context) {
//         return Dialog(
//           insetPadding: const EdgeInsets.all(16),
//           child:

//               // StatefulBuilder(
//               // builder: (context, setState1) =>
//               Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text('Chọn giờ hẹn:'),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 Wrap(
//                   runSpacing: 8,
//                   spacing: 28,
//                   children: List.generate(
//                       freeCurrentTime.length,
//                       (index) => GestureDetector(
//                             onTap: () async {
//                               setState(
//                                 () {
//                                   if (timerType == "timer1") {
//                                     timer1 = TimeOfDay(
//                                         hour: int.parse(freeCurrentTime[index]
//                                             .substring(0, 2)),
//                                         minute: 0);
//                                     // listChoseTime.add(choseDateTimeAppointment(
//                                     //     context1, "time2", date2, timer2));
//                                     // listChoseTime.add(
//                                     //     choseDateTimeAppointment2(context1));
//                                     // context
//                                     //     .read<AppointmentBloc>()
//                                     //     .add(GetListToCreateAppointment(
//                                     //       AppFormat.connectDateTime(
//                                     //           date1!, timer1!),
//                                     //     ));

//                                     Navigator.pop(context, timer1);
//                                   } else if (timerType == "timer2") {
//                                     timer2 = TimeOfDay(
//                                         hour: int.parse(freeCurrentTime[index]
//                                             .substring(0, 2)),
//                                         minute: 0);
//                                     // listChoseTime.add(choseDateTimeAppointment(
//                                     //     context1, "time3", date3, timer3));
//                                     // appoinment2 = await AppointmentRepo()
//                                     //     .getListToCreateAppointment(date2!);
//                                     // appoinment2 =
//                                     //     BlocProvider.of<AppointmentBloc>(context)
//                                     //         .add(GetListToCreateAppointment(
//                                     //   AppFormat.connectDateTime(date2!, timer2!),
//                                     // ));
//                                     // context
//                                     //     .read<AppointmentBloc>()
//                                     //     .add(GetListToCreateAppointment(
//                                     //       AppFormat.connectDateTime(
//                                     //           date2!, timer2!),
//                                     //     ));
//                                     Navigator.pop(context, timer2);
//                                   } else {
//                                     timer3 = TimeOfDay(
//                                         hour: int.parse(freeCurrentTime[index]
//                                             .substring(0, 2)),
//                                         minute: 0);
//                                     // appoinment3 = await AppointmentRepo()
//                                     //     .getListToCreateAppointment(date3!);
//                                     Navigator.pop(context, timer3);
//                                   }
//                                   // chooseTime = index;
//                                 },
//                               );
//                               // if (timer1 != null) {
//                               //   appoinment1 = await AppointmentRepo()
//                               //       .getListToCreateAppointment(
//                               //           date1!,
//                               //           DateTime(date1!.year, date1!.month,
//                               //               date1!.day + 1));
//                               // }
//                               // if (timer2 != null) {
//                               //   appoinment2 = await AppointmentRepo()
//                               //       .getListToCreateAppointment(date2!);
//                               // }
//                               // if (timer3 != null) {
//                               //   appoinment3 = await AppointmentRepo()
//                               //       .getListToCreateAppointment(date3!);
//                               // }
//                             },
//                             child: Container(
//                               width: AppFormat.width(context) * 0.258,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 border: Border.all(
//                                     width: 1, color: AppColor.boderColor),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 8),
//                                 child: Center(
//                                     child: Text(
//                                   freeCurrentTime[index],
//                                   style: TxtStyle.heading4.copyWith(
//                                       fontWeight: FontWeight.w500,
//                                       color: AppColor.primaryColor),
//                                 )),
//                               ),
//                             ),
//                           )),
//                 ),
//               ],
//             ),
//           ),
//           // ),
//         );
//       },
//     );
//   }

//   Brand returnBrand = Brand();
//   callback(returnData) {
//     setState(() {
//       returnBrand = returnData;
//       isBrand = true;
//     });
//   }

//   @override
//   void dispose() {
//     _descriptionController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     // listChoseTime
//     //     .add(choseDateTimeAppointment(context, "time1", date1, timer1));
//     super.initState();
//   }

//   List<Widget> listChoseTime = [];

//   @override
//   Widget build(BuildContext context) {
//     // int count = 0;
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "Tạo cuộc hẹn",
//             style: TxtStyle.textAppBar,
//           ),
//           backgroundColor: AppColor.primaryColor,
//           centerTitle: true,
//         ),
//         body: GestureDetector(
//           onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//           child: SafeArea(
//               child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: BlocListener<AppointmentBloc, AppointmentState>(
//                 listener: (context, state) {
//                   if (state is CreateAppointmentSuccess) {
//                     AppFormat.showSnackBar(
//                         context, 1, "Tạo cuộc hẹn thành công");
//                     // context.read<AppointmentBloc>().add(const GetAppointmentRequested(true));
//                     // Navigator.of(context).pushAndRemoveUntil(
//                     //   MaterialPageRoute(
//                     //       builder: (context) => const CustomNavBar()),
//                     //   (route) => false,
//                     // );
//                     // Timer(const Duration(milliseconds: 2000), () {
//                     //   // Navigator.of(context).popUntil((route) => count++ >= 1);
//                     //   Navigator.pop(context);
//                     // });
//                     // context.read<AppointmentBloc>().add(
//                     //     SearchAppointmentByMonth(
//                     //         AppFormat.startDayOfMonth(date),
//                     //         AppFormat.endDayOfMonth(date),
//                     //         true));
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, AppRouter.customNavBar, (route) => false,
//                         arguments: 3);
//                   }
//                   // if (state is UpdateAppointmentSuccess) {
//                   //   AppFormat.showSnackBar(
//                   //       context, 1, "Xác nhận cuộc hẹn thành công");

//                   //   Navigator.of(context).popUntil((route) => count++ >= 1);
//                   // }
//                 },
//                 child: Column(
//                   // mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ChoseBrand(
//                       callback: callback,
//                     ),
//                     isBrand
//                         ? const SizedBox()
//                         : Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(
//                               "Vui lòng chọn thương hiệu",
//                               style:
//                                   TxtStyle.heading4.copyWith(color: Colors.red),
//                             ),
//                           ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Danh sách mặt bằng: ",
//                             style: TxtStyle.heading3
//                                 .copyWith(fontWeight: FontWeight.normal),
//                           ),
//                           suggestProperties.isNotEmpty
//                               ? IconButton(
//                                   splashColor: Colors.transparent,
//                                   highlightColor: Colors.transparent,
//                                   onPressed: () async {
//                                     final re = await Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               AddPropertyAppointmentPage(
//                                             suggest: suggestProperties,
//                                           ),
//                                         ));
//                                     if (re != null) {
//                                       setState(() {
//                                         suggestProperties =
//                                             re as List<Property>;
//                                         suggestInt = [];
//                                         for (var element in suggestProperties) {
//                                           suggestInt.add(element.id!);
//                                         }
//                                         isProperty = true;
//                                       });
//                                     }
//                                     // Navigator.pushNamed(
//                                     //     context, AppRouter.suggestProperty,
//                                     //     arguments: suggestProperties);
//                                   },
//                                   icon: const FaIcon(FontAwesomeIcons.plus))
//                               : const SizedBox()
//                         ],
//                       ),
//                     ),

//                     InkWell(
//                       onTap: () async {
//                         final result = await Navigator.pushNamed(
//                             context, AppRouter.suggestProperty);
//                         if (result != null) {
//                           setState(() {
//                             suggestProperties = result as List<Property>;
//                             suggestInt = [];
//                             for (var element in suggestProperties) {
//                               suggestInt.add(element.id!);
//                             }
//                             isProperty = true;
//                           });
//                         }
//                       },
//                       child: suggestProperties.isNotEmpty
//                           ? SizedBox(
//                               height: 220,
//                               // color: Colors.amber,
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: suggestProperties.length,
//                                 itemBuilder: (context, index) {
//                                   return Stack(
//                                     alignment: AlignmentDirectional.topEnd,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             top: 8, bottom: 8, right: 8),
//                                         child: Container(
//                                           width: 200,
//                                           height: 200,
//                                           decoration: const BoxDecoration(
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: AppColor.textColor,
//                                                 blurRadius: 7,
//                                                 offset: Offset(0, 3),
//                                               ),
//                                             ],
//                                           ),
//                                           child: Card(
//                                             color: AppColor.primaryColor,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                             ),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 ClipRRect(
//                                                   borderRadius:
//                                                       const BorderRadius.only(
//                                                           topLeft:
//                                                               Radius.circular(
//                                                                   10),
//                                                           topRight:
//                                                               Radius.circular(
//                                                                   10)),
//                                                   child: CachedNetworkImage(
//                                                     height: AppFormat.height(
//                                                             context) /
//                                                         8,
//                                                     width: AppFormat.width(
//                                                         context),
//                                                     fit: BoxFit.cover,
//                                                     imageUrl: suggestProperties[
//                                                                 index]
//                                                             .media!
//                                                             .isNotEmpty
//                                                         ? suggestProperties[
//                                                                 index]
//                                                             .media![0]
//                                                             .link
//                                                             .toString()
//                                                         : "https://www.savills.com.vn/_images/thaibuilding-20190911.jpg",
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(12),
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       SizedBox(
//                                                         width: AppFormat.width(
//                                                             context),
//                                                         child: Text(
//                                                           suggestProperties[
//                                                                   index]
//                                                               .name
//                                                               .toString(),
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           maxLines: 2,
//                                                           style: TxtStyle
//                                                               .heading4
//                                                               .copyWith(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold),
//                                                         ),
//                                                       ),
//                                                       const SizedBox(
//                                                         height: 8,
//                                                       ),
//                                                       Text(
//                                                         suggestProperties[index]
//                                                                 .location!
//                                                                 .address
//                                                                 .toString() +
//                                                             ", " +
//                                                             suggestProperties[
//                                                                     index]
//                                                                 .location!
//                                                                 .ward!
//                                                                 .name
//                                                                 .toString() +
//                                                             ", " +
//                                                             suggestProperties[
//                                                                     index]
//                                                                 .location!
//                                                                 .ward!
//                                                                 .district!
//                                                                 .name
//                                                                 .toString(),
//                                                         maxLines: 2,
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                         style: TxtStyle
//                                                             .heading5Blue
//                                                             .copyWith(
//                                                                 color: Colors
//                                                                     .white),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Positioned(
//                                         top: -8,
//                                         right: -8,
//                                         child: IconButton(
//                                             onPressed: () {
//                                               setState(() {
//                                                 suggestProperties.remove(
//                                                     suggestProperties[index]);
//                                                 suggestInt
//                                                     .remove(suggestInt[index]);
//                                               });
//                                             },
//                                             icon: const DeleteItemIcon()),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               ))
//                           : Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 8),
//                               child: DottedBorder(
//                                 radius: const Radius.circular(10),
//                                 borderType: BorderType.RRect,
//                                 color: AppColor.secondColor,
//                                 strokeWidth: 2,
//                                 dashPattern: const [16, 8],
//                                 child: Container(
//                                     // height:
//                                     //     AppFormat.heightWithoutAppBarAndStatusbar(context) *
//                                     //         0.12,
//                                     width: AppFormat.width(context),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: AppColor.cardColor,
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(24),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           const FaIcon(
//                                               FontAwesomeIcons.building,
//                                               size: 48,
//                                               color: AppColor.primaryColor),
//                                           Padding(
//                                             padding:
//                                                 const EdgeInsets.only(top: 8.0),
//                                             child: Text(
//                                               "Chọn danh sách mặt bằng muốn đề xuất",
//                                               style: TxtStyle.heading4.copyWith(
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     )),
//                               ),
//                             ),
//                     ),
//                     // SuggestItem(property: , isCheckbox: false),
//                     isProperty
//                         ? const SizedBox()
//                         : Text(
//                             "Vui lòng chọn mặt bằng",
//                             style:
//                                 TxtStyle.heading4.copyWith(color: Colors.red),
//                           ),

//                     isQuantityProperties
//                         ? const SizedBox()
//                         : Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(
//                               "Chọn tối đa 3 mặt bằng",
//                               style:
//                                   TxtStyle.heading4.copyWith(color: Colors.red),
//                             ),
//                           ),

//                     isChooseTimeQuantityProperties
//                         ? const SizedBox()
//                         : Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(
//                               "Ứng với 15h chỉ có thể xem nhiều nhất 3 mặt bằng cùng 1 lúc \nTương tự 17h chỉ xem nhiều nhất 2 mặt bằng cùng 1 lúc \nVà 19h chỉ được xem 1 mặt bằng",
//                               style:
//                                   TxtStyle.heading4.copyWith(color: Colors.red),
//                             ),
//                           ),

//                     Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Chọn ngày hẹn: ",
//                             style: TxtStyle.heading3
//                                 .copyWith(fontWeight: FontWeight.normal),
//                           ),
//                           // IconButton(
//                           //     onPressed: () {
//                           //       setState(() {
//                           //         if (listChoseTime.length < 3) {
//                           //           // if (listChoseTime.isEmpty) {
//                           //           //   isChoseTime = true;
//                           //           //   return listChoseTime.add(
//                           //           //       choseDateTimeAppointment(
//                           //           //           context, "time1", date1, timer1));
//                           //           // }
//                           //           if (listChoseTime.length == 1) {
//                           //             isChoseTime = true;
//                           //             return listChoseTime.add(
//                           //                 choseDateTimeAppointment(
//                           //                     context, "time2", date2, timer2));
//                           //           }
//                           //           if (listChoseTime.length == 2) {
//                           //             isChoseTime = true;

//                           //             return listChoseTime.add(
//                           //                 choseDateTimeAppointment(
//                           //                     context, "time3", date3, timer3));
//                           //           }
//                           //         } else {
//                           //           isChoseTime = false;
//                           //         }
//                           //       });
//                           //     },
//                           //     icon: const FaIcon(FontAwesomeIcons.plus))
//                         ],
//                       ),
//                     ),

//                     // Builder(builder: (context) {
//                     // return
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           // children: listChoseTime,
//                           children: [
//                             choseDateTimeAppointment(
//                                 context, "time1", date1, timer1),
//                             // choseDateTimeAppointment(
//                             //     context, "time2", date2, timer2),
//                             // choseDateTimeAppointment(
//                             //     context, "time3", date3, timer3),
//                             // ]

//                             // Row(children: listChoseTime),
//                           ]

//                           //   // GestureDetector(
//                           //   //   onTap: () {
//                           //   //     pickDate(context, "time2");
//                           //   //   },
//                           //   //   child: AnimatedContainer(
//                           //   //     duration: const Duration(milliseconds: 300),
//                           //   //     decoration: BoxDecoration(
//                           //   //       color: Colors.white,
//                           //   //       border:
//                           //   //           Border.all(width: 1, color: AppColor.boderColor),
//                           //   //       borderRadius: BorderRadius.circular(10),
//                           //   //     ),
//                           //   //     child: Padding(
//                           //   //       padding: const EdgeInsets.symmetric(
//                           //   //           vertical: 8, horizontal: 8),
//                           //   //       child: Center(
//                           //   //         child: Column(
//                           //   //           children: [
//                           //   //             Text(
//                           //   //               AppFormat.parseDate(date2.toString()),
//                           //   //               style: TxtStyle.heading4.copyWith(
//                           //   //                   fontWeight: FontWeight.w500,
//                           //   //                   color: AppColor.primaryColor),
//                           //   //             ),
//                           //   //             Text(
//                           //   //               timer2.hour.toString().padLeft(2, "0") +
//                           //   //                   " : " +
//                           //   //                   timer2.minute.toString().padLeft(2, "0"),
//                           //   //               style: TxtStyle.heading4.copyWith(
//                           //   //                   fontWeight: FontWeight.w500,
//                           //   //                   color: AppColor.primaryColor),
//                           //   //             ),
//                           //   //           ],
//                           //   //         ),
//                           //   //       ),
//                           //   //     ),
//                           //   //   ),
//                           //   // ),
//                           //   // GestureDetector(
//                           //   //   onTap: () {
//                           //   //     pickDate(context, "time3");
//                           //   //   },
//                           //   //   child: AnimatedContainer(
//                           //   //     duration: const Duration(milliseconds: 300),
//                           //   //     decoration: BoxDecoration(
//                           //   //       color: Colors.white,
//                           //   //       border:
//                           //   //           Border.all(width: 1, color: AppColor.boderColor),
//                           //   //       borderRadius: BorderRadius.circular(10),
//                           //   //     ),
//                           //   //     child: Padding(
//                           //   //       padding: const EdgeInsets.symmetric(
//                           //   //           vertical: 8, horizontal: 8),
//                           //   //       child: Center(
//                           //   //         child: Column(
//                           //   //           children: [
//                           //   //             Text(
//                           //   //               AppFormat.parseDate(date3.toString()),
//                           //   //               style: TxtStyle.heading4.copyWith(
//                           //   //                   fontWeight: FontWeight.w500,
//                           //   //                   color: AppColor.primaryColor),
//                           //   //             ),
//                           //   //             Text(
//                           //   //               timer3.hour.toString().padLeft(2, "0") +
//                           //   //                   " : " +
//                           //   //                   timer3.minute.toString().padLeft(2, "0"),
//                           //   //               style: TxtStyle.heading4.copyWith(
//                           //   //                   fontWeight: FontWeight.w500,
//                           //   //                   color: AppColor.primaryColor),
//                           //   //             ),
//                           //   //           ],
//                           //   //         ),
//                           //   //       ),
//                           //   //     ),
//                           //   //   ),
//                           //   // ),
//                           // ],
//                           ),
//                     ),
//                     // ;
//                     // }
//                     // ),
//                     // date1 != null
//                     //     ? const Padding(
//                     //         padding: EdgeInsets.only(top: 8.0),
//                     //         child: Text("Chọn giờ hẹn:"),
//                     //       )
//                     //     : const SizedBox(),
//                     // date1 != null
//                     //     ? Padding(
//                     //         padding: const EdgeInsets.symmetric(vertical: 8),
//                     //         child: Wrap(
//                     //           runSpacing: 8,
//                     //           spacing: 28,
//                     //           children: List.generate(
//                     //               freeCurrentTime.length,
//                     //               (index) => GestureDetector(
//                     //                     onTap: () {
//                     //                       setState(() {
//                     //                         chooseTime = index;
//                     //                       });
//                     //                     },
//                     //                     child: Container(
//                     //                       width: AppFormat.width(context) * 0.258,
//                     //                       decoration: BoxDecoration(
//                     //                         color: chooseTime == index
//                     //                             ? AppColor.primaryColor
//                     //                             : Colors.white,
//                     //                         border: Border.all(
//                     //                             width: 1, color: AppColor.boderColor),
//                     //                         borderRadius: BorderRadius.circular(10),
//                     //                       ),
//                     //                       child: Padding(
//                     //                         padding: const EdgeInsets.symmetric(
//                     //                             vertical: 8, horizontal: 8),
//                     //                         child: Center(
//                     //                             child: Text(
//                     //                           freeCurrentTime[index],
//                     //                           style: TxtStyle.heading4.copyWith(
//                     //                               fontWeight: FontWeight.w500,
//                     //                               color: chooseTime == index
//                     //                                   ? Colors.white
//                     //                                   : AppColor.primaryColor),
//                     //                         )),
//                     //                       ),
//                     //                     ),
//                     //                   )),
//                     //         ),
//                     //       )
//                     //     : const SizedBox(),

//                     isChoseTime
//                         ? const SizedBox()
//                         : Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(
//                               "Vui lòng chọn ít nhất một ngày hẹn",
//                               style:
//                                   TxtStyle.heading4.copyWith(color: Colors.red),
//                             ),
//                           ),
//                     isNotEqualTime
//                         ? const SizedBox()
//                         : Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(
//                               "Giờ hẹn không được trùng nhau",
//                               style:
//                                   TxtStyle.heading4.copyWith(color: Colors.red),
//                             ),
//                           ),
//                     isValidTime1
//                         ? const SizedBox()
//                         : Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(
//                               "Bạn đã có cuộc hẹn trong giờ hẹn thứ 1 này",
//                               style:
//                                   TxtStyle.heading4.copyWith(color: Colors.red),
//                             ),
//                           ),
//                     // isValidTime2
//                     //     ? const SizedBox()
//                     //     : Padding(
//                     //         padding: const EdgeInsets.only(top: 8.0),
//                     //         child: Text(
//                     //           "Bạn đã có cuộc hẹn trong giờ hẹn thứ 2 này",
//                     //           style:
//                     //               TxtStyle.heading4.copyWith(color: Colors.red),
//                     //         ),
//                     //       ),
//                     // isValidTime3
//                     //     ? const SizedBox()
//                     //     : Padding(
//                     //         padding: const EdgeInsets.only(top: 8.0),
//                     //         child: Text(
//                     //           "Bạn đã có cuộc hẹn trong giờ hẹn thứ 3 này",
//                     //           style:
//                     //               TxtStyle.heading4.copyWith(color: Colors.red),
//                     //         ),
//                     //       ),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       child: CustomTFFNoValid(
//                         type: TextInputType.name,
//                         textController: _descriptionController,
//                         name: "Lời nhắn",
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       child: SizedBox(
//                         width: AppFormat.width(context),
//                         child: ElevatedButton(
//                           style: TxtStyle.buttonBlue,
//                           onPressed: () async {
//                             final prefs = await SharedPreferences.getInstance();
//                             String? id = prefs.getString("id");

//                             if (returnBrand.id != null) {
//                               setState(() {
//                                 isBrand = true;
//                               });
//                             } else {
//                               setState(() {
//                                 isBrand = false;
//                               });
//                             }

//                             if (suggestInt.isNotEmpty) {
//                               setState(() {
//                                 isProperty = true;
//                               });
//                             } else {
//                               setState(() {
//                                 isProperty = false;
//                               });
//                             }
//                             if ((timer1 != null &&
//                                     AppFormat.connectDateTime(date1!, timer1!)
//                                             .compareTo(
//                                                 AppFormat.currentDateTime(
//                                                     DateTime.now())) >
//                                         0) ||
//                                 (timer2 != null &&
//                                     AppFormat.connectDateTime(date2!, timer2!)
//                                             .compareTo(
//                                                 AppFormat.currentDateTime(
//                                                     DateTime.now())) >
//                                         0) ||
//                                 (timer3 != null &&
//                                     AppFormat.connectDateTime(date3!, timer3!)
//                                             .compareTo(
//                                                 AppFormat.currentDateTime(
//                                                     DateTime.now())) >
//                                         0)) {
//                               setState(() {
//                                 isChoseTime = true;
//                               });
//                             } else {
//                               setState(() {
//                                 isChoseTime = false;
//                               });
//                             }
//                             if ((timer1 != null) && (timer2 != null) ||
//                                 (timer1 != null) && (timer3 != null) ||
//                                 (timer2 != null) && (timer3 != null)) {
//                               if (AppFormat.connectDateTime(date1!, timer1!)
//                                       .isAtSameMomentAs(AppFormat
//                                           .connectDateTime(date2!, timer2!)) ||
//                                   AppFormat.connectDateTime(date1!, timer1!)
//                                       .isAtSameMomentAs(
//                                           AppFormat.connectDateTime(
//                                               date3!, timer3!)) ||
//                                   AppFormat.connectDateTime(date2!, timer2!)
//                                       .isAtSameMomentAs(
//                                           AppFormat.connectDateTime(
//                                               date3!, timer3!))) {
//                                 setState(() {
//                                   isNotEqualTime = false;
//                                 });
//                               } else {
//                                 setState(() {
//                                   isNotEqualTime = true;
//                                 });
//                               }
//                             } else {
//                               setState(() {
//                                 isNotEqualTime = true;
//                               });
//                             }
// //********************** Check have appointment in time 1 */
//                             if (timer1 != null) {
//                               appoinment1 = await AppointmentRepo()
//                                   .getListToCreateAppointment(
//                                       date1!,
//                                       DateTime(date1!.year, date1!.month,
//                                               date1!.day)
//                                           .add(const Duration(days: 1)));
//                             }
//                             if (timer1 != null) {
//                               if (timer1!.hour == 15 && suggestInt.length > 3) {
//                                 setState(() {
//                                   isChooseTimeQuantityProperties = false;
//                                 });
//                               } else if (timer1!.hour == 17 &&
//                                   suggestInt.length > 2) {
//                                 setState(() {
//                                   isChooseTimeQuantityProperties = false;
//                                 });
//                               } else if (timer1!.hour == 19 &&
//                                   suggestInt.length > 1) {
//                                 setState(() {
//                                   isChooseTimeQuantityProperties = false;
//                                 });
//                               } else if (suggestInt.length > 3) {
//                                 setState(() {
//                                   isQuantityProperties = false;
//                                 });
//                               } else {
//                                 setState(() {
//                                   isQuantityProperties = true;
//                                   isChooseTimeQuantityProperties = true;
//                                 });
//                               }
//                             }
//                             // for (var element in appoinment1) {
//                             //   if (DateTime(
//                             //               element.onDateTime!.year,
//                             //               element.onDateTime!.month,
//                             //               element.onDateTime!.day,
//                             //               element.onDateTime!.hour +
//                             //                   2 *
//                             //                       (element.properties!.isEmpty
//                             //                           ? 0
//                             //                           : element
//                             //                               .properties!.length),
//                             //               element.onDateTime!.minute - 1)
//                             //           .isAfter(DateTime(
//                             //               date1!.year,
//                             //               date1!.month,
//                             //               date1!.day,
//                             //               timer1!.hour,
//                             //               timer1!.minute)) &&
//                             //       DateTime(
//                             //               element.onDateTime!.year,
//                             //               element.onDateTime!.month,
//                             //               element.onDateTime!.day,
//                             //               element.onDateTime!.hour)
//                             //           .isBefore(DateTime(
//                             //         date1!.year,
//                             //         date1!.month,
//                             //         date1!.day,
//                             //         timer1!.hour,
//                             //       ))) {
//                             //     setState(() {
//                             //       isValidTime1 = false;
//                             //     });
//                             //     return;
//                             //   } else if (DateTime(
//                             //           element.onDateTime!.year,
//                             //           element.onDateTime!.month,
//                             //           element.onDateTime!.day,
//                             //           element.onDateTime!.hour)
//                             //       .isAtSameMomentAs(DateTime(
//                             //           date1!.year,
//                             //           date1!.month,
//                             //           date1!.day,
//                             //           timer1!.hour))) {
//                             //     setState(() {
//                             //       isValidTime1 = false;
//                             //     });
//                             //     return;
//                             //   } else if (DateTime(
//                             //               date1!.year,
//                             //               date1!.month,
//                             //               date1!.day,
//                             //               timer1!.hour +
//                             //                   2 *
//                             //                       (suggestInt.isEmpty
//                             //                           ? 0
//                             //                           : suggestInt.length),
//                             //               timer1!.minute)
//                             //           .isAfter(DateTime(
//                             //               element.onDateTime!.year,
//                             //               element.onDateTime!.month,
//                             //               element.onDateTime!.day,
//                             //               element.onDateTime!.hour)) &&
//                             //       DateTime(
//                             //               element.onDateTime!.year,
//                             //               element.onDateTime!.month,
//                             //               element.onDateTime!.day,
//                             //               element.onDateTime!.hour +
//                             //                   2 *
//                             //                       (element.properties!.isEmpty
//                             //                           ? 0
//                             //                           : element
//                             //                               .properties!.length),
//                             //               element.onDateTime!.minute - 1)
//                             //           .isAfter(DateTime(
//                             //               date1!.year,
//                             //               date1!.month,
//                             //               date1!.day,
//                             //               timer1!.hour,
//                             //               timer1!.minute,
//                             //               timer1!.hour +
//                             //                   2 *
//                             //                       (suggestInt.isEmpty
//                             //                           ? 0
//                             //                           : suggestInt.length),
//                             //               timer1!.minute))) {
//                             //     setState(() {
//                             //       isValidTime1 = false;
//                             //     });
//                             //     return;
//                             //   }
//                             //   setState(() {
//                             //     isValidTime1 = true;
//                             //   });
//                             // }

//                             //********************** Check have appointment in time 2 */
//                             // if (timer2 != null) {
//                             //   appoinment2 = await AppointmentRepo()
//                             //       .getListToCreateAppointment(
//                             //           date2!,
//                             //           DateTime(date2!.year, date2!.month,
//                             //                   date2!.day)
//                             //               .add(const Duration(days: 1)));
//                             // }
//                             // if (timer2 != null) {
//                             //   if (timer2!.hour == 15 && suggestInt.length > 3) {
//                             //     setState(() {
//                             //       isChooseTimeQuantityProperties = false;
//                             //     });
//                             //   } else if (timer2!.hour == 17 &&
//                             //       suggestInt.length > 2) {
//                             //     setState(() {
//                             //       isChooseTimeQuantityProperties = false;
//                             //     });
//                             //   } else if (timer2!.hour == 19 &&
//                             //       suggestInt.length > 1) {
//                             //     setState(() {
//                             //       isChooseTimeQuantityProperties = false;
//                             //     });
//                             //   } else if (suggestInt.length > 3) {
//                             //     setState(() {
//                             //       isQuantityProperties = false;
//                             //     });
//                             //   } else {
//                             //     setState(() {
//                             //       isQuantityProperties = true;
//                             //       isChooseTimeQuantityProperties = true;
//                             //     });
//                             //   }
//                             // }
//                             // for (var element in appoinment1) {
//                             //   if (DateTime(
//                             //               element.onDateTime!.year,
//                             //               element.onDateTime!.month,
//                             //               element.onDateTime!.day,
//                             //               element.onDateTime!.hour +
//                             //                   2 *
//                             //                       (element.properties!.isEmpty
//                             //                           ? 0
//                             //                           : element
//                             //                               .properties!.length),
//                             //               element.onDateTime!.minute - 1)
//                             //           .isAfter(DateTime(
//                             //               date2!.year,
//                             //               date2!.month,
//                             //               date2!.day,
//                             //               timer2!.hour,
//                             //               timer2!.minute)) &&
//                             //       DateTime(
//                             //               element.onDateTime!.year,
//                             //               element.onDateTime!.month,
//                             //               element.onDateTime!.day,
//                             //               element.onDateTime!.hour)
//                             //           .isBefore(DateTime(
//                             //         date2!.year,
//                             //         date2!.month,
//                             //         date2!.day,
//                             //         timer2!.hour,
//                             //       ))) {
//                             //     setState(() {
//                             //       isValidTime2 = false;
//                             //     });
//                             //     return;
//                             //   } else if (DateTime(
//                             //           element.onDateTime!.year,
//                             //           element.onDateTime!.month,
//                             //           element.onDateTime!.day,
//                             //           element.onDateTime!.hour)
//                             //       .isAtSameMomentAs(DateTime(
//                             //           date2!.year,
//                             //           date2!.month,
//                             //           date2!.day,
//                             //           timer2!.hour))) {
//                             //     setState(() {
//                             //       isValidTime2 = false;
//                             //     });
//                             //     return;
//                             //   } else if (DateTime(
//                             //               date2!.year,
//                             //               date2!.month,
//                             //               date2!.day,
//                             //               timer2!.hour +
//                             //                   2 *
//                             //                       (suggestInt.isEmpty
//                             //                           ? 0
//                             //                           : suggestInt.length),
//                             //               timer1!.minute)
//                             //           .isAfter(DateTime(
//                             //               element.onDateTime!.year,
//                             //               element.onDateTime!.month,
//                             //               element.onDateTime!.day,
//                             //               element.onDateTime!.hour)) &&
//                             //       DateTime(
//                             //               element.onDateTime!.year,
//                             //               element.onDateTime!.month,
//                             //               element.onDateTime!.day,
//                             //               element.onDateTime!.hour +
//                             //                   2 *
//                             //                       (element.properties!.isEmpty
//                             //                           ? 0
//                             //                           : element
//                             //                               .properties!.length),
//                             //               element.onDateTime!.minute - 1)
//                             //           .isAfter(DateTime(
//                             //               date2!.year,
//                             //               date2!.month,
//                             //               date2!.day,
//                             //               timer2!.hour,
//                             //               timer2!.minute,
//                             //               timer2!.hour +
//                             //                   2 *
//                             //                       (suggestInt.isEmpty
//                             //                           ? 0
//                             //                           : suggestInt.length),
//                             //               timer2!.minute))) {
//                             //     setState(() {
//                             //       isValidTime2 = false;
//                             //     });
//                             //     return;
//                             //   }
//                             //   setState(() {
//                             //     isValidTime2 = true;
//                             //   });
//                             // }

//                             // //********************** Check have appointment in time 3 */

//                             // if (timer3 != null) {
//                             //   appoinment1 = await AppointmentRepo()
//                             //       .getListToCreateAppointment(
//                             //           date3!,
//                             //           DateTime(date3!.year, date3!.month,
//                             //                   date3!.day)
//                             //               .add(const Duration(days: 1)));
//                             // }
//                             // if (timer3 != null) {
//                             //   if (timer3!.hour == 15 && suggestInt.length > 3) {
//                             //     setState(() {
//                             //       isChooseTimeQuantityProperties = false;
//                             //     });
//                             //   } else if (timer3!.hour == 17 &&
//                             //       suggestInt.length > 2) {
//                             //     setState(() {
//                             //       isChooseTimeQuantityProperties = false;
//                             //     });
//                             //   } else if (timer3!.hour == 19 &&
//                             //       suggestInt.length > 1) {
//                             //     setState(() {
//                             //       isChooseTimeQuantityProperties = false;
//                             //     });
//                             //   } else if (suggestInt.length > 3) {
//                             //     setState(() {
//                             //       isQuantityProperties = false;
//                             //     });
//                             //   } else {
//                             //     setState(() {
//                             //       isQuantityProperties = true;
//                             //       isChooseTimeQuantityProperties = true;
//                             //     });
//                             //   }
//                             // }
//                             // for (var element in appoinment1) {
//                             //   if (DateTime(
//                             //               element.onDateTime!.year,
//                             //               element.onDateTime!.month,
//                             //               element.onDateTime!.day,
//                             //               element.onDateTime!.hour +
//                             //                   2 *
//                             //                       (element.properties!.isEmpty
//                             //                           ? 0
//                             //                           : element
//                             //                               .properties!.length),
//                             //               element.onDateTime!.minute - 1)
//                             //           .isAfter(DateTime(
//                             //               date3!.year,
//                             //               date3!.month,
//                             //               date3!.day,
//                             //               timer3!.hour,
//                             //               timer3!.minute)) &&
//                             //       DateTime(
//                             //               element.onDateTime!.year,
//                             //               element.onDateTime!.month,
//                             //               element.onDateTime!.day,
//                             //               element.onDateTime!.hour)
//                             //           .isBefore(DateTime(
//                             //         date3!.year,
//                             //         date3!.month,
//                             //         date3!.day,
//                             //         timer3!.hour,
//                             //       ))) {
//                             //     setState(() {
//                             //       isValidTime3 = false;
//                             //     });
//                             //     return;
//                             //   } else if (DateTime(
//                             //           element.onDateTime!.year,
//                             //           element.onDateTime!.month,
//                             //           element.onDateTime!.day,
//                             //           element.onDateTime!.hour)
//                             //       .isAtSameMomentAs(DateTime(
//                             //           date3!.year,
//                             //           date3!.month,
//                             //           date3!.day,
//                             //           timer3!.hour))) {
//                             //     setState(() {
//                             //       isValidTime3 = false;
//                             //     });
//                             //     return;
//                             //   } else if (DateTime(
//                             //               date3!.year,
//                             //               date3!.month,
//                             //               date3!.day,
//                             //               timer3!.hour +
//                             //                   2 *
//                             //                       (suggestInt.isEmpty
//                             //                           ? 0
//                             //                           : suggestInt.length),
//                             //               timer3!.minute)
//                             //           .isAfter(DateTime(
//                             //               element.onDateTime!.year,
//                             //               element.onDateTime!.month,
//                             //               element.onDateTime!.day,
//                             //               element.onDateTime!.hour)) &&
//                             //       DateTime(
//                             //               element.onDateTime!.year,
//                             //               element.onDateTime!.month,
//                             //               element.onDateTime!.day,
//                             //               element.onDateTime!.hour +
//                             //                   2 *
//                             //                       (element.properties!.isEmpty
//                             //                           ? 0
//                             //                           : element
//                             //                               .properties!.length),
//                             //               element.onDateTime!.minute - 1)
//                             //           .isAfter(DateTime(
//                             //               date3!.year,
//                             //               date3!.month,
//                             //               date3!.day,
//                             //               timer3!.hour,
//                             //               timer3!.minute,
//                             //               timer3!.hour +
//                             //                   2 *
//                             //                       (suggestInt.isEmpty
//                             //                           ? 0
//                             //                           : suggestInt.length),
//                             //               timer3!.minute))) {
//                             //     setState(() {
//                             //       isValidTime3 = false;
//                             //     });
//                             //     return;
//                             //   }
//                             //   setState(() {
//                             //     isValidTime3 = true;
//                             //   });
//                             // }

//                             if (suggestInt.length > 3) {
//                               setState(() {
//                                 isQuantityProperties = false;
//                               });
//                             } else {
//                               setState(() {
//                                 isQuantityProperties = true;
//                               });
//                             }
//                             if (isChoseTime &&
//                                 isBrand &&
//                                 isProperty &&
//                                 isNotEqualTime &&
//                                 isValidTime1 &&
//                                 // isValidTime2 &&
//                                 // isValidTime3 &&
//                                 isQuantityProperties &&
//                                 isChooseTimeQuantityProperties) {
//                               setState(() {
//                                 isBrand = true;
//                                 isProperty = true;
//                                 isChoseTime = true;
//                                 isNotEqualTime = true;
//                                 isValidTime1 = true;
//                                 // isValidTime2 = true;
//                                 // isValidTime3 = true;
//                                 isQuantityProperties = true;
//                                 isChooseTimeQuantityProperties = true;
//                               });
//                               BlocProvider.of<AppointmentBloc>(context).add(
//                                   CreateAppointmentRequested(
//                                       Appointment(
//                                           brokerId: int.parse(id!),
//                                           // brandFreeTime1: timer1 != null
//                                           //     ? AppFormat.connectDateTime(
//                                           //         date1!, timer1!)
//                                           //     : null,
//                                           // brandFreeTime2: timer2 != null
//                                           //     ? AppFormat.connectDateTime(
//                                           //         date2!, timer2!)
//                                           //     : null,
//                                           // brandFreeTime3: timer3 != null
//                                           //     ? AppFormat.connectDateTime(
//                                           //         date3!, timer3!)
//                                           //     : null,
//                                           // createDateTime: DateTime.now(),

//                                           status: 6,
//                                           description: _descriptionController
//                                               .text
//                                               .trim(),
//                                           onDateTime: DateTime.now(),
//                                           brandId: returnBrand.id),
//                                       suggestInt));
//                             }
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             child: Text(
//                               'Tạo cuộc hẹn',
//                               style: TxtStyle.heading3
//                                   .copyWith(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )),
//         ));
//   }

//   GestureDetector choseDateTimeAppointment(
//       BuildContext context, String typeTime, DateTime? date, TimeOfDay? timer) {
//     return GestureDetector(
//       onTap: () {
//         pickDate(context, typeTime);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(width: 1, color: AppColor.boderColor),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//           child: Center(
//             child: (date != null && timer != null)
//                 ? Column(
//                     children: [
//                       Text(
//                         AppFormat.parseDate(date.toString()),
//                         style: TxtStyle.heading4.copyWith(
//                             fontWeight: FontWeight.w500,
//                             color: AppColor.primaryColor),
//                       ),
//                       Text(
//                         timer.hour.toString().padLeft(2, "0") +
//                             " : " +
//                             timer.minute.toString().padLeft(2, "0"),
//                         style: TxtStyle.heading4.copyWith(
//                             fontWeight: FontWeight.bold,
//                             color: AppColor.primaryColor),
//                       ),
//                     ],
//                   )
//                 : Padding(
//                     padding: const EdgeInsets.only(
//                         top: 8.0, bottom: 8.0, left: 4, right: 4),
//                     child: Text("Chọn ngày",
//                         style: TxtStyle.heading4.copyWith(
//                             fontWeight: FontWeight.bold,
//                             color: AppColor.primaryColor)),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }

//   // GestureDetector choseDateTimeAppointment2(BuildContext context) {
//   //   return GestureDetector(
//   //     onTap: () {
//   //       pickDate(context, "time2");
//   //     },
//   //     child: Container(
//   //       decoration: BoxDecoration(
//   //         color: Colors.white,
//   //         border: Border.all(width: 1, color: AppColor.boderColor),
//   //         borderRadius: BorderRadius.circular(10),
//   //       ),
//   //       child: Padding(
//   //         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
//   //         child: Center(
//   //           child: (date2 != null && timer2 != null)
//   //               ? Column(
//   //                   children: [
//   //                     Text(
//   //                       AppFormat.parseDate(date2.toString()),
//   //                       style: TxtStyle.heading4.copyWith(
//   //                           fontWeight: FontWeight.w500,
//   //                           color: AppColor.primaryColor),
//   //                     ),
//   //                     Text(
//   //                       timer2!.hour.toString().padLeft(2, "0") +
//   //                           " : " +
//   //                           timer2!.minute.toString().padLeft(2, "0"),
//   //                       style: TxtStyle.heading4.copyWith(
//   //                           fontWeight: FontWeight.bold,
//   //                           color: AppColor.primaryColor),
//   //                     ),
//   //                   ],
//   //                 )
//   //               : Padding(
//   //                   padding: const EdgeInsets.only(
//   //                       top: 8.0, bottom: 8.0, left: 4, right: 4),
//   //                   child: Text("Chọn ngày",
//   //                       style: TxtStyle.heading4.copyWith(
//   //                           fontWeight: FontWeight.bold,
//   //                           color: AppColor.primaryColor)),
//   //                 ),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
// }

// class DeleteItemIcon extends StatelessWidget {
//   const DeleteItemIcon({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white,
//           border: Border.all(
//             color: Colors.black,
//             width: 2,
//           ),
//         ),
//         child: const FaIcon(FontAwesomeIcons.xmark));
//   }
// }

// class AddItemIcon extends StatelessWidget {
//   const AddItemIcon({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white,
//           border: Border.all(
//             color: Colors.black,
//             width: 2,
//           ),
//         ),
//         child: const FaIcon(
//           FontAwesomeIcons.plus,
//           size: 30,
//         ));
//   }
// }

// // if (DateTime(
// //             element.onDateTime!.year,
// //             element.onDateTime!.month,
// //             element.onDateTime!.day,
// //             element.onDateTime!.hour +
// //                 2 *
// //                     (element.properties!.isEmpty
// //                         ? 0
// //                         : element.properties!.length),
// //             element.onDateTime!.minute - 1)
// //         .isAfter(DateTime(
// //             date1!.year,
// //             date1!.month,
// //             date1!.day,
// //             timer1!.hour,
// //             timer1!.minute - 1)) &&
// //     DateTime(
// //             element.onDateTime!.year,
// //             element.onDateTime!.month,
// //             element.onDateTime!.day,
// //             element.onDateTime!.hour)
// //         .isBefore(DateTime(
// //       date1!.year,
// //       date1!.month,
// //       date1!.day,
// //       timer1!.hour,
// //     ))) {
// //   setState(() {
// //     isValidTime = false;
// //   });
// //   return;
// // } else if (DateTime(
// //         element.onDateTime!.year,
// //         element.onDateTime!.month,
// //         element.onDateTime!.day,
// //         element.onDateTime!.hour)
// //     .isAtSameMomentAs(DateTime(date1!.year,
// //         date1!.month, date1!.day, timer1!.hour))) {
// //   setState(() {
// //     isValidTime = false;
// //   });
// //   return;
// // } else if (DateTime(
// //             date1!.year,
// //             date1!.month,
// //             date1!.day,
// //             timer1!.hour +
// //                 2 *
// //                     (suggestInt.isEmpty
// //                         ? 0
// //                         : suggestInt.length),
// //             timer1!.minute - 1)
// //         .isAfter(DateTime(
// //             element.onDateTime!.year,
// //             element.onDateTime!.month,
// //             element.onDateTime!.day,
// //             element.onDateTime!.hour)) &&
// //     DateTime(
// //             element.onDateTime!.year,
// //             element.onDateTime!.month,
// //             element.onDateTime!.day,
// //             element.onDateTime!.hour)
// //         .isAfter(DateTime(
// //             date1!.year,
// //             date1!.month,
// //             date1!.day,
// //             timer1!.hour,
// //             timer1!.minute))) {
// //   setState(() {
// //     isValidTime = false;
// //   });
// //   return;
// // }
// // setState(() {
// //   isValidTime = true;
// // });

//////////////////////////assssssssssssssssssssssssssssssssss
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crel_mobile/common/widgets/stateful/chose_brand.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/modules/appointment/blocs/appointment/appointment_bloc.dart';
import 'package:crel_mobile/modules/appointment/pages/add_property_appointment_page.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_no_valid.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAppointmentPage extends StatefulWidget {
  const CreateAppointmentPage({Key? key}) : super(key: key);

  @override
  State<CreateAppointmentPage> createState() => _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
  final _descriptionController = TextEditingController();
  Property suggestProperties = Property();
  List<Appointment> appoinment1 = [];
  List<int> suggestInt = [];
  bool isBrand = true;
  bool isProperty = true;
  bool isChoseTime = true; // check trống
  bool isNotEqualTime = true; // check chọn ngày hẹn không trùng
  bool isValidTime1 = true; // check đặt giờ hẹn

  List<String> freeCurrentTime = [];
  List<String> selectedChoices = [];

  DateTime? date1;
  TimeOfDay? timer1;

  Future pickDate(BuildContext context, String dateType) async {
    final chooseDate = await showDatePicker(
        context: context,
        builder: (context, child) => Theme(
              data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                primary: AppColor.primaryColor,
              )),
              child: child!,
            ),
        initialDate: TimeOfDay.now().hour >= 19
            ? DateTime.now().add(const Duration(days: 2))
            : DateTime.now().add(const Duration(hours: 24)),
        firstDate: TimeOfDay.now().hour >= 19
            ? DateTime.now().add(const Duration(days: 2))
            : DateTime.now().add(const Duration(hours: 24)),
        lastDate: DateTime(2100));

    if (chooseDate == null) return;
    // setState(() {
    if (dateType == "time1") {
      // pickTime(context, "timer1");
      date1 = chooseDate;

      freeCurrentTime = AppFormat.getListFreeTimeAppointment(chooseDate);

      showDialogChoseTime(context, "timer1");
    }
  }

  Future<dynamic> showDialogChoseTime(BuildContext context1, String timerType) {
    return showDialog(
      context: context1,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          child:

              // StatefulBuilder(
              // builder: (context, setState1) =>
              Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Chọn giờ hẹn:'),
                const SizedBox(
                  height: 8,
                ),
                Wrap(
                  runSpacing: 8,
                  spacing: 28,
                  children: List.generate(
                      freeCurrentTime.length,
                      (index) => GestureDetector(
                            onTap: () async {
                              setState(
                                () {
                                  if (timerType == "timer1") {
                                    timer1 = TimeOfDay(
                                        hour: int.parse(freeCurrentTime[index]
                                            .substring(0, 2)),
                                        minute: 0);

                                    Navigator.pop(context, timer1);
                                  }
                                },
                              );
                            },
                            child: Container(
                              width: AppFormat.width(context) * 0.258,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 1, color: AppColor.boderColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: Center(
                                    child: Text(
                                  freeCurrentTime[index],
                                  style: TxtStyle.heading4.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.primaryColor),
                                )),
                              ),
                            ),
                          )),
                ),
              ],
            ),
          ),
          // ),
        );
      },
    );
  }

  Brand returnBrand = Brand();
  callback(returnData) {
    setState(() {
      returnBrand = returnData;
      isBrand = true;
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   // listChoseTime
  //   //     .add(choseDateTimeAppointment(context, "time1", date1, timer1));
  //   super.initState();
  // }

  List<Widget> listChoseTime = [];

  @override
  Widget build(BuildContext context) {
    // int count = 0;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tạo cuộc hẹn",
            style: TxtStyle.textAppBar,
          ),
          backgroundColor: AppColor.primaryColor,
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BlocListener<AppointmentBloc, AppointmentState>(
                listener: (context, state) {
                  if (state is CreateAppointmentSuccess) {
                    AppFormat.showSnackBar(
                        context, 1, "Tạo cuộc hẹn thành công");

                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRouter.customNavBar, (route) => false,
                        arguments: 3);
                  }
                },
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChoseBrand(
                      callback: callback,
                    ),
                    isBrand
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Vui lòng chọn thương hiệu",
                              style:
                                  TxtStyle.heading4.copyWith(color: Colors.red),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Danh sách mặt bằng: ",
                            style: TxtStyle.heading3
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          suggestProperties != Property
                              ? IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed: () async {
                                    final re = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddPropertyAppointmentPage(
                                            suggest: suggestProperties,
                                          ),
                                        ));
                                    if (re != null) {
                                      setState(() {
                                        suggestProperties = re as Property;
                                        suggestInt = [];
                                        // for (var element in suggestProperties) {
                                        //   suggestInt.add(element.id!);
                                        // }
                                        isProperty = true;
                                      });
                                    }
                                    // Navigator.pushNamed(
                                    //     context, AppRouter.suggestProperty,
                                    //     arguments: suggestProperties);
                                  },
                                  icon: const FaIcon(FontAwesomeIcons.plus))
                              : const SizedBox()
                        ],
                      ),
                    ),

                    InkWell(
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                            context, AppRouter.suggestProperty);
                        if (result != null) {
                          setState(() {
                            suggestProperties = result as Property;
                            // suggestInt = [];
                            // for (var element in suggestProperties) {
                            //   suggestInt.add(element.id!);
                            // }
                            isProperty = true;
                          });
                        }
                      },
                      child: suggestProperties != Property()
                          ? SizedBox(
                              height: 220,
                              // color: Colors.amber,
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, right: 8),
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColor.textColor,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Card(
                                        color: AppColor.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10)),
                                              child: CachedNetworkImage(
                                                height:
                                                    AppFormat.height(context) /
                                                        8,
                                                width: AppFormat.width(context),
                                                fit: BoxFit.cover,
                                                imageUrl: suggestProperties
                                                            .media !=
                                                        null
                                                    ? suggestProperties
                                                        .media![0].link
                                                        .toString()
                                                    : "https://www.savills.com.vn/_images/thaibuilding-20190911.jpg",
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: AppFormat.width(
                                                        context),
                                                    child: Text(
                                                      suggestProperties.name
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: TxtStyle.heading4
                                                          .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    suggestProperties
                                                            .location!.address
                                                            .toString() +
                                                        ", " +
                                                        suggestProperties
                                                            .location!
                                                            .ward!
                                                            .name
                                                            .toString() +
                                                        ", " +
                                                        suggestProperties
                                                            .location!
                                                            .ward!
                                                            .district!
                                                            .name
                                                            .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TxtStyle.heading5Blue
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -8,
                                    right: -8,
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            // suggestProperties.remove(
                                            //     suggestProperties[index]);
                                            // suggestInt
                                            //     .remove(suggestInt[index]);
                                            suggestProperties = Property();
                                          });
                                        },
                                        icon: const DeleteItemIcon()),
                                  ),
                                ],
                              ))
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: DottedBorder(
                                radius: const Radius.circular(10),
                                borderType: BorderType.RRect,
                                color: AppColor.secondColor,
                                strokeWidth: 2,
                                dashPattern: const [16, 8],
                                child: Container(
                                    // height:
                                    //     AppFormat.heightWithoutAppBarAndStatusbar(context) *
                                    //         0.12,
                                    width: AppFormat.width(context),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColor.cardColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const FaIcon(
                                              FontAwesomeIcons.building,
                                              size: 48,
                                              color: AppColor.primaryColor),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              "Chọn danh sách mặt bằng muốn đề xuất",
                                              style: TxtStyle.heading4.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                    ),
                    // SuggestItem(property: , isCheckbox: false),
                    isProperty
                        ? const SizedBox()
                        : Text(
                            "Vui lòng chọn mặt bằng",
                            style:
                                TxtStyle.heading4.copyWith(color: Colors.red),
                          ),

                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Chọn ngày hẹn: ",
                            style: TxtStyle.heading3
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          // IconButton(
                          //     onPressed: () {
                          //       setState(() {
                          //         if (listChoseTime.length < 3) {
                          //           // if (listChoseTime.isEmpty) {
                          //           //   isChoseTime = true;
                          //           //   return listChoseTime.add(
                          //           //       choseDateTimeAppointment(
                          //           //           context, "time1", date1, timer1));
                          //           // }
                          //           if (listChoseTime.length == 1) {
                          //             isChoseTime = true;
                          //             return listChoseTime.add(
                          //                 choseDateTimeAppointment(
                          //                     context, "time2", date2, timer2));
                          //           }
                          //           if (listChoseTime.length == 2) {
                          //             isChoseTime = true;

                          //             return listChoseTime.add(
                          //                 choseDateTimeAppointment(
                          //                     context, "time3", date3, timer3));
                          //           }
                          //         } else {
                          //           isChoseTime = false;
                          //         }
                          //       });
                          //     },
                          //     icon: const FaIcon(FontAwesomeIcons.plus))
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child:
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // children: listChoseTime,
                              children: [
                            choseDateTimeAppointment(
                                context, "time1", date1, timer1),
                          ]),
                    ),
                    isChoseTime
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Vui lòng chọn ngày hẹn",
                              style:
                                  TxtStyle.heading4.copyWith(color: Colors.red),
                            ),
                          ),

                    isValidTime1
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Bạn đã có cuộc hẹn trong giờ hẹn này",
                              style:
                                  TxtStyle.heading4.copyWith(color: Colors.red),
                            ),
                          ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: CustomTFFNoValid(
                        type: TextInputType.name,
                        textController: _descriptionController,
                        name: "Lời nhắn",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SizedBox(
                        width: AppFormat.width(context),
                        child: ElevatedButton(
                          style: TxtStyle.buttonBlue,
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            String? id = prefs.getString("id");

                            if (returnBrand.id != null) {
                              setState(() {
                                isBrand = true;
                              });
                            } else {
                              setState(() {
                                isBrand = false;
                              });
                            }

                            if (isChoseTime &&
                                isBrand &&
                                isProperty &&
                                isNotEqualTime &&
                                isValidTime1) {
                              setState(() {
                                isBrand = true;
                                isProperty = true;
                                isChoseTime = true;
                                isNotEqualTime = true;
                                isValidTime1 = true;
                              });
                              BlocProvider.of<AppointmentBloc>(context)
                                  .add(CreateAppointmentRequested(
                                Appointment(
                                    brokerId: int.parse(id!),
                                    // brandFreeTime1: timer1 != null
                                    //     ? AppFormat.connectDateTime(
                                    //         date1!, timer1!)
                                    //     : null,

                                    property: suggestProperties,
                                    status: 6,
                                    description:
                                        _descriptionController.text.trim(),
                                    onDateTime: DateTime.now(),
                                    brandId: returnBrand.id),
                                // suggestInt
                              ));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'Tạo cuộc hẹn',
                              style: TxtStyle.heading3
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
        ));
  }

  GestureDetector choseDateTimeAppointment(
      BuildContext context, String typeTime, DateTime? date, TimeOfDay? timer) {
    return GestureDetector(
      onTap: () {
        pickDate(context, typeTime);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: AppColor.boderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Center(
            child: (date != null && timer != null)
                ? Column(
                    children: [
                      Text(
                        AppFormat.parseDate(date.toString()),
                        style: TxtStyle.heading4.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.primaryColor),
                      ),
                      Text(
                        timer.hour.toString().padLeft(2, "0") +
                            " : " +
                            timer.minute.toString().padLeft(2, "0"),
                        style: TxtStyle.heading4.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 4, right: 4),
                    child: Text("Chọn ngày",
                        style: TxtStyle.heading4.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor)),
                  ),
          ),
        ),
      ),
    );
  }
}

class DeleteItemIcon extends StatelessWidget {
  const DeleteItemIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: const FaIcon(FontAwesomeIcons.xmark));
  }
}

class AddItemIcon extends StatelessWidget {
  const AddItemIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: const FaIcon(
          FontAwesomeIcons.plus,
          size: 30,
        ));
  }
}
