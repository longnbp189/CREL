// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:crel_mobile/common/widgets/stateless/container_boder.dart';
// import 'package:crel_mobile/config/app_format.dart';
// import 'package:crel_mobile/config/configs.dart';
// import 'package:crel_mobile/modules/mission/blocs/district/district_bloc.dart';
// import 'package:crel_mobile/modules/mission/blocs/ward/ward_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:html_editor_enhanced/html_editor.dart';

// class NotificationPage extends StatefulWidget {
//   const NotificationPage({Key? key, this.id}) : super(key: key);
//   final String? id;
//   @override
//   State<NotificationPage> createState() => _NotificationPageState();
// }

// class _NotificationPageState extends State<NotificationPage> {
//   final _streetController = TextEditingController();
//   String district = "Quận, huyện, xã";
//   String nameDistrict = "Quận, huyện, xã";

//   String ward = "Phường, xã, thị trấn";
//   String nameWard = "Phường, xã, thị trấn";
//   String nameStreet = "Địa chỉ cụ thể";
//   String streetFinal = "Địa chỉ";
//   String nameStreetFinal = "Địa chỉ";

//   String project = "Dự án";
//   String nameProject = "Dự án";

//   bool isDistrict = false;
//   bool isWard = false;
//   late WardBloc wardBloc;
//   // QuillController _quillController = QuillController.basic();

//   List<String> items = ['ling 1', 'hieu 2', 'long 3'];
//   String? selectedItem;
//   List<String> listProject = [];
//   final _searchController = TextEditingController();

//   List<String> certificates = ['Đang chờ sổ', 'Đã có sổ', 'Giấy tờ khác'];
//   List<String> listCertificate = [];
//   String certificate = "Giấy tờ pháp lý";
//   String nameCertificate = "Giấy tờ pháp lý";

//   @override
//   void initState() {
//     listProject = items;
//     _streetController.text = "";
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _streetController.dispose();
//     super.dispose();
//   }

//   HtmlEditorController controller = HtmlEditorController();

