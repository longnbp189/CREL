// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:crel_mobile/config/app_format.dart';
// import 'package:crel_mobile/config/configs.dart';
// import 'package:crel_mobile/models/models.dart';
// import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
// import 'package:crel_mobile/modules/home/pages/property_detail.dart';
// import 'package:crel_mobile/modules/home/widgets/search_bar_property.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class SuggestPropertyPage extends StatefulWidget {
//   const SuggestPropertyPage({Key? key}) : super(key: key);

//   @override
//   State<SuggestPropertyPage> createState() => _SuggestPropertyPageState();
// }

// class _SuggestPropertyPageState extends State<SuggestPropertyPage> {
//   final ScrollController _scrollController = ScrollController();
//   // late PropertyForRentBloc _propertyForRentBloc;
//   final TextEditingController _searchController = TextEditingController()
//     ..text = "";

//   @override
//   void initState() {
//     // if (widget.suggest != null) {
//     // suggestProperties = widget.suggest!;
//     // }
//     context
//         .read<PropertyForRentBloc>()
//         .add(const GetPropertyForRentRequested(2, "", true));
//     _scrollController.addListener(_onScroll);
//     _searchController.text = "";
//     FocusManager.instance.primaryFocus?.unfocus();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     // _searchController.clear();
//     super.dispose();
//   }

//   List<Property> suggestProperties = [];

