import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/brand.dart';
import 'package:crel_mobile/models/suggest_property.dart';
import 'package:crel_mobile/modules/appointment/pages/create_appointment_page.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:crel_mobile/modules/profile/blocs/suggest_property/suggest_property_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiver/collection.dart';

class SuggestPropertyPage extends StatefulWidget {
  final Brand brand;
  const SuggestPropertyPage({Key? key, required this.brand}) : super(key: key);

  @override
  State<SuggestPropertyPage> createState() => _SuggestPropertyPageState();
}

class _SuggestPropertyPageState extends State<SuggestPropertyPage> {
  final ScrollController _scrollController = ScrollController();
  // late PropertyForRentBloc _propertyForRentBloc;
  final TextEditingController _searchController = TextEditingController()
    ..text = "";

  @override
  void initState() {
    // if (widget.suggest != null) {
    // suggestProperties = widget.suggest!;
    // }
    // context
    //     .read<PropertyForRentBloc>()
    //     .add(const GetPropertyForRentRequested(2, "", true));
    _scrollController.addListener(_onScroll);
    _searchController.text = "";
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // _searchController.clear();
    super.dispose();
  }

  List<SuggestProperty> suggestProperties = [];
  List<SuggestProperty> sokhai = [];
  List<int> suggestInt = [];
  List<int> suggestIntBefore = [];

