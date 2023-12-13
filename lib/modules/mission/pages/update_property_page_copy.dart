// import 'dart:convert';
// import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:crel_mobile/common/widgets/stateful/custom_nav_bar.dart';
// import 'package:crel_mobile/config/app_format.dart';
// import 'package:crel_mobile/config/configs.dart';
// import 'package:crel_mobile/models/models.dart';
// import 'package:crel_mobile/models/project.dart';
// import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
// import 'package:crel_mobile/modules/mission/blocs/location/location_bloc.dart';
// import 'package:crel_mobile/modules/mission/blocs/project/project_bloc.dart';
// import 'package:crel_mobile/modules/mission/widgets/choose_text_from_drop.dart';
// import 'package:crel_mobile/modules/mission/widgets/choose_text_from_drop_no_required.dart';
// import 'package:crel_mobile/modules/mission/widgets/custom_tff_no_valid.dart';
// import 'package:crel_mobile/modules/mission/widgets/custom_tff_required.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;
// import 'package:image_picker/image_picker.dart';
// import 'package:delta_markdown/delta_markdown.dart' as delta_markdown;
// import 'package:html2md/html2md.dart' as html2md;

// class UpdatePropetyPageCopy extends StatefulWidget {
//   final Property property;

//   const UpdatePropetyPageCopy({Key? key, required this.property})
//       : super(key: key);

//   @override
//   State<UpdatePropetyPageCopy> createState() => _UpdatePropetyPageCopyState();
// }

// class _UpdatePropetyPageCopyState extends State<UpdatePropetyPageCopy> {
//   final _formKey = GlobalKey<FormState>();
//   final _locationIdController = TextEditingController();
//   final _brokerIdController = TextEditingController();
//   final _statusController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   // final _descriptionController1 = quill.QuillController;
//   // final _descriptionController2 = quill.QuillController() ;
//   final _tagController = TextEditingController();
//   final _typeController = TextEditingController();
//   final _nameController = TextEditingController();
//   final _projectIdController = TextEditingController();
//   final _landAreaController = TextEditingController();
//   final _floorController = TextEditingController();
//   final _floorAreaController = TextEditingController();
//   final _frontageController = TextEditingController();
//   final _parkingLotController = TextEditingController();
//   final _certificatesController = TextEditingController();
//   final _verticalController = TextEditingController();
//   final _horizontalController = TextEditingController();
//   final _roadWidthController = TextEditingController();
//   final _searchController = TextEditingController();
//   final quill.QuillController _controller = quill.QuillController.basic();

//   File? image;
//   List<XFile> listImage = [];
//   List<Media> medias = [];
//   late LocationBloc locationBloc;
//   late ProjectBloc projectBloc;
//   String projecName = "Dự án";
//   String nameProject = "Dự án";
//   int? projectId;
//   List<Project> listProject = [];