//   List<Widget> listchoseProperty() {
//     List<Widget> widgetSuggestProperties = [];
//     for (var property in suggestProperties) {
//       widgetSuggestProperties.insert(
//           0,
//           Stack(
//             alignment: AlignmentDirectional.topEnd,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 8, right: 8),
//                 child: Container(
//                   width: 200,
//                   decoration: const BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColor.textColor,
//                         blurRadius: 7,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Card(
//                     color: AppColor.primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(10),
//                               topRight: Radius.circular(10)),
//                           child: CachedNetworkImage(
//                             height: AppFormat.height(context) / 8,
//                             width: AppFormat.width(context),
//                             fit: BoxFit.cover,
//                             imageUrl:
//                                 "https://www.savills.com.vn/_images/thaibuilding-20190911.jpg",
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(12),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 width: AppFormat.width(context),
//                                 child: Text(
//                                   property.name.toString(),
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 2,
//                                   style: TxtStyle.heading4.copyWith(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 8,
//                               ),
//                               Text(
//                                 property.location!.address.toString() +
//                                     ", " +
//                                     property.location!.ward!.name.toString() +
//                                     ", " +
//                                     property.location!.ward!.district!.name
//                                         .toString(),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TxtStyle.heading5Blue
//                                     .copyWith(color: Colors.white),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: -12,
//                 right: -10,
//                 child: IconButton(
//                     onPressed: () {
//                       setState(() {
//                         suggestProperties.remove(property);
//                       });
//                     },
//                     icon: const Icon(Icons.cancel)),
//               ),
//             ],
//           ));
//     }
//     return widgetSuggestProperties;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: BlocConsumer<PropertyForRentBloc, PropertyForRentState>(
//         listener: (context, state) {
//           if (state is PropertyForRentError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text("PropertyForRentError")));
//           }
//         },
//         builder: (context, state) {
//           if (state is PropertyForRentLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (state is PropertyForRentLoaded) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Padding(
//                     padding: EdgeInsets.only(bottom: 8, left: 16, right: 16),
//                     child: SearchBarProperty(
//                       title: "Nhập tên bất động sản mà bạn muốn tìm kiếm!",
//                     )),
//                 Expanded(
//                   child: RefreshIndicator(
//                     onRefresh: _onRefresh,
//                     child: ListView.builder(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         controller: _scrollController,
//                         // shrinkWrap: true,
//                         padding: const EdgeInsets.only(
//                             left: 16, right: 16, bottom: 16),
//                         itemCount: state.hasReachedMax
//                             ? state.propertyForRents.length
//                             : state.propertyForRents.length + 1,
//                         itemBuilder: (context, index) {
//                           if (index >= state.propertyForRents.length) {
//                             return (state.propertyForRents.length >= 3)
//                                 ? const Center(
//                                     child: CircularProgressIndicator())
//                                 : const SizedBox();
//                           } else {
//                             return InkWell(
//                                 onTap: () {
//                                   Navigator.of(context).push(
//                                     MaterialPageRoute<PropertyDetail>(
//                                       builder: (_) => BlocProvider.value(
//                                         value: BlocProvider.of<
//                                             PropertyForRentBloc>(context),
//                                         child: PropertyDetail(
//                                           propertyForRent:
//                                               state.propertyForRents[index],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                   // Navigator.pushNamed(context, AppRouter.propertyDetail,
//                                   //     arguments: state.propertyForRents[index]);
//                                 },
//                                 child: Stack(
//                                   children: [
//                                     // InkWell(
//                                     //     onTap: !suggestProperties.contains(
//                                     //             state.propertyForRents[index])
//                                     //         ? () {
//                                     //             setState(() {
//                                     //               suggestProperties.add(
//                                     //                   state.propertyForRents[
//                                     //                       index]);
//                                     //             });
//                                     //           }
//                                     //         : null,
//                                     //     child: FaIcon(
//                                     //       FontAwesomeIcons.addressBook,
//                                     //       color: !suggestProperties.contains(
//                                     //               state.propertyForRents[
//                                     //                   index])
//                                     //           ? AppColor.primaryColor
//                                     //           : AppColor.boderColor,
//                                     //     )),
//                                     // const SizedBox(
//                                     //   width: 8,
//                                     // ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(bottom: 8),
//                                       child: Container(
//                                         width: AppFormat.width(context),
//                                         decoration: const BoxDecoration(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(10)),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: AppColor.textColor,
//                                               blurRadius: 7,
//                                               offset: Offset(0, 3),
//                                             ),
//                                           ],
//                                           // boxShadow: [
//                                           //   BoxShadow(
//                                           //     color: AppColor.textColor,
//                                           //     blurRadius: 10,
//                                           //     offset: Offset(0.5, 0.5),
//                                           //   ),
//                                           // ],
//                                         ),
//                                         child: Card(
//                                           color: AppColor.primaryColor,
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                           ),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               ClipRRect(
//                                                 borderRadius:
//                                                     const BorderRadius.only(
//                                                         topLeft:
//                                                             Radius.circular(10),
//                                                         topRight:
//                                                             Radius.circular(
//                                                                 10)),
//                                                 child: CachedNetworkImage(
//                                                   height: AppFormat.height(
//                                                           context) /
//                                                       8,
//                                                   width:
//                                                       AppFormat.width(context),
//                                                   fit: BoxFit.cover,
//                                                   imageUrl:
//                                                       "https://www.savills.com.vn/_images/thaibuilding-20190911.jpg",
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(12),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     SizedBox(
//                                                       width: AppFormat.width(
//                                                           context),
//                                                       child: Text(
//                                                         state
//                                                             .propertyForRents[
//                                                                 index]
//                                                             .name
//                                                             .toString(),
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                         maxLines: 1,
//                                                         style: TxtStyle.heading3
//                                                             .copyWith(
//                                                                 color: Colors
//                                                                     .white),
//                                                       ),
//                                                     ),
//                                                     const SizedBox(
//                                                       height: 8,
//                                                     ),
//                                                     Text(
//                                                       state
//                                                               .propertyForRents[
//                                                                   index]
//                                                               .location!
//                                                               .address
//                                                               .toString() +
//                                                           ", " +
//                                                           state
//                                                               .propertyForRents[
//                                                                   index]
//                                                               .location!
//                                                               .ward!
//                                                               .name
//                                                               .toString() +
//                                                           ", " +
//                                                           state
//                                                               .propertyForRents[
//                                                                   index]
//                                                               .location!
//                                                               .ward!
//                                                               .district!
//                                                               .name
//                                                               .toString(),
//                                                       maxLines: 2,
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: TxtStyle
//                                                           .heading5Blue
//                                                           .copyWith(
//                                                               color:
//                                                                   Colors.white),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     (!suggestProperties
//                                             .where((element) =>
//                                                 element.id ==
//                                                 state
//                                                     .propertyForRents[index].id)
//                                             .toList()
//                                             .isNotEmpty)
//                                         // (suggestProperties.where((element) => element.id == state.propertyForRents[index].id,).first()!=null)
//                                         ? Positioned(
//                                             top: 10,
//                                             right: 10,
//                                             child: GestureDetector(
//                                                 onTap: () {
//                                                   setState(() {
//                                                     suggestProperties.add(
//                                                         state.propertyForRents[
//                                                             index]);
//                                                   });
//                                                 },
//                                                 child: const FaIcon(
//                                                     FontAwesomeIcons
//                                                         .addressBook,
//                                                     color:
//                                                         AppColor.primaryColor)),
//                                           )
//                                         : const SizedBox(),
//                                   ],
//                                 ));
//                           }
//                         }),
//                   ),
//                 ),
//                 suggestProperties.isNotEmpty
//                     ? Padding(
//                         padding: const EdgeInsets.only(
//                             right: 16, left: 16, bottom: 16),
//                         child: SizedBox(
//                           height: 235,
//                           child: Column(
//                             children: [
//                               Align(
//                                 alignment: Alignment.bottomLeft,
//                                 child: Text(
//                                   "Danh sách đề xuất:",
//                                   style: TxtStyle.heading3
//                                       .copyWith(fontWeight: FontWeight.normal),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 8,
//                               ),
//                               Expanded(
//                                 child: SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child:
//                                       // Text("á")

//                                       Row(children: listchoseProperty()),
//                                 ),
//                               ),
//                               // suggestProperties.isNotEmpty
//                               //     ? ListView.builder(
//                               //         itemCount: suggestProperties.length,
//                               //         itemBuilder: (context, index) {
//                               //           return const Text("data");
//                               //         },
//                               //       )
//                               //     : const SizedBox()
//                             ],
//                           ),
//                         ),
//                       )
//                     : const SizedBox()
//               ],
//             );
//           }
//           return Text("$state");
//         },
//       ),
//     ));
//   }

//   Future<void> _onRefresh() async {
//     context
//         .read<PropertyForRentBloc>()
//         .add(RefreshPropertyForRentRequested(2, _searchController.text));
//   }

//   void _onScroll() {
//     FocusManager.instance.primaryFocus?.unfocus();
//     double maxScroll = _scrollController.position.maxScrollExtent;
//     double currentScroll = _scrollController.position.pixels;
//     if (currentScroll == maxScroll) {
//       // ignore: avoid_single_cascade_in_expression_statements
//       context
//           .read<PropertyForRentBloc>()
//           .add(GetPropertyForRentRequested(2, _searchController.text, false));
//     }
//   }
// }