//   Stream<List<Userrr>> readUser() => FirebaseFirestore.instance
//       .collection("notification")
//       .orderBy("OnDatetime", descending: true)
//       .limit(20)
//       .snapshots()
//       .map(
//           (event) => event.docs.map((e) => Userrr.fromJson(e.data())).toList());
//   // CollectionReference writeUser =
//   //     FirebaseFirestore.instance.collection("notification");
//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //   appBar: AppBar(title: const Text("Thông báo")),
//     //   body: widget.id != null
//     //       ? Center(child: Text(widget.id!))
//     //       : SingleChildScrollView(
//     //           child: Column(
//     //             children: [
//     //               const Center(child: Text("long")),
//     //               // TextField(
//     //               //   onChanged: (value) {
//     //               //     setState(() {
//     //               //       listProject = items
//     //               //           .where((projectName) => projectName
//     //               //               .toLowerCase()
//     //               //               .contains(value.toLowerCase()))
//     //               //           .toList();
//     //               //     });
//     //               //   },
//     //               //   controller: _searchController,
//     //               //   cursorColor: AppColor.secondColor,
//     //               //   style: const TextStyle(color: AppColor.secondColor),
//     //               //   decoration: const InputDecoration(
//     //               //     isDense: true,
//     //               //     border: InputBorder.none,
//     //               //     hintText: "Nhập",
//     //               //     hintStyle: TxtStyle.heading5Gray,
//     //               //     prefixIcon: Icon(
//     //               //       Icons.search,
//     //               //       color: AppColor.textColor,
//     //               //       size: 24,
//     //               //     ),
//     //               //   ),
//     //               // ),
//     //               // SizedBox(
//     //               //   height: 300,
//     //               //   child: ListView.builder(
//     //               //       // physics: const NeverScrollableScrollPhysics(),
//     //               //       shrinkWrap: true,
//     //               //       itemCount: listProject.length,
//     //               //       itemBuilder: (context, index) {
//     //               //         return Container(
//     //               //           decoration: BoxDecoration(
//     //               //               border: Border(
//     //               //             top: BorderSide(
//     //               //               color: AppColor.boderColor,
//     //               //               width: 1,
//     //               //             ),
//     //               //             bottom: BorderSide(
//     //               //               color: AppColor.boderColor,
//     //               //               width: 1,
//     //               //             ),
//     //               //           )),
//     //               //           child: Padding(
//     //               //               padding: const EdgeInsets.symmetric(
//     //               //                 horizontal: 16,
//     //               //                 vertical: 8,
//     //               //               ),
//     //               //               child: Text(
//     //               //                 listProject[index].toString(),
//     //               //                 style: TxtStyle.heading4,
//     //               //               )),
//     //               //         );
//     //               //       }),
//     //               // ),
//     //               // InkWell(
//     //               //     onTap: () async {
//     //               //       streetFinal = (await showModalBottomSheet(
//     //               //               isScrollControlled: true,
//     //               //               context: context,
//     //               //               builder: ((context) {
//     //               //                 return SingleChildScrollView(
//     //               //                   padding: EdgeInsets.only(
//     //               //                       bottom: MediaQuery.of(context)
//     //               //                           .viewInsets
//     //               //                           .bottom),
//     //               //                   child: SizedBox(
//     //               //                     height: AppFormat.heightWithoutStatusbar(
//     //               //                             context) *
//     //               //                         0.425,
//     //               //                     child: Scaffold(
//     //               //                       body: StatefulBuilder(
//     //               //                           builder: (context, setState1) {
//     //               //                         return Wrap(
//     //               //                           children: [
//     //               //                             Container(
//     //               //                               color: AppColor.boderColor,
//     //               //                               child: Row(
//     //               //                                 mainAxisAlignment:
//     //               //                                     MainAxisAlignment
//     //               //                                         .spaceBetween,
//     //               //                                 crossAxisAlignment:
//     //               //                                     CrossAxisAlignment.center,
//     //               //                                 children: [
//     //               //                                   IconButton(
//     //               //                                       onPressed: () {
//     //               //                                         Navigator.of(context)
//     //               //                                             .pop();
//     //               //                                       },
//     //               //                                       icon: const Icon(
//     //               //                                           Icons.close)),
//     //               //                                   Text(
//     //               //                                     "Địa chỉ",
//     //               //                                     style: TxtStyle.heading4
//     //               //                                         .copyWith(
//     //               //                                             fontWeight:
//     //               //                                                 FontWeight
//     //               //                                                     .bold),
//     //               //                                   ),
//     //               //                                   const IconButton(
//     //               //                                       onPressed: null,
//     //               //                                       icon: Icon(
//     //               //                                         Icons.close,
//     //               //                                         color:
//     //               //                                             Colors.transparent,
//     //               //                                       ))
//     //               //                                 ],
//     //               //                               ),
//     //               //                             ),
//     //               //                             Padding(
//     //               //                               padding:
//     //               //                                   const EdgeInsets.symmetric(
//     //               //                                       horizontal: 16,
//     //               //                                       vertical: 12),
//     //               //                               child: Column(
//     //               //                                 children: [
//     //               //                                   InkWell(
//     //               //                                     onTap: () {
//     //               //                                       getDistrictMethod(
//     //               //                                           context, setState1);
//     //               //                                     },
//     //               //                                     child: ChooseTextFromDrop(
//     //               //                                         name: district,
//     //               //                                         lable: nameDistrict),
//     //               //                                   ),
//     //               //                                   const SizedBox(
//     //               //                                     height: 12,
//     //               //                                   ),
//     //               //                                   InkWell(
//     //               //                                     onTap: () {
//     //               //                                       isDistrict
//     //               //                                           ? getWardMethod(
//     //               //                                               context,
//     //               //                                               setState1)
//     //               //                                           : ScaffoldMessenger
//     //               //                                                   .of(context)
//     //               //                                               .showSnackBar(
//     //               //                                                   const SnackBar(
//     //               //                                               behavior:
//     //               //                                                   SnackBarBehavior
//     //               //                                                       .floating,
//     //               //                                               content: Text(
//     //               //                                                   "Vui lòng chọn quận, huyện, thị xã"),
//     //               //                                             ));
//     //               //                                     },
//     //               //                                     child: ChooseTextFromDrop(
//     //               //                                         name: ward,
//     //               //                                         lable: nameWard),
//     //               //                                   ),
//     //               //                                   const SizedBox(
//     //               //                                     height: 12,
//     //               //                                   ),
//     //               //                                   InkWell(
//     //               //                                     onTap: () {
//     //               //                                       isWard
//     //               //                                           ? getWardMethod(
//     //               //                                               context,
//     //               //                                               setState1)
//     //               //                                           : ScaffoldMessenger
//     //               //                                                   .of(context)
//     //               //                                               .showSnackBar(
//     //               //                                                   const SnackBar(
//     //               //                                               behavior:
//     //               //                                                   SnackBarBehavior
//     //               //                                                       .floating,
//     //               //                                               content: Text(
//     //               //                                                   "Vui lòng chọn phường, xã, thị trấn"),
//     //               //                                             ));
//     //               //                                     },
//     //               //                                     child: CustomTFFNoValid(
//     //               //                                         read: false,
//     //               //                                         textController:
//     //               //                                             _streetController,
//     //               //                                         name: nameStreet),
//     //               //                                   ),
//     //               //                                 ],
//     //               //                               ),
//     //               //                             ),
//     //               //                             Padding(
//     //               //                               padding:
//     //               //                                   const EdgeInsets.symmetric(
//     //               //                                       horizontal: 16),
//     //               //                               child: Row(
//     //               //                                 children: [
//     //               //                                   const SizedBox(),
//     //               //                                   Expanded(
//     //               //                                       child: (isDistrict &&
//     //               //                                               isWard)
//     //               //                                           ? ElevatedButton(
//     //               //                                               style: TxtStyle
//     //               //                                                   .buttonBlue,
//     //               //                                               onPressed: () {
//     //               //                                                 setState(() {});
//     //               //                                                 (_streetController
//     //               //                                                             .text ==
//     //               //                                                         "")
//     //               //                                                     ? Navigator.pop(
//     //               //                                                         context,
//     //               //                                                         ward +
//     //               //                                                             ", " +
//     //               //                                                             district)
//     //               //                                                     : Navigator.pop(
//     //               //                                                         context,
//     //               //                                                         _streetController.text +
//     //               //                                                             ", " +
//     //               //                                                             ward +
//     //               //                                                             ", " +
//     //               //                                                             district);
//     //               //                                               },
//     //               //                                               child: Text(
//     //               //                                                 "Hoàn thành",
//     //               //                                                 style: TxtStyle
//     //               //                                                     .heading3
//     //               //                                                     .copyWith(
//     //               //                                                         color: Colors
//     //               //                                                             .white),
//     //               //                                               ))
//     //               //                                           : ElevatedButton(
//     //               //                                               style: TxtStyle
//     //               //                                                   .buttonGray,
//     //               //                                               onPressed: null,
//     //               //                                               child: Text(
//     //               //                                                 "Hoàn thành",
//     //               //                                                 style: TxtStyle
//     //               //                                                     .heading3
//     //               //                                                     .copyWith(
//     //               //                                                         color: Colors
//     //               //                                                             .white),
//     //               //                                               ))),
//     //               //                                 ],
//     //               //                               ),
//     //               //                             ),
//     //               //                           ],
//     //               //                         );
//     //               //                       }),
//     //               //                     ),
//     //               //                   ),
//     //               //                 );
//     //               //               }))) ??
//     //               //           "";
//     //               //     },
//     //               //     child: ChooseTextFromDrop(
//     //               //       name: streetFinal,
//     //               //       lable: nameStreetFinal,
//     //               //     )),

