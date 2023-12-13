import 'package:cached_network_image/cached_network_image.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/modules/appointment/pages/create_appointment_page.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPropertyAppointmentPage extends StatefulWidget {
  final Property? suggest;
  const AddPropertyAppointmentPage({Key? key, this.suggest}) : super(key: key);

  @override
  State<AddPropertyAppointmentPage> createState() =>
      _AddPropertyAppointmentPageState();
}

class _AddPropertyAppointmentPageState
    extends State<AddPropertyAppointmentPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    if (widget.suggest != null) {
      suggestProperties = widget.suggest!;
    }
    // context
    //     .read<PropertyForRentBloc>()
    //     .add(const GetPropertyForRentRequested(2, "", true));
    _scrollController.addListener(_onScroll);
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Property? suggestProperties;
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
      ),
      body: SafeArea(
        child: BlocConsumer<PropertyForRentBloc, PropertyForRentState>(
          listener: (context, state) {
            if (state is PropertyForRentError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("PropertyForRentError")));
            }
          },
          builder: (context, state) {
            if (state is PropertyForRentLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PropertyForRentLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Text(
                      "Chọn mặt bằng muốn đề xuất:",
                      style: TxtStyle.heading3,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
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
                                    Navigator.pushNamed(
                                        context, AppRouter.propertyDetail,
                                        arguments: state.propertyForRents[index]
                                        // arguments:
                                        // ScreenPropertyArguments(
                                        //     state.propertyForRents[index], 0)
                                        // 0
                                        );

                                    context.read<PropertyForRentBloc>().add(
                                        GetPropertyForRentByIdRequested(
                                            state.propertyForRents[index].id!));
                                  },
                                  child: Stack(
                                    children: [
                                      // InkWell(
                                      //     onTap: !suggestProperties.contains(
                                      //             state.propertyForRents[index])
                                      //         ? () {
                                      //             setState(() {
                                      //               suggestProperties.add(
                                      //                   state.propertyForRents[
                                      //                       index]);
                                      //             });
                                      //           }
                                      //         : null,
                                      //     child: FaIcon(
                                      //       FontAwesomeIcons.addressBook,
                                      //       color: !suggestProperties.contains(
                                      //               state.propertyForRents[
                                      //                   index])
                                      //           ? AppColor.primaryColor
                                      //           : AppColor.boderColor,
                                      //     )),
                                      // const SizedBox(
                                      //   width: 8,
                                      // ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Container(
                                          width: AppFormat.width(context),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
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
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10)),
                                                  child: CachedNetworkImage(
                                                    height: AppFormat.height(
                                                            context) /
                                                        8,
                                                    width: AppFormat.width(
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
                                                      const EdgeInsets.all(12),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: AppFormat.width(
                                                            context),
                                                        child: Text(
                                                          state
                                                              .propertyForRents[
                                                                  index]
                                                              .name
                                                              .toString(),
                                                          overflow: TextOverflow
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
                                                        overflow: TextOverflow
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
                                      suggestProperties !=
                                              state.propertyForRents[index]
                                          ? Positioned(
                                              top: 0,
                                              right: 0,
                                              child: IconButton(
                                                  splashColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onPressed: () {
                                                    setState(() {
                                                      suggestProperties = state
                                                              .propertyForRents[
                                                          index];
                                                      Navigator.pop(context,
                                                          suggestProperties);
                                                    });
                                                  },
                                                  icon: const AddItemIcon()),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ));
                            }
                          }),
                    ),
                  ),
                ],
              );
            }
            return Text("$state");
          },
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    context
        .read<PropertyForRentBloc>()
        .add(const RefreshPropertyForRentRequested(2, ""));
  }

  void _onScroll() {
    FocusManager.instance.primaryFocus?.unfocus();
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      // ignore: avoid_single_cascade_in_expression_statements
      context
          .read<PropertyForRentBloc>()
          .add(const GetPropertyForRentRequested(2, "", false));
    }
  }
}

// class SuggestItem extends StatefulWidget {
//   final Property property;
//   final bool isCheckbox;
//   const SuggestItem(
//       {Key? key, required this.property, required this.isCheckbox})
//       : super(key: key);

//   @override
//   State<SuggestItem> createState() => _SuggestItemState();
// }

// class _SuggestItemState extends State<SuggestItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         widget.isCheckbox
//             ? InkWell(
//                 onTap: () {}, child: const FaIcon(FontAwesomeIcons.addressBook))
//             : const SizedBox(),
//         widget.isCheckbox
//             ? const SizedBox(
//                 width: 8,
//               )
//             : const SizedBox(),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 8),
//             child: Container(
//               width: AppFormat.width(context),
//               decoration: const BoxDecoration(
//                   // boxShadow: [
//                   //   BoxShadow(
//                   //     color: AppColor.textColor,
//                   //     blurRadius: 7,
//                   //     offset: Offset(0, 3),
//                   //   ),
//                   // ],
//                   ),
//               child: Card(
//                 color: AppColor.primaryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(10),
//                           topRight: Radius.circular(10)),
//                       child: CachedNetworkImage(
//                         height: AppFormat.height(context) / 8,
//                         width: AppFormat.width(context),
//                         fit: BoxFit.cover,
//                         imageUrl:
//                             "https://www.savills.com.vn/_images/thaibuilding-20190911.jpg",
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: AppFormat.width(context),
//                             child: Text(
//                               widget.property.name.toString(),
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                               style: TxtStyle.heading3
//                                   .copyWith(color: Colors.white),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 8,
//                           ),
//                           Text(
//                             widget.property.location!.address.toString() +
//                                 ", " +
//                                 widget.property.location!.ward!.name
//                                     .toString() +
//                                 ", " +
//                                 widget.property.location!.ward!.district!.name
//                                     .toString(),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: TxtStyle.heading5Blue
//                                 .copyWith(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