  List<Widget> listchoseProperty() {
    List<Widget> widgetSuggestProperties = [];
    for (var property in suggestProperties) {
      widgetSuggestProperties.insert(
          0,
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                child: SizedBox(
                  width: 200,
                  // decoration: const BoxDecoration(
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: AppColor.textColor,
                  //       blurRadius: 7,
                  //       offset: Offset(0, 3),
                  //     ),
                  //   ],
                  // ),
                  child: Card(
                    color: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: CachedNetworkImage(
                            height: AppFormat.height(context) / 8,
                            width: AppFormat.width(context),
                            fit: BoxFit.cover,
                            imageUrl: property.property!.media!.isNotEmpty
                                ? property.property!.media![0].link.toString()
                                : "https://www.savills.com.vn/_images/thaibuilding-20190911.jpg",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: AppFormat.width(context),
                                child: Text(
                                  property.property!.name.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TxtStyle.heading4.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                property.property!.location!.address
                                        .toString() +
                                    ", " +
                                    property.property!.location!.ward!.name
                                        .toString() +
                                    ", " +
                                    property.property!.location!.ward!.district!
                                        .name
                                        .toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TxtStyle.heading5Blue
                                    .copyWith(color: Colors.white),
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
                top: -10,
                right: -10,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        suggestProperties.remove(property);
                      });
                    },
                    icon: const DeleteItemIcon()),
              ),
            ],
          ));
    }
    return widgetSuggestProperties;
  }

  bool isInitState1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Đề xuất mặt bằng",
            style: TxtStyle.textAppBar,
          ),
          backgroundColor: AppColor.primaryColor,
          centerTitle: true,
          actions: [
            Center(
                child: GestureDetector(
                    onTap: () {
                      if (!listsEqual(suggestProperties, sokhai)) {
                        if (suggestInt.isEmpty) {
                          isInitState1 = true;
                        }
                        context
                            .read<SuggestPropertyBloc>()
                            .add(CreateListSuggestPropertyByBrand(
                              suggestIntBefore,
                              suggestInt,
                              widget.brand.id!,
                            ));
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: const FaIcon(FontAwesomeIcons.shop))),
            const SizedBox(width: 16)
          ],
        ),
        body: SafeArea(
          child: BlocConsumer<SuggestPropertyBloc, SuggestPropertyState>(
            listener: (context, state1) {
              if (state1 is SuggestCreateListSuggestPropertyByBrand) {
                !isInitState1
                    ? AppFormat.showSnackBar(
                        context, 1, "Đề xuất mặt bằng thành công")
                    : AppFormat.showSnackBar(
                        context, 1, "Loại bỏ mặt bằng thành công");
                // Timer(const Duration(milliseconds: 800), () {
                Navigator.pop(context);
                // });
              }
            },
            builder: (context, state1) {
              return BlocConsumer<PropertyForRentBloc, PropertyForRentState>(
                listener: (context, state) {
                  if (state is PropertyForRentError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("PropertyForRentError")));
                  }
                },
                builder: (context, state) {
                  if (state is PropertyForRentLoaded &&
                      state1 is SuggestPropertyLoaded) {
                    if (isInitState1) {
                      sokhai = state1.properties
                          .where((element) => element.property!.status == 2)
                          .toList();
                      suggestProperties = state1.properties
                          .where((element) => element.property!.status == 2)
                          .toList();
                    }
                    isInitState1 = false;
                    // suggestProperties = suggestProperties
                    //     .where((element) => element.property!.status == 2)
                    //     .toList();
                    suggestInt = [];
                    for (var element in suggestProperties) {
                      suggestInt.add(element.propertyId!);
                      if (suggestIntBefore.isEmpty &&
                          suggestProperties.isNotEmpty) {
                        suggestIntBefore = suggestInt;
                      }
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 16, right: 16, top: 16),
                          child: Text(
                            "Chọn mặt bằng muốn đề xuất:",
                            style: TxtStyle.heading3,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // const Padding(
                        //     padding:
                        //         EdgeInsets.only(bottom: 8, left: 16, right: 16),
                        //     child: SearchBarProperty(
                        //       title:
                        //           "Nhập tên bất động sản mà bạn muốn tìm kiếm!",
                        //     )),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: _onRefresh,
                            child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                controller: _scrollController,
                                // shrinkWrap: true,
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16),
                                itemCount: state.hasReachedMax
                                    ? state.propertyForRents.length
                                    : state.propertyForRents.length + 1,
                                itemBuilder: (context, index) {
                                  if (index >= state.propertyForRents.length) {
                                    return (state.propertyForRents.length >= 4)
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : const SizedBox();
                                  } else {
                                    return InkWell(
                                        onTap: () {
                                          // Navigator.pushNamed(
                                          //     context, AppRouter.propertyDetail,
                                          //     arguments:
                                          //         ScreenPropertyArguments(
                                          //             state.propertyForRents[
                                          //                 index],
                                          //             0));

                                          Navigator.pushNamed(
                                              context, AppRouter.propertyDetail,
                                              arguments: 0);

                                          context.read<PropertyForRentBloc>().add(
                                              GetPropertyForRentByIdRequested(
                                                  state.propertyForRents[index]
                                                      .id!));

                                          // Navigator.of(context).push(
                                          //   MaterialPageRoute<PropertyDetail>(
                                          //     builder: (_) =>
                                          //         BlocProvider.value(
                                          //       value: BlocProvider.of<
                                          //               PropertyForRentBloc>(
                                          //           context),
                                          //       child: PropertyDetail(
                                          //         propertyForRent: state
                                          //             .propertyForRents[index],
                                          //       ),
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: Container(
                                                width: AppFormat.width(context),
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  // boxShadow: [
                                                  //   BoxShadow(
                                                  //     color: AppColor.textColor,
                                                  //     blurRadius: 7,
                                                  //     offset: Offset(0, 3),
                                                  //   ),
                                                  // ],
                                                ),
                                                child: Card(
                                                  color: AppColor.primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        child:
                                                            CachedNetworkImage(
                                                          height:
                                                              AppFormat.height(
                                                                      context) /
                                                                  8,
                                                          width:
                                                              AppFormat.width(
                                                                  context),
                                                          fit: BoxFit.cover,
                                                          imageUrl: state
                                                                  .propertyForRents[
                                                                      index]
                                                                  .media!
                                                                  .isNotEmpty
                                                              ? state
                                                                  .propertyForRents[
                                                                      index]
                                                                  .media![0]
                                                                  .link
                                                                  .toString()
                                                              : "https://www.savills.com.vn/_images/thaibuilding-20190911.jpg",
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: AppFormat
                                                                  .width(
                                                                      context),
                                                              child: Text(
                                                                state
                                                                    .propertyForRents[
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                style: TxtStyle
                                                                    .heading3
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            Text(
                                                              state
                                                                      .propertyForRents[
                                                                          index]
                                                                      .location!
                                                                      .address
                                                                      .toString() +
                                                                  ", " +
                                                                  state
                                                                      .propertyForRents[
                                                                          index]
                                                                      .location!
                                                                      .ward!
                                                                      .name
                                                                      .toString() +
                                                                  ", " +
                                                                  state
                                                                      .propertyForRents[
                                                                          index]
                                                                      .location!
                                                                      .ward!
                                                                      .district!
                                                                      .name
                                                                      .toString(),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TxtStyle
                                                                  .heading5Blue
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            (!suggestProperties
                                                    .where((element) =>
                                                        element.propertyId ==
                                                        state
                                                            .propertyForRents[
                                                                index]
                                                            .id)
                                                    .toList()
                                                    .isNotEmpty)
                                                ? Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            suggestProperties.add(SuggestProperty(
                                                                brand: widget
                                                                    .brand,
                                                                brandId: widget
                                                                    .brand.id,
                                                                propertyId: state
                                                                    .propertyForRents[
                                                                        index]
                                                                    .id,
                                                                property: state
                                                                        .propertyForRents[
                                                                    index]));
                                                          });
                                                        },
                                                        child:
                                                            const AddItemIcon()),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ));
                                  }
                                }),
                          ),
                        ),
                        suggestProperties.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    right: 16, left: 16, bottom: 16),
                                child: SizedBox(
                                  height: 235,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "Danh sách đề xuất:",
                                          style: TxtStyle.heading3.copyWith(
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   height: 8,
                                      // ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                              children: listchoseProperty()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              );
            },
          ),
        ));
  }

  Future<void> _onRefresh() async {
    context
        .read<PropertyForRentBloc>()
        .add(RefreshPropertyForRentRequested(2, _searchController.text));
  }

  void _onScroll() {
    FocusManager.instance.primaryFocus?.unfocus();
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      // ignore: avoid_single_cascade_in_expression_statements
      context
          .read<PropertyForRentBloc>()
          .add(GetPropertyForRentRequested(2, _searchController.text, false));
    }
  }
}