//     //               // GestureDetector(
//     //               //   onTap: () {
//     //               //     Navigator.push(context, MaterialPageRoute(builder: (_) {
//     //               //       return const FullScreenImage(
//     //               //         isFile: false,
//     //               //         imageUrl:
//     //               //             "http://images5.fanpop.com/image/photos/29400000/toshiro-3-bleach-anime-29490330-388-432.jpg",
//     //               //         tag: "generate_a_unique_tag",
//     //               //       );
//     //               //     }));
//     //               //   },
//     //               //   child: Hero(
//     //               //     child: ClipRRect(
//     //               //         borderRadius: BorderRadius.circular(10),
//     //               //         child: Image.network(
//     //               //             "http://images5.fanpop.com/image/photos/29400000/toshiro-3-bleach-anime-29490330-388-432.jpg",
//     //               //             // "https://static.wikia.nocookie.net/bleach/images/1/16/Hitsugayatoshiro.png/revision/latest?cb=20220501214054&path-prefix=en",
//     //               //             fit: BoxFit.cover)),
//     //               //     tag: "generate_a_unique_",
//     //               //   ),
//     //               // ),
//     //               // CircleAvatar(
//     //               //   child: GestureDetector(
//     //               //     onTap: () async {
//     //               //       await showDialog(
//     //               //           context: context,
//     //               //           builder: (_) => const ImageDialog());
//     //               //     },
//     //               //   ),
//     //               //   radius: 50.0,
//     //               //   //Photo by Tamas Tuzes-Katai on Unsplash
//     //               //   // backgroundImage: const AssetImage('assets/tamas.jpg')
//     //               // ),
//     //               // InkWell(
//     //               //   onTap: () => showModalBottomSheet(
//     //               //     context: context,
//     //               //     builder: (context) => Container(
//     //               //       color: Colors.amber,
//     //               //       height: 50,
//     //               //     ),
//     //               //   ),
//     //               //   child: IgnorePointer(
//     //               //     child: CustomTFFUpdateEmpty(
//     //               //         type: TextInputType.name,
//     //               //         textController: _streetController,
//     //               //         name: "Tầng"),
//     //               //   ),
//     //               // ),