//   Future getImage() async {
//     final pickedFile = await ImagePicker().pickMultiImage();
//     setState(() {
//       if (pickedFile != null) {
//         for (var element in pickedFile) {
//           listImage.insert(0, element);
//         }
//         print("sadasd");
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   List<Widget> listchoseImage() {
//     List<Widget> widgetImage = [];
//     // widgetImage.add(
//     //   InkWell(
//     //     onTap: () => getImage(),
//     //     child: Padding(
//     //       padding: const EdgeInsets.all(16),
//     //       child: DottedBorder(
//     //         radius: const Radius.circular(10),
//     //         borderType: BorderType.RRect,
//     //         color: AppColor.primaryColor,
//     //         strokeWidth: 2,
//     //         dashPattern: const [16, 8],
//     //         child: Container(
//     //             height:
//     //                 AppFormat.heightWithoutAppBarAndStatusbar(context) * 0.12,
//     //             width:
//     //                 AppFormat.heightWithoutAppBarAndStatusbar(context) * 0.13,
//     //             decoration: BoxDecoration(
//     //               borderRadius: BorderRadius.circular(10),
//     //               color: AppColor.cardColor,
//     //             ),
//     //             child: Padding(
//     //               padding: const EdgeInsets.all(8.0),
//     //               child: Column(
//     //                 mainAxisAlignment: MainAxisAlignment.center,
//     //                 crossAxisAlignment: CrossAxisAlignment.center,
//     //                 children: [
//     //                   const Icon(
//     //                     Icons.camera_alt_rounded,
//     //                     size: 32,
//     //                   ),
//     //                   Text(
//     //                     "Thêm hình",
//     //                     style: TxtStyle.heading4.copyWith(
//     //                       fontWeight: FontWeight.bold,
//     //                     ),
//     //                   )
//     //                 ],
//     //               ),
//     //             )),
//     //       ),
//     //     ),
//     //   ),
//     // );
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
//                 icon: const Icon(Icons.cancel)),
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
//               // showGeneralDialog(
//               //   context: context,
//               //   barrierDismissible: true,
//               //   barrierLabel:
//               //       MaterialLocalizations.of(context).modalBarrierDismissLabel,
//               //   pageBuilder: (context, animation, secondaryAnimation) {
//               //     return Center(
//               //       child: Container(
//               //         width: MediaQuery.of(context).size.width,
//               //         height: MediaQuery.of(context).size.height,
//               //         color: Colors.black,
//               //         child: Padding(
//               //           padding: const EdgeInsets.all(12.0),
//               //           child: Column(
//               //             mainAxisAlignment: MainAxisAlignment.center,
//               //             crossAxisAlignment: CrossAxisAlignment.start,
//               //             children: [
//               //               const TextField(
//               //                 decoration: InputDecoration(
//               //                     border: InputBorder.none,
//               //                     hintText: 'What do you want to remember?'),
//               //               ),
//               //               SizedBox(
//               //                 width: 320.0,
//               //                 child: ElevatedButton(
//               //                   onPressed: () {},
//               //                   child: const Text(
//               //                     "Save",
//               //                     style: TextStyle(color: Colors.white),
//               //                   ),
//               //                   // color: const Color(0xFF1BC0C5),
//               //                 ),
//               //               )
//               //             ],
//               //           ),
//               //         ),
//               //       ),
//               //     );
//               //   },
//               // );
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
//                 icon: const Icon(Icons.cancel)),
//           ),
//         ],
//       ));
//     }
//     return widgetImage;
//   }

//   @override
//   void initState() {
//     // _controller =
//     //     widget.property.htmlToQuillController(widget.property.description!);

//     locationBloc = context.read<LocationBloc>()
//       ..add(GetLocationByIdRequested(widget.property.locationId!));
//     projectBloc = context.read<ProjectBloc>()
//       ..add(GetProjectByIdRequested(widget.property.projectId!));
//     medias.addAll(widget.property.media!);
//     _locationIdController.text = widget.property.locationId == null
//         ? "0"
//         : widget.property.locationId!.toString();
//     _brokerIdController.text = widget.property.brokerId!.toString();
//     _statusController.text = widget.property.status!.toString();
//     _priceController.text =
//         widget.property.price == null ? "0" : widget.property.price!.toString();
//     _descriptionController.text = widget.property.description == null
//         ? ""
//         : widget.property.description!.toString();
//     // _tagController.text = widget.property.tag!.toString() ;
//     _typeController.text =
//         widget.property.type == null ? "0" : widget.property.type!.toString();
//     _nameController.text =
//         widget.property.name == null ? "" : widget.property.name.toString();
//     _projectIdController.text = widget.property.projectId == null
//         ? "0"
//         : widget.property.projectId!.toString();
//     _landAreaController.text = widget.property.landArea == null
//         ? "0"
//         : widget.property.landArea!.toString();
//     _floorController.text =
//         widget.property.floor == null ? "" : widget.property.floor!.toString();
//     _floorAreaController.text = widget.property.floorArea == null
//         ? "0"
//         : widget.property.floorArea!.toString();
//     _frontageController.text = widget.property.frontage == null
//         ? "0"
//         : widget.property.frontage!.toString();
//     _parkingLotController.text = widget.property.parkingLot == null
//         ? "0"
//         : widget.property.parkingLot!.toString();
//     _certificatesController.text = widget.property.certificates == null
//         ? "0"
//         : widget.property.certificates!.toString();
//     _verticalController.text = widget.property.vertical == null
//         ? "0"
//         : widget.property.vertical!.toString();
//     _horizontalController.text = widget.property.horizontal == null
//         ? "0"
//         : widget.property.horizontal!.toString();
//     _roadWidthController.text = widget.property.roadWidth == null
//         ? "0"
//         : widget.property.roadWidth!.toString();
//     _searchController.text = "";
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _locationIdController.dispose();
//     _brokerIdController.dispose();
//     _statusController.dispose();
//     _priceController.dispose();
//     _descriptionController.dispose();
//     _tagController.dispose();
//     _typeController.dispose();
//     _nameController.dispose();
//     _projectIdController.dispose();
//     _landAreaController.dispose();
//     _searchController.dispose();
//     _floorController.dispose();
//     _floorAreaController.dispose();
//     _frontageController.dispose();
//     _parkingLotController.dispose();
//     _certificatesController.dispose();
//     _verticalController.dispose();
//     _horizontalController.dispose();
//     _roadWidthController.dispose();
//     super.dispose();
//   }

//   // String quillDeltaToHtml(quill.Delta delta) {
//   //   final convertedValue = jsonEncode(delta.toJson());
//   //   const deltaa =
//   //       '[{"insert":"Hello "},{"insert":"Markdown","attributes":{"bold":true}},{"insert":"\n"}]';
//   //   final markdown = delta_markdown.deltaToMarkdown(deltaa);

//   //   final html = mark_down.markdownToHtml(markdown);

//   //   return html;
//   // }

//   String htmlToQuillController(String html) {
//     final markdown = html2md.convert(html);
//     final delta = delta_markdown.markdownToDelta(markdown);

//     return delta;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//       child: Scaffold(
//           appBar: AppBar(
//             title: const Text("Cập nhật mặt bằng"),
//             backgroundColor: AppColor.primaryColor,
//           ),
//           body: SafeArea(
//               child: SingleChildScrollView(
//             // reverse: true,
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: AppFormat.width(context),
//                     color: AppColor.boderColor,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       child: Text(
//                         "ĐỊA CHỈ BĐS VÀ HÌNH ẢNH",
//                         style: TxtStyle.heading5Blue.copyWith(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   BlocConsumer<ProjectBloc, ProjectState>(
//                     listener: (context, state) {
//                       if (state is ProjectError) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text("ProjectError")));
//                       }
//                     },
//                     builder: (context, state) {
//                       if (state is ProjectLoading) {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                       if (state is ProjectLoaded) {
//                         return Padding(
//                           padding: const EdgeInsets.only(
//                               top: 16, bottom: 8, left: 16, right: 16),
//                           child: InkWell(
//                             onTap: () async {
//                               setState(() {
//                                 listProject = state.projects;
//                               });
//                               projecName =
//                                   await (chooseProject(context, state)) ??
//                                       projecName;
//                             },
//                             child: ChooseTextFromDropNoRequired(
//                                 name: nameProject == projecName
//                                     ? _projectIdController.text =
//                                         state.project.name!
//                                     : _projectIdController.text = projecName,
//                                 lable: nameProject),
//                           ),
//                         );
//                       }
//                       return Text("$state");
//                     },
//                   ),

//                   const SizedBox(
//                     height: 8,
//                   ),
//                   BlocConsumer<LocationBloc, LocationState>(
//                     listener: (context, state) {
//                       if (state is LocationError) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text("LocationError")));
//                       }
//                     },
//                     builder: (context, state) {
//                       if (state is LocationLoading) {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                       if (state is LocationLoaded) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: ChooseTextFromDrop(
//                               name: _locationIdController.text =
//                                   state.location.address!,
//                               lable: "Địa chỉ"),
//                         );
//                       }
//                       return Text("$state");
//                     },
//                   ),
//                   (widget.property.media!.isEmpty && listImage.isEmpty)
//                       ? InkWell(
//                           onTap: () => getImage(),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16),
//                             child: DottedBorder(
//                               radius: const Radius.circular(10),
//                               borderType: BorderType.RRect,
//                               color: AppColor.primaryColor,
//                               strokeWidth: 2,
//                               dashPattern: const [16, 8],
//                               child: Container(
//                                   height:
//                                       AppFormat.heightWithoutAppBarAndStatusbar(
//                                               context) *
//                                           0.12,
//                                   width: AppFormat.width(context),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: AppColor.cardColor,
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         const Icon(
//                                           Icons.camera_alt_rounded,
//                                           size: 46,
//                                         ),
//                                         Text(
//                                           "Chọn từ 03 đến 10 hình",
//                                           style: TxtStyle.heading4.copyWith(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   )),
//                             ),
//                           ),
//                         )
//                       : Row(
//                           children: [
//                             InkWell(
//                               onTap: () => getImage(),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16),
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
//                                       width: AppFormat
//                                               .heightWithoutAppBarAndStatusbar(
//                                                   context) *
//                                           0.13,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: AppColor.cardColor,
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             const Icon(
//                                               Icons.camera_alt_rounded,
//                                               size: 32,
//                                             ),
//                                             Text(
//                                               "Thêm hình",
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
//                             Expanded(
//                               child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: Row(children: listchoseImage()),
//                               ),
//                             ),
//                           ],
//                         ),

//                   Container(
//                     width: AppFormat.width(context),
//                     color: AppColor.boderColor,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       child: Text(
//                         "VỊ TRÍ BẤT ĐỘNG SẢN",
//                         style: TxtStyle.heading5Blue.copyWith(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: CustomTFFNoValid(
//                         type: TextInputType.name,
//                         textController: _floorController,
//                         name: "Tầng"),
//                   ),
//                   Container(
//                     width: AppFormat.width(context),
//                     color: AppColor.boderColor,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       child: Text(
//                         "DIỆN TÍCH VÀ GIÁ",
//                         style: TxtStyle.heading5Blue.copyWith(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 16),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 16),
//                           child: CustomTFFRequired(
//                               type: TextInputType.number,
//                               textController: _verticalController,
//                               name: "Chiều ngang"),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 16),
//                           child: CustomTFFRequired(
//                               type: TextInputType.number,
//                               textController: _horizontalController,
//                               name: "Chiều dọc"),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 16),
//                           child: CustomTFFRequired(
//                               type: TextInputType.number,
//                               textController: _roadWidthController,
//                               name: "Lộ giới"),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 16),
//                           child: CustomTFFRequired(
//                               type: TextInputType.number,
//                               textController: _frontageController,
//                               name: "Mặt tiền"),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 16),
//                           child: CustomTFFRequired(
//                               type: TextInputType.name,
//                               textController: _parkingLotController,
//                               name: "Bãi đỗ xe"),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 16),
//                           child: CustomTFFRequired(
//                               type: TextInputType.number,
//                               textController: _floorAreaController,
//                               name: "Diện tích sàn"),
//                         ),
//                         // Padding(
//                         //   padding: const EdgeInsets.only(bottom: 16),
//                         //   child: CustomTFFRequired(
//                         //       type: TextInputType.number,
//                         //       textController: _landAreaController,
//                         //       name: "landArea"),
//                         // ),
//                         CustomTFFRequired(
//                             type: TextInputType.number,
//                             textController: _priceController,
//                             name: "Giá"),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: AppFormat.width(context),
//                     color: AppColor.boderColor,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       child: Text(
//                         "TIÊU ĐỀ ĐĂNG TIN VÀ MÔ TẢ CHI TIẾT",
//                         style: TxtStyle.heading5Blue.copyWith(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 16),
//                     child: CustomTFFRequired(
//                       type: TextInputType.name,
//                       textController: _nameController,
//                       name: "Tiêu đề",
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 16, left: 16, right: 16),
//                     child: CustomTFFRequired(
//                         type: TextInputType.name,
//                         textController: _descriptionController,
//                         name: "Mô tả"),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 16, left: 16, right: 16),
//                     child: Container(
//                       padding: const EdgeInsets.only(left: 12, right: 12),
//                       decoration: BoxDecoration(
//                         border:
//                             Border.all(width: 2, color: AppColor.boderColor),
//                         borderRadius: const BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           RichText(
//                             text: TextSpan(
//                                 text: "Mô tả",
//                                 style: TxtStyle.heading4.copyWith(
//                                     color: AppColor.textColor,
//                                     fontWeight: FontWeight.bold),
//                                 children: [
//                                   TextSpan(
//                                     text: ' *',
//                                     style: TxtStyle.heading4.copyWith(
//                                         color: Colors.red,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ]),
//                           ),
//                           quill.QuillToolbar.basic(
//                             controller: _controller,
//                             // multiRowsDisplay: false,
//                             // showAlignmentButtons: false,
//                             // showCenterAlignment: false,
//                             // showBackgroundColorButton: false,
//                             // showAlignmentButtons: true,
//                             // showClearFormat: false,
//                             showBackgroundColorButton: false,
//                             showColorButton: false,
//                             showClearFormat: false,
//                             showLink: false,
//                             showFontFamily: false,
//                             showIndent: false,
//                             showAlignmentButtons: true,
//                             // showCenterAlignment: true,
//                             toolbarIconSize: 16,
//                             showListBullets: false,
//                             showListNumbers: false,
//                             showSmallButton: false,
//                             showFontSize: false,
//                             showCodeBlock: false,
//                             showDirection: false,
//                             showDividers: false,
//                             showHeaderStyle: false,
//                             showInlineCode: false,
//                             showListCheck: false,
//                             showQuote: false,
//                             showSearchButton: false,
//                           ),
//                           Container(
//                             height: 200,
//                             decoration: BoxDecoration(
//                               // color: Colors.white,
//                               borderRadius: BorderRadius.circular(12.5),
//                               boxShadow: [
//                                 BoxShadow(
//                                     offset: const Offset(10, 20),
//                                     blurRadius: 10,
//                                     spreadRadius: 0,
//                                     color: Colors.grey.withOpacity(.05)),
//                               ],
//                             ),
//                             child: quill.QuillEditor.basic(
//                               controller: _controller,

//                               readOnly: false, // true for view only mode
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: AppFormat.width(context),
//                     color: AppColor.boderColor,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 8),
//                       child: Text(
//                         "VỀ NGƯỜI BÁN",
//                         style: TxtStyle.heading5Blue.copyWith(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   // CustomTFFUpdateValidEmpty(
//                   // textController: _tagController, name: "Th"),
//                   // CustomTFFUpdateValidEmpty(
//                   // textController: _typeController, name: "type"),

//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: 16, right: 16, bottom: 16, top: 16),
//                     child: CustomTFFNoValid(
//                         type: TextInputType.name,
//                         textController: _certificatesController,
//                         name: "Giấy tờ pháp lý"),
//                   ),
//                   // const ChooseAddressPage(),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: SizedBox(
//                       width: AppFormat.width(context),
//                       child: ElevatedButton(
//                         style: TxtStyle.buttonBlue,
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             var json = jsonEncode(
//                                 _controller.document.toDelta().toJson());
//                             // var a = _controller.document.toDelta().toString();
//                             BlocProvider.of<PropertyForRentBloc>(context)
//                                 .add(UpdateProperty(
//                                     Property(
//                                       id: widget.property.id,
//                                       locationId: widget.property.locationId,
//                                       brokerId: widget.property.brokerId,
//                                       createDate: widget.property.createDate,
//                                       lastUpdateDate: DateTime.now(),
//                                       status: 2,
//                                       price: double.parse(
//                                           _priceController.text.trim()),
//                                       description: widget.property
//                                           .quillDeltaToHtml(
//                                               _controller.document.toDelta()),

//                                       // jsonEncode(_controller
//                                       //     .document
//                                       //     .toDelta()
//                                       //     .toJson()),
//                                       tag: _tagController.text.trim(),
//                                       rejectReason:
//                                           widget.property.rejectReason,
//                                       type: int.parse(_typeController.text),
//                                       name: _nameController.text.trim(),
//                                       projectId: projectId ??
//                                           widget.property.projectId,
//                                       landArea: double.parse(
//                                           _landAreaController.text),
//                                       floor: _floorController.text,
//                                       floorArea: double.parse(
//                                           _floorAreaController.text),
//                                       frontage: double.parse(
//                                           _frontageController.text),
//                                       parkingLot:
//                                           int.parse(_parkingLotController.text),
//                                       certificates: int.parse(
//                                           _certificatesController.text),
//                                       vertical: double.parse(
//                                           _verticalController.text),
//                                       horizontal: double.parse(
//                                           _horizontalController.text),
//                                       roadWidth: double.parse(
//                                           _roadWidthController.text),
//                                     ),
//                                     listImage,
//                                     medias,
//                                     widget.property.media));

//                             // if (image != null) {

//                             // Future.delayed(const Duration(seconds: 3));
//                             // BlocProvider.of<PropertyForRentBloc>(context).add(
//                             //     GetPropertyForRentByIdRequested(
//                             //         widget.property.id!));
//                             // Navigator.pop(context);
//                             Navigator.of(context).pushAndRemoveUntil(
//                               MaterialPageRoute(
//                                   builder: (context) => const CustomNavBar()),
//                               (route) => false,
//                             );
//                           }
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           child: Text(
//                             'Cập nhật mặt bằng',
//                             style:
//                                 TxtStyle.heading3.copyWith(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 16,
//                   )
//                 ],
//               ),
//             ),
//           ))
//           // ),
//           ),
//     );
//   }

//   Future<String?> chooseProject(BuildContext context, ProjectLoaded state) {
//     return showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(
//             builder: (context, setState1) => DraggableScrollableSheet(
//               expand: false,
//               builder: (context, scrollController) => Column(
//                 children: [
//                   Container(
//                     color: AppColor.boderColor,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         IconButton(
//                             onPressed: () {
//                               _searchController.clear();
//                               Navigator.of(context).pop();
//                             },
//                             icon: const Icon(Icons.close)),
//                         Text(
//                           "Nhập tên dự án",
//                           style: TxtStyle.heading4
//                               .copyWith(fontWeight: FontWeight.bold),
//                         ),
//                         const IconButton(
//                             onPressed: null,
//                             icon: Icon(
//                               Icons.close,
//                               color: Colors.transparent,
//                             )),
//                       ],
//                     ),
//                   ),
//                   // const SearchBarBrand(
//                   //     title: "Nhập từ khóa để lọc"),

//                   Container(
//                     height: 40,
//                     alignment: Alignment.centerLeft,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border:
//                             Border.all(width: 1, color: AppColor.boderColor)),
//                     child: TextField(
//                       onChanged: (value) {
//                         setState1(() {
//                           listProject = state.projects
//                               .where((projectName) => projectName.name!
//                                   .toLowerCase()
//                                   .contains(value.toLowerCase()))
//                               .toList();
//                         });
//                       },
//                       controller: _searchController,
//                       cursorColor: AppColor.secondColor,
//                       style: const TextStyle(color: AppColor.secondColor),
//                       decoration: const InputDecoration(
//                         isDense: true,
//                         border: InputBorder.none,
//                         hintText: "Nhập",
//                         hintStyle: TxtStyle.heading5Gray,
//                         prefixIcon: Icon(
//                           Icons.search,
//                           color: AppColor.textColor,
//                           size: 24,
//                         ),
//                       ),
//                     ),
//                   ),

//                   Expanded(
//                     child: ListView.builder(
//                         // physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: listProject.length,
//                         controller: scrollController,
//                         itemBuilder: (context, index) {
//                           return InkWell(
//                             onTap: () {
//                               setState(() {
//                                 projecName = listProject[index].name!;
//                                 projectId = listProject[index].id!;
//                                 _searchController.clear();
//                               });
//                               Navigator.pop(context, listProject[index].name!);
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   border: Border(
//                                 top: BorderSide(
//                                   color: AppColor.boderColor,
//                                   width: 1,
//                                 ),
//                                 bottom: BorderSide(
//                                   color: AppColor.boderColor,
//                                   width: 1,
//                                 ),
//                               )),
//                               child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 16,
//                                     vertical: 8,
//                                   ),
//                                   child: Text(
//                                     listProject[index].name.toString(),
//                                     style: TxtStyle.heading4,
//                                   )),
//                             ),
//                           );
//                         }),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