//  body: SafeArea(
//           child: BlocConsumer<PropertyForRentBloc, PropertyForRentState>(
//             listener: (context, state) {
//               if (state is PropertyForRentError) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("PropertyForRentError")));
//               }
//             },
//             builder: (context, state) {
//               if (state is PropertyForRentLoading) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               if (state is PropertyForRentLoaded) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Padding(
//                         padding:
//                             EdgeInsets.only(bottom: 8, left: 16, right: 16),
//                         child: SearchBarProperty(
//                           title: "Nhập tên bất động sản mà bạn muốn tìm kiếm!",
//                         )),
//                     Expanded(
//                       child: RefreshIndicator(
//                         onRefresh: _onRefresh,
//                         child: ListView.builder(
//                             physics: const AlwaysScrollableScrollPhysics(),
//                             controller: _scrollController,
//                             // shrinkWrap: true,
//                             padding: const EdgeInsets.only(
//                                 left: 16, right: 16, bottom: 16),
//                             itemCount: state.hasReachedMax
//                                 ? state.propertyForRents.length
//                                 : state.propertyForRents.length + 1,
//                             itemBuilder: (context, index) {
//                               if (index >= state.propertyForRents.length) {
//                                 return (state.propertyForRents.length >= 3)
//                                     ? const Center(
//                                         child: CircularProgressIndicator())
//                                     : const SizedBox();
//                               } else {
//                                 return InkWell(
//                                     onTap: () {
//                                       Navigator.of(context).push(
//                                         MaterialPageRoute<PropertyDetail>(
//                                           builder: (_) => BlocProvider.value(
//                                             value: BlocProvider.of<
//                                                 PropertyForRentBloc>(context),
//                                             child: PropertyDetail(
//                                               propertyForRent:
//                                                   state.propertyForRents[index],
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                       // Navigator.pushNamed(context, AppRouter.propertyDetail,
//                                       //     arguments: state.propertyForRents[index]);
//                                     },
//                                     child: Stack(
//                                       children: [
//                                         // InkWell(
//                                         //     onTap: !suggestProperties.contains(
//                                         //             state.propertyForRents[index])
//                                         //         ? () {
//                                         //             setState(() {
//                                         //               suggestProperties.add(
//                                         //                   state.propertyForRents[
//                                         //                       index]);
//                                         //             });
//                                         //           }
//                                         //         : null,
//                                         //     child: FaIcon(
//                                         //       FontAwesomeIcons.addressBook,
//                                         //       color: !suggestProperties.contains(
//                                         //               state.propertyForRents[
//                                         //                   index])
//                                         //           ? AppColor.primaryColor
//                                         //           : AppColor.boderColor,
//                                         //     )),
//                                         // const SizedBox(
//                                         //   width: 8,
//                                         // ),
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(bottom: 8),
//                                           child: Container(
//                                             width: AppFormat.width(context),
//                                             decoration: const BoxDecoration(
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(10)),
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: AppColor.textColor,
//                                                   blurRadius: 7,
//                                                   offset: Offset(0, 3),
//                                                 ),
//                                               ],
//                                               // boxShadow: [
//                                               //   BoxShadow(
//                                               //     color: AppColor.textColor,
//                                               //     blurRadius: 10,
//                                               //     offset: Offset(0.5, 0.5),
//                                               //   ),
//                                               // ],
//                                             ),
//                                             child: Card(
//                                               color: AppColor.primaryColor,
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                               ),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   ClipRRect(
//                                                     borderRadius:
//                                                         const BorderRadius.only(
//                                                             topLeft:
//                                                                 Radius.circular(
//                                                                     10),
//                                                             topRight:
//                                                                 Radius.circular(
//                                                                     10)),
//                                                     child: CachedNetworkImage(
//                                                       height: AppFormat.height(
//                                                               context) /
//                                                           8,
//                                                       width: AppFormat.width(
//                                                           context),
//                                                       fit: BoxFit.cover,
//                                                       imageUrl: state
//                                                               .propertyForRents[
//                                                                   index]
//                                                               .media!
//                                                               .isNotEmpty
//                                                           ? state
//                                                               .propertyForRents[
//                                                                   index]
//                                                               .media![0]
//                                                               .link
//                                                               .toString()
//                                                           : "https://www.savills.com.vn/_images/thaibuilding-20190911.jpg",
//                                                     ),
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             12),
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         SizedBox(
//                                                           width:
//                                                               AppFormat.width(
//                                                                   context),
//                                                           child: Text(
//                                                             state
//                                                                 .propertyForRents[
//                                                                     index]
//                                                                 .name
//                                                                 .toString(),
//                                                             overflow:
//                                                                 TextOverflow
//                                                                     .ellipsis,
//                                                             maxLines: 1,
//                                                             style: TxtStyle
//                                                                 .heading3
//                                                                 .copyWith(
//                                                                     color: Colors
//                                                                         .white),
//                                                           ),
//                                                         ),
//                                                         const SizedBox(
//                                                           height: 8,
//                                                         ),
//                                                         Text(
//                                                           state
//                                                                   .propertyForRents[
//                                                                       index]
//                                                                   .location!
//                                                                   .address
//                                                                   .toString() +
//                                                               ", " +
//                                                               state
//                                                                   .propertyForRents[
//                                                                       index]
//                                                                   .location!
//                                                                   .ward!
//                                                                   .name
//                                                                   .toString() +
//                                                               ", " +
//                                                               state
//                                                                   .propertyForRents[
//                                                                       index]
//                                                                   .location!
//                                                                   .ward!
//                                                                   .district!
//                                                                   .name
//                                                                   .toString(),
//                                                           maxLines: 2,
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           style: TxtStyle
//                                                               .heading5Blue
//                                                               .copyWith(
//                                                                   color: Colors
//                                                                       .white),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         (!suggestProperties
//                                                 .where((element) =>
//                                                     element.propertyId ==
//                                                     state
//                                                         .propertyForRents[index]
//                                                         .id)
//                                                 .toList()
//                                                 .isNotEmpty)
//                                             // (suggestProperties.where((element) => element.id == state.propertyForRents[index].id,).first()!=null)
//                                             ? Positioned(
//                                                 top: 10,
//                                                 right: 10,
//                                                 child: GestureDetector(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         suggestProperties.add(
//                                                             SuggestProperty(
//                                                                 brand: widget
//                                                                     .brand,
//                                                                 brandId: widget
//                                                                     .brand.id,
//                                                                 propertyId: state
//                                                                     .propertyForRents[
//                                                                         index]
//                                                                     .id,
//                                                                 property: state
//                                                                         .propertyForRents[
//                                                                     index]));
//                                                       });
//                                                     },
//                                                     child: const FaIcon(
//                                                         FontAwesomeIcons
//                                                             .addressBook,
//                                                         color: AppColor
//                                                             .primaryColor)),
//                                               )
//                                             : const SizedBox(),
//                                       ],
//                                     ));
//                               }
//                             }),
//                       ),
//                     ),
//                     suggestProperties.isNotEmpty
//                         ? Padding(
//                             padding: const EdgeInsets.only(
//                                 right: 16, left: 16, bottom: 16),
//                             child: SizedBox(
//                               height: 235,
//                               child: Column(
//                                 children: [
//                                   Align(
//                                     alignment: Alignment.bottomLeft,
//                                     child: Text(
//                                       "Danh sách đề xuất:",
//                                       style: TxtStyle.heading3.copyWith(
//                                           fontWeight: FontWeight.normal),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 8,
//                                   ),
//                                   Expanded(
//                                     child: BlocConsumer<SuggestPropertyBloc,
//                                         SuggestPropertyState>(
//                                       listener: (context, state) {
//                                         if (state is SuggestPropertyError) {
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(const SnackBar(
//                                                   content: Text(
//                                                       "SuggestPropertyError")));
//                                         }
//                                       },
//                                       builder: (context, state) {
//                                         if (state is SuggestPropertyLoading) {
//                                           return const Center(
//                                             child: CircularProgressIndicator(),
//                                           );
//                                         }
//                                         if (state is SuggestPropertyLoaded) {
//                                           suggestProperties = state.properties;
//                                           suggestInt = [];
//                                           for (var element
//                                               in suggestProperties) {
//                                             suggestInt.add(element.propertyId!);
//                                             if (suggestIntBefore.isEmpty &&
//                                                 suggestProperties.isNotEmpty) {
//                                               suggestIntBefore = suggestInt;
//                                             }
//                                           }
//                                           return SingleChildScrollView(
//                                             scrollDirection: Axis.horizontal,
//                                             child: Row(
//                                                 children: listchoseProperty()),
//                                           );
//                                         }
//                                         return Text("$state");
//                                       },
//                                     ),
//                                   ),
//                                   // suggestProperties.isNotEmpty
//                                   //     ? ListView.builder(
//                                   //         itemCount: suggestProperties.length,
//                                   //         itemBuilder: (context, index) {
//                                   //           return const Text("data");
//                                   //         },
//                                   //       )
//                                   //     : const SizedBox()
//                                 ],
//                               ),
//                             ),
//                           )
//                         : const SizedBox()
//                   ],
//                 );
//               }
//               return Text("$state");
//             },
//           ),
//         ));
  