//     //               Container(
//     //                 decoration: BoxDecoration(
//     //                     borderRadius: BorderRadius.circular(10),
//     //                     color: Colors.amber),
//     //                 // height: 100,
//     //                 width: AppFormat.width(context),
//     //                 child: Padding(
//     //                   padding: const EdgeInsets.symmetric(
//     //                       horizontal: 8, vertical: 8),
//     //                   child: Column(
//     //                     children: [
//     //                       Text(
//     //                         "Tạo hợp đồng",
//     //                         style: TxtStyle.heading3
//     //                             .copyWith(color: AppColor.primaryColor),
//     //                       ),
//     //                       const SizedBox(
//     //                         height: 8,
//     //                       ),
//     //                       Row(
//     //                         children: [
//     //                           const Expanded(
//     //                               flex: 2, child: Text("Mặt bằng: ")),
//     //                           Expanded(
//     //                               flex: 6,
//     //                               child: Container(
//     //                                 decoration: BoxDecoration(
//     //                                     borderRadius: BorderRadius.circular(10),
//     //                                     border:
//     //                                         Border.all(color: Colors.black)),
//     //                                 child: const Padding(
//     //                                   padding: EdgeInsets.symmetric(
//     //                                       horizontal: 16, vertical: 8),
//     //                                   child: Text(
//     //                                     "Mặt bằng Nguyễn Công Trứ High Land Huê",
//     //                                     overflow: TextOverflow.ellipsis,
//     //                                   ),
//     //                                 ),
//     //                               ))
//     //                         ],
//     //                       ),
//     //                       const SizedBox(
//     //                         height: 8,
//     //                       ),
//     //                       Row(
//     //                         children: [
//     //                           const Expanded(
//     //                               flex: 2, child: Text("Địa điểm: ")),
//     //                           Expanded(
//     //                               flex: 6,
//     //                               child: Container(
//     //                                 decoration: BoxDecoration(
//     //                                     borderRadius: BorderRadius.circular(10),
//     //                                     border:
//     //                                         Border.all(color: Colors.black)),
//     //                                 child: const Padding(
//     //                                   padding: EdgeInsets.symmetric(
//     //                                       horizontal: 16, vertical: 8),
//     //                                   child: Text(
//     //                                     "Mặt bằng Nguyễn Công Trứ High Land Huê",
//     //                                     overflow: TextOverflow.ellipsis,
//     //                                   ),
//     //                                 ),
//     //                               ))
//     //                         ],
//     //                       ),
//     //                       const SizedBox(
//     //                         height: 8,
//     //                       ),
//     //                       Row(
//     //                         children: [
//     //                           const Expanded(
//     //                               flex: 2, child: Text("Thương hiệu: ")),
//     //                           Expanded(
//     //                               flex: 6,
//     //                               child: Container(
//     //                                 decoration: BoxDecoration(
//     //                                     borderRadius: BorderRadius.circular(10),
//     //                                     border:
//     //                                         Border.all(color: Colors.black)),
//     //                                 child: const Padding(
//     //                                   padding: EdgeInsets.symmetric(
//     //                                       horizontal: 16, vertical: 8),
//     //                                   child: Text(
//     //                                     "Mặt bằng Nguyễn Công Trứ High Land Huê",
//     //                                     overflow: TextOverflow.ellipsis,
//     //                                   ),
//     //                                 ),
//     //                               ))
//     //                         ],
//     //                       ),
//     //                       const SizedBox(
//     //                         height: 8,
//     //                       ),
//     //                       Row(
//     //                         children: [
//     //                           const Expanded(
//     //                               flex: 2, child: Text("Hạn thuê: ")),
//     //                           Expanded(
//     //                               flex: 6,
//     //                               child: Container(
//     //                                 decoration: BoxDecoration(
//     //                                     borderRadius: BorderRadius.circular(10),
//     //                                     border:
//     //                                         Border.all(color: Colors.black)),
//     //                                 child: const Padding(
//     //                                   padding: EdgeInsets.symmetric(
//     //                                       horizontal: 16, vertical: 8),
//     //                                   child: Text(
//     //                                     "Mặt bằng Nguyễn Công Trứ High Land Huê",
//     //                                     overflow: TextOverflow.ellipsis,
//     //                                   ),
//     //                                 ),
//     //                               ))
//     //                         ],
//     //                       ),
//     //                       const SizedBox(
//     //                         height: 8,
//     //                       ),
//     //                       Row(
//     //                         mainAxisAlignment: MainAxisAlignment.end,
//     //                         children: [
//     //                           const Expanded(flex: 7, child: SizedBox()),
//     //                           Expanded(
//     //                             child: Text("Hủy",
//     //                                 style: TxtStyle.heading3.copyWith(
//     //                                   color: AppColor.primaryColor,
//     //                                 )),
//     //                           ),
//     //                           const Expanded(child: SizedBox()),
//     //                           Expanded(
//     //                             child: Text("Tạo",
//     //                                 style: TxtStyle.heading3.copyWith(
//     //                                   color: AppColor.primaryColor,
//     //                                 )),
//     //                           ),
//     //                         ],
//     //                       )
//     //                     ],
//     //                   ),
//     //                 ),
//     //               ),
//     //               InkWell(
//     //                 onTap: () => Navigator.push(
//     //                   context,
//     //                   MaterialPageRoute(
//     //                       builder: (context) => const MissionPageEX()),
//     //                 ),
//     //                 child: const SizedBox(
//     //                   height: 200,
//     //                   width: 200,
//     //                 ),
//     //               ),
//     //               const ChooseAddressPage(),
//     //               TextFormField(
//     //                 cursorColor: AppColor.secondColor,
//     //                 style: TxtStyle.heading5Blue
//     //                     .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
//     //                 decoration: InputDecoration(
//     //                   label: RichText(
//     //                     text: TextSpan(
//     //                         text: "name",
//     //                         style: TxtStyle.heading3.copyWith(
//     //                             color: AppColor.textColor,
//     //                             fontSize: 16,
//     //                             fontWeight: FontWeight.bold),
//     //                         children: [
//     //                           TextSpan(
//     //                             text: ' *',
//     //                             style: TxtStyle.heading3.copyWith(
//     //                                 color: Colors.red,
//     //                                 fontSize: 16,
//     //                                 fontWeight: FontWeight.bold),
//     //                           ),
//     //                         ]),
//     //                   ),
//     //                   labelStyle: TxtStyle.heading3.copyWith(
//     //                       color: AppColor.textColor,
//     //                       fontSize: 14,
//     //                       fontWeight: FontWeight.bold),
//     //                   border: OutlineInputBorder(
//     //                     borderRadius:
//     //                         const BorderRadius.all(Radius.circular(10)),
//     //                     borderSide: BorderSide(color: AppColor.boderColor),
//     //                   ),
//     //                   focusedBorder: OutlineInputBorder(
//     //                     borderSide: const BorderSide(
//     //                       color: AppColor.primaryColor,
//     //                     ),
//     //                     borderRadius: BorderRadius.circular(10.0),
//     //                   ),
//     //                 ),
//     //                 autocorrect: true,
//     //                 autovalidateMode: AutovalidateMode.onUserInteraction,
//     //                 validator: (value) {
//     //                   return value!.length < 6 ? "không được để trống." : null;
//     //                 },
//     //               ),
//     //               DropdownButton<String>(
//     //                   value: selectedItem,
//     //                   hint: const Text("SELECT WORKSPACE"),
//     //                   items: items
//     //                       .map(
//     //                         (item) => DropdownMenuItem<String>(
//     //                             value: item,
//     //                             child: Text(
//     //                               item,
//     //                               style: const TextStyle(fontSize: 50),
//     //                             )),
//     //                       )
//     //                       .toList(),
//     //                   onChanged: (item) => setState(() {
//     //                         selectedItem = item;
//     //                       })),

//     //               GestureDetector(
//     //                   onTap: () {
//     //                     showModalBottomSheet(
//     //                       context: context,
//     //                       builder: (context) => Wrap(
//     //                         children: const [
//     //                           // L
//     //                         ],
//     //                       ),
//     //                     );
//     //                   },
//     //                   child: const SizedBox(height: 250, width: 250))
//     //             ],
//     //           ),
//     //         ),

//     // );
//     return Scaffold(
//       body: SafeArea(
//           child: Column(
//         children: [
//           HtmlEditor(
//             controller: controller, //required
//             htmlEditorOptions: const HtmlEditorOptions(
//                 // shouldEnsureVisible: true,

//                 // autoAdjustHeight: false,
//                 // hint: "Type you Text here",
//                 // characterLimit: 1000
// // spellCheck:
//                 // mobileInitialScripts:
//                 // spellCheck: false
//                 ),
//             htmlToolbarOptions: const HtmlToolbarOptions(
//               // initiallyExpanded: true,
//               defaultToolbarButtons: [
//                 // StyleButtons(),
//                 // FontSettingButtons(),
//                 // ColorButtons(),
//                 // ListButtons(),
//                 // InsertButtons(),
//                 FontButtons(
//                   clearAll: false,
//                   strikethrough: false,
//                   superscript: false,
//                   subscript: false,
//                 ),
//                 ParagraphButtons(
//                   increaseIndent: false,
//                   decreaseIndent: false,
//                   textDirection: false,
//                   lineHeight: false,
//                   caseConverter: false,
//                 )
//               ],
//               toolbarType: ToolbarType.nativeScrollable,
//             ),
//             otherOptions: const OtherOptions(
//                 height: 500,
//                 // height: 290,
//                 decoration: BoxDecoration(
//                   // color: Colors.transparent,
//                   border: Border.fromBorderSide(
//                       BorderSide(color: Colors.white, width: 0)),
//                   borderRadius: BorderRadius.all(Radius.circular(0)),
//                   // border:
//                   //     Border.fromBorderSide(BorderSide(color: Color(0xffececec), width: 1)),
//                 )),
//           ),
//           // Row(
//           //   children: [
//           //     Expanded(
//           //       child: TextFormField(
//           //         controller: _searchController,
//           //       ),
//           //     ),
//           //     IconButton(
//           //         onPressed: () {
//           //           final des = _searchController.text;
//           //           final user = Userrr(
//           //               id: 2,
//           //               title: '34',
//           //               description: des,
//           //               onDatetime: Timestamp.fromDate(DateTime.now()),
//           //               brandId: 1,
//           //               brokerId: 1,
//           //               propertyId: 1,
//           //               type: 2,
//           //               status: 2);
//           //           createUser(user: user);
//           //         },
//           //         icon: const Icon(Icons.abc))
//           //   ],
//           // ),
//           // // SizedBox(
//           //   height: 250,
//           //   child: StreamBuilder<List<Userrr>>(
//           //     stream: readUser(),
//           //     builder: (context, snapshot) {
//           //       if (snapshot.hasError) {
//           //         return const Text("Something went wrong");
//           //       }
//           //       if (snapshot.connectionState == ConnectionState.waiting) {
//           //         return const Text("Loading");
//           //       }
//           //       if (snapshot.hasData) {
//           //         final data = snapshot.data;
//           //         return ListView.builder(
//           //           itemCount: data!.length,
//           //           itemBuilder: (context, index) {
//           //             return Text(data[index].description);
//           //           },
//           //         );
//           //       }
//           //       return const SizedBox();
//           //     },
//           //   ),
//           // )
//         ],
//       )),
//     );
//   }

//   Future createUser({required Userrr user}) async {
//     final noti = FirebaseFirestore.instance.collection("notification").doc();
//     print(FirebaseFirestore.instance.collection("notification").doc().id);
//     // final json = {
//     //   'description': des,
//     //   "refId": 2,
//     //   "title": "hi",
//     //   "status": 2,
//     //   "type": 2
//     // };

//     final json = user.toJson();

//     await noti.set(json);
//   }

//   Future<dynamic> getDistrictMethod(
//       BuildContext context, StateSetter setState1) {
//     return showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (context) {
//           return DraggableScrollableSheet(
//             expand: false,
//             builder: (context, scrollController) => Column(
//               children: [
//                 Container(
//                   color: AppColor.boderColor,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           icon: const Icon(Icons.close)),
//                       Text(
//                         "Chọn quận, huyện, thị xã",
//                         style: TxtStyle.heading4
//                             .copyWith(fontWeight: FontWeight.bold),
//                       ),
//                       const IconButton(
//                           onPressed: null,
//                           icon: Icon(
//                             Icons.close,
//                             color: Colors.transparent,
//                           )),
//                     ],
//                   ),
//                 ),
//                 // const SearchBarBrand(title: "Nhập từ khóa để lọc"),
//                 BlocConsumer<DistrictBloc, DistrictState>(
//                   listener: (context, state) {
//                     if (state is DistrictError) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("DistrictError")));
//                     }
//                   },
//                   builder: (context, state) {
//                     if (state is DistrictLoading) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                     if (state is DistrictLoaded) {
//                       return Expanded(
//                         child: ListView.builder(
//                             // physics: const NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: state.districts.length,
//                             controller: scrollController,
//                             itemBuilder: (context, index) {
//                               return InkWell(
//                                 onTap: () {
//                                   setState1(() {
//                                     isDistrict = true;
//                                     district = state.districts[index].name!;
//                                   });
//                                   wardBloc = context.read<WardBloc>()
//                                     ..add(GetWardByDistrictIdRequested(
//                                         state.districts[index].id!));
//                                   Navigator.of(context).pop();
//                                   getWardMethod(context, setState1);
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       border: Border(
//                                     top: BorderSide(
//                                       color: AppColor.boderColor,
//                                       width: 1,
//                                     ),
//                                     bottom: BorderSide(
//                                       color: AppColor.boderColor,
//                                       width: 1,
//                                     ),
//                                   )),
//                                   child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 16,
//                                         vertical: 8,
//                                       ),
//                                       child: Text(
//                                         state.districts[index].name.toString(),
//                                         style: TxtStyle.heading4,
//                                       )),
//                                 ),
//                               );
//                             }),
//                       );
//                     } else {
//                       return Text("$state");
//                     }
//                   },
//                 )
//               ],
//             ),
//           );
//         });
//   }

//   Future<dynamic> getWardMethod(BuildContext context, StateSetter setState1) {
//     return showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         builder: (context) {
//           //scroll listview in showModalBottomSheet
//           return DraggableScrollableSheet(
//             expand: false,
//             builder: (context, scrollController) => Column(
//               children: [
//                 Container(
//                   color: AppColor.boderColor,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           icon: const Icon(Icons.close)),
//                       Text(
//                         "Chọn phường, xã, thị trấn",
//                         style: TxtStyle.heading4
//                             .copyWith(fontWeight: FontWeight.bold),
//                       ),
//                       const IconButton(
//                           onPressed: null,
//                           icon: Icon(
//                             Icons.close,
//                             color: Colors.transparent,
//                           )),
//                     ],
//                   ),
//                 ),
//                 // const SearchBarBrand(title: "Nhập từ khóa để lọc"),
//                 BlocConsumer<WardBloc, WardState>(
//                   listener: (context, state) {
//                     if (state is WardError) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("WardError")));
//                     }
//                   },
//                   builder: (context, state) {
//                     if (state is WardLoading) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                     if (state is WardLoaded) {
//                       return Expanded(
//                         child: ListView.builder(
//                             // physics: const NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: state.ward.length,
//                             itemBuilder: (context, index) {
//                               return InkWell(
//                                 onTap: () {
//                                   setState1(() {
//                                     isWard = true;
//                                     ward = state.ward[index].name!;
//                                   });
//                                   Navigator.of(context).pop();
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       border: Border(
//                                     top: BorderSide(
//                                       color: AppColor.boderColor,
//                                       width: 1,
//                                     ),
//                                     bottom: BorderSide(
//                                       color: AppColor.boderColor,
//                                       width: 1,
//                                     ),
//                                   )),
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 16,
//                                       vertical: 8,
//                                     ),
//                                     child: Text(
//                                       state.ward[index].name.toString(),
//                                       style: TxtStyle.heading4,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }),
//                       );
//                     } else {
//                       return Text("$state");
//                     }
//                   },
//                 )
//               ],
//             ),
//           );
//         });
//   }
// }

// class CustomTFFNoValid extends StatelessWidget {
//   const CustomTFFNoValid({
//     Key? key,
//     required TextEditingController textController,
//     required this.name,
//     required this.read,
//   })  : _textController = textController,
//         super(key: key);

//   final TextEditingController _textController;
//   final String name;
//   final bool read;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 58,
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//       decoration: BoxDecoration(
//         border: Border.all(width: 2, color: AppColor.boderColor),
//         borderRadius: const BorderRadius.all(
//           Radius.circular(10),
//         ),
//       ),
//       child: TextFormField(
//         readOnly: read,
//         controller: _textController,
//         cursorColor: AppColor.secondColor,
//         style: TxtStyle.heading5Blue.copyWith(
//           fontWeight: FontWeight.normal,
//           fontSize: 14,
//         ),
//         decoration: (_textController.text != "")
//             ? InputDecoration(
//                 focusColor: AppColor.secondColor,
//                 labelText: name,
//                 labelStyle: TxtStyle.heading3.copyWith(
//                   color: AppColor.textColor,
//                   fontWeight: FontWeight.bold,
//                   height: 0.5,
//                 ),
//                 border: InputBorder.none)
//             : InputDecoration(
//                 focusColor: AppColor.secondColor,
//                 labelText: name,
//                 labelStyle: TxtStyle.heading5Blue.copyWith(
//                     color: AppColor.textColor, fontWeight: FontWeight.bold),
//                 border: InputBorder.none),
//       ),
//     );
//   }
// }

// class ChooseTextFromDrop extends StatelessWidget {
//   const ChooseTextFromDrop({
//     Key? key,
//     required this.name,
//     required this.lable,
//   }) : super(key: key);

//   final String name;
//   final String lable;

//   @override
//   Widget build(BuildContext context) {
//     return ContainerBoder(
//         boder: 10,
//         width: 2,
//         colorWidth: AppColor.boderColor,
//         child: SizedBox(
//             height: 58,
//             width: AppFormat.width(context),
//             child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 12),
//                   child: (name != lable)
//                       ? Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             RichText(
//                               text: TextSpan(
//                                   text: lable,
//                                   style: TxtStyle.heading5Blue.copyWith(
//                                       color: AppColor.textColor,
//                                       fontWeight: FontWeight.bold),
//                                   children: [
//                                     TextSpan(
//                                       text: ' *',
//                                       style: TxtStyle.heading5Blue.copyWith(
//                                           color: Colors.red,
//                                           fontWeight: FontWeight.bold),
//                                     )
//                                   ]),
//                             ),
//                             const SizedBox(
//                               height: 2,
//                             ),
//                             Text(
//                               name.trim(),
//                               style: TxtStyle.heading5Gray.copyWith(
//                                   fontSize: 14, color: AppColor.secondColor),
//                             ),
//                           ],
//                         )
//                       : RichText(
//                           text: TextSpan(
//                               text: lable,
//                               style: TxtStyle.heading5Blue.copyWith(
//                                   color: AppColor.textColor,
//                                   fontWeight: FontWeight.bold),
//                               children: [
//                                 TextSpan(
//                                   text: ' *',
//                                   style: TxtStyle.heading5Blue.copyWith(
//                                       color: Colors.red,
//                                       fontWeight: FontWeight.bold),
//                                 )
//                               ]),
//                         ),
//                 ))));
//   }
// }

// class ImageDialog extends StatelessWidget {
//   const ImageDialog({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: CachedNetworkImage(
//         imageUrl:
//             "https://static.wikia.nocookie.net/p__/images/9/9b/Toshiro-hitsugaya-render.png/revision/latest?cb=20140314190142&path-prefix=protagonist",
//         imageBuilder: (context, imageProvider) => Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: imageProvider,
//                 fit: BoxFit.cover,
//                 colorFilter:
//                     const ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
//           ),
//         ),
//         placeholder: (context, url) => const CircularProgressIndicator(),
//         errorWidget: (context, url, error) => const Icon(Icons.error),
//       ),
//     );
//   }
// }

// class Userrr extends Equatable {
//   final String? body;
//   final String? title;
//   final num? type;
//   final num? brandId;
//   final num? brokerId;
//   final num? propertyId;
//   final num? teamId;
//   final num? appointmentId;
//   final num? contractId;
//   final Timestamp onDatetime;

//   const Userrr({
//     this.title,
//     this.teamId,
//     this.body,
//     this.brandId,
//     this.appointmentId,
//     this.contractId,
//     this.brokerId,
//     this.propertyId,
//     required this.onDatetime,
//     this.type,
//   });

//   @override
//   List<Object?> get props => [
//         title,
//         body,
//         type,
//         onDatetime,
//         brandId,
//         brokerId,
//         propertyId,
//         appointmentId,
//         contractId,
//         teamId
//       ];

//   static Userrr fromJson(Map<String, dynamic> json) {
//     Userrr category = Userrr(
//         title: json["title"],
//         body: json["body"],
//         brandId: json["BrandId"],
//         brokerId: json["BrokerId"],
//         propertyId: json["PropertyId"],
//         onDatetime: json["OnDatetime"],
//         teamId: json["TeamId"],
//         appointmentId: json["AppointmentId"],
//         contractId: json["ContractId"],
//         type: json["Type"]);

//     return category;
//   }

//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "body": body,
//         "Type": type,
//         "BrandId": brandId,
//         "BrokerId": brokerId,
//         "PropertyId": propertyId,
//         "OnDatetime": onDatetime,
//         "TeamId": teamId,
//         "AppointmentId": appointmentId,
//         "ContractId": contractId,
//       };

//   // static List<Category> categories = const [
//   //   Category(
//   //       name: "Soft Drink",
//   //       imageUrl:
//   //           "https://static.wikia.nocookie.net/bleach/images/1/16/Hitsugayatoshiro.png/revision/latest?cb=20111020043210&path-prefix=vi"),
//   //   Category(
//   //       name: "Smoothies",
//   //       imageUrl:
//   //           "https://cdna.artstation.com/p/assets/images/images/030/500/198/large/imanol-ramos-toshiro-hitsugaya.jpg?1600794550"),
//   //   Category(
//   //       name: "Water",
//   //       imageUrl: "https://i.ytimg.com/vi/M4rmY_r4fB8/maxresdefault.jpg"),
//   // ];
// }
