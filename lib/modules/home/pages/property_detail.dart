import 'package:crel_mobile/common/widgets/stateful/custom_carousel_image_property.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:crel_mobile/modules/mission/blocs/project/project_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class PropertyDetail extends StatelessWidget {
//   const PropertyDetail({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<PropertyForRentBloc, PropertyForRentState>(
//         builder: (context, state) {
//           if (state is PropertyForRentByIdLoaded) {
//             return Scaffold(
//               appBar: AppBar(),
//               body: SafeArea(
//                 child: Center(
//                   child: Text(state.propertyForRents.id.toString()),
//                 ),
//               ),
//             );
//           } else if (state is PropertyForRentLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }

class PropertyDetail extends StatelessWidget {
  final int? id;
  const PropertyDetail({Key? key, required this.propertyForRent, this.id})
      : super(key: key);
  final Property propertyForRent;

  @override
  Widget build(BuildContext context) {
    // ProjectBloc projectBloc = context.read<ProjectBloc>()
    //   ..add(GetProjectByIdRequested(propertyForRent.projectId!));
    // BrandBloc brandBloc = context.read<BrandBloc>()
    // ..add(const GetBrandRequested(true));

    var widthColumnIcon = (AppFormat.width(context) - 32) / 3;
    print(widthColumnIcon);
    Future<void> _launchPhone(String phone) async {
      final Uri launchUri = Uri(scheme: 'tel', path: phone);
      if (await canLaunchUrlString(launchUri.toString())) {
        await launchUrlString(launchUri.toString());
      } else {
        throw "Could not lanch $launchUri";
      }
    }
    // onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

    return WillPopScope(
      onWillPop: () async {
        // Navigator.pushNamedAndRemoveUntil(
        //     context, AppRouter.customNavBar, (route) => false,
        //     arguments: 0);
        if (id == 1 || id == 2) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRouter.customNavBar, (route) => false,
              arguments: 0);
        } else {
          context
              .read<PropertyForRentBloc>()
              .add(const GetPropertyForRentRequested(2, "", true));
          Navigator.pop(context);
        }

        // Navigator.pushNamedAndRemoveUntil(
        //     context, AppRouter.customNavBar, (route) => false,
        //     arguments: 0);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title: const Text(
            "Chi tiết mặt bằng",
            style: TxtStyle.textAppBar,
          ),
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              // context
              //     .read<PropertyForRentBloc>()
              //     .add(const GetPropertyForRentRequested(2, "", true));
              if (id == 1 || id == 2) {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRouter.customNavBar, (route) => false,
                    arguments: 0);
              } else {
                context
                    .read<PropertyForRentBloc>()
                    .add(const GetPropertyForRentRequested(2, "", true));
                Navigator.pop(context);
              }

              // Navigator.pushNamedAndRemoveUntil(
              //     context, AppRouter.customNavBar, (route) => false,
              //     arguments: 0);
            },
            icon: SvgPicture.asset(
              'assets/icons/arrow-left.svg',
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            propertyForRent.status != 3
                ? IconButton(
                    splashRadius: 24,
                    padding: const EdgeInsets.all(0.0),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute<UpdatePropetyPage>(
                      //     builder: (_) => BlocProvider.value(
                      //       value: BlocProvider.of<PropertyForRentBloc>(context),
                      //       child: UpdatePropetyPage(
                      //         property: propertyForRent,
                      //       ),
                      //     ),
                      //   ),
                      // );

                      // propertyForRent.projectId != null
                      //     ? context.read<ProjectBloc>().add(
                      //         GetProjectByIdRequested(propertyForRent.projectId!))
                      //     : context.read<ProjectBloc>().add(GetProjectRequested());

                      context.read<PropertyForRentBloc>().add(
                          GetPropertyForRentByIdRequested(propertyForRent.id!));
                      Navigator.pushNamed(context, AppRouter.updateProperty,
                          arguments: propertyForRent);
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/edit.svg',
                      color: Colors.white,
                    ))
                : const SizedBox(),
            const SizedBox(width: 8)
          ],
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Stack(
              // alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomCarouselImageProperty(
                        media: propertyForRent.media,
                      ),
                      // CachedNetworkImage(
                      //   height: 200,
                      //   width: AppFormat.width(context),
                      //   fit: BoxFit.cover,
                      //   imageUrl:
                      //       "https://www.savills.com.vn/_images/thaibuilding-20190911.jpg",
                      //   placeholder: (context, url) =>
                      //       const CircularProgressIndicator(),
                      //   errorWidget: (context, url, error) =>
                      //       const Icon(Icons.error),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                propertyForRent.name.toString(),
                                // maxLines: 2,
                                // overflow: TextOverflow.ellipsis,
                                style: TxtStyle.heading2,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              propertyForRent.owners!.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/call.svg',
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  AppFormat.phoneFormat(
                                                          propertyForRent
                                                              .owners![index]
                                                              .phoneNumber!
                                                              .toString()) +
                                                      " " +
                                                      ((propertyForRent
                                                              .owners![index]
                                                              .gender!)
                                                          ? "Mr."
                                                          : "Miss.") +
                                                      AppFormat.getName(
                                                          propertyForRent
                                                              .owners![index]
                                                              .name
                                                              .toString()),
                                                  style: TxtStyle.heading4
                                                      .copyWith(
                                                          color: AppColor
                                                              .secondColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                                Text(
                                  AppFormat.changePriceVN(
                                          propertyForRent.price.toString()) +
                                      " Triệu / tháng",
                                  style: TxtStyle.heading3,
                                )
                              ],
                            ),

                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              AppFormat.parseDateTime(
                                  propertyForRent.lastUpdateDate.toString()),
                              style: TxtStyle.heading5Gray,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Địa chỉ: ",
                                  style: TxtStyle.heading4.copyWith(
                                    color: AppColor.secondColor,
                                  ),
                                ),
                                // const SizedBox(
                                //   width: 5,
                                // ),
                                Expanded(
                                    child: Text(
                                  propertyForRent.location!.address.toString() +
                                      ", " +
                                      propertyForRent.location!.ward!.name
                                          .toString() +
                                      ", " +
                                      propertyForRent
                                          .location!.ward!.district!.name
                                          .toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TxtStyle.heading4.copyWith(
                                    color: AppColor.secondColor,
                                  ),
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const Icon(Icons.padding),
                                // const SizedBox(
                                //   width: 5,
                                // ),
                                GestureDetector(
                                  onTap: propertyForRent.project == null
                                      ? null
                                      : () {
                                          context.read<ProjectBloc>().add(
                                              GetProjectByIdLoaded(
                                                  propertyForRent
                                                      .project!.id!));

                                          // context.read<DistrictBloc>().add(
                                          //     GetDistrictById(propertyForRent
                                          //         .project!.districtId!));
                                          Navigator.pushNamed(
                                              context, AppRouter.projectPage,
                                              arguments:
                                                  propertyForRent.project);
                                        },
                                  child: RichText(
                                    text: TextSpan(
                                        text: "Dự án: ",
                                        style: TxtStyle.heading4.copyWith(
                                          color: AppColor.secondColor,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: propertyForRent.project ==
                                                    null
                                                ? "Không"
                                                : propertyForRent.project!.name
                                                    .toString(),
                                            style: TxtStyle.heading4.copyWith(
                                                fontWeight:
                                                    propertyForRent.project ==
                                                            null
                                                        ? null
                                                        : FontWeight.bold,
                                                color: AppColor.secondColor),
                                          ),
                                        ]),

                                    //   Text(
                                    // propertyForRent.location!.address!,
                                    // style: TxtStyle.heading4.copyWith(
                                    //   fontWeight: FontWeight.bold,
                                    //   color: AppColor.primaryColor,
                                    // ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              // mainAxisAlignment:
                              // MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/direction.svg',
                                            // height: 250,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "Hướng: " +
                                                (propertyForRent.direction !=
                                                        null
                                                    ? AppFormat
                                                            .getListDirection()[
                                                        int.parse(
                                                            propertyForRent
                                                                .direction!
                                                                .toString())]
                                                    : propertyForRent.direction
                                                        .toString()),
                                            style: TxtStyle.heading4.copyWith(
                                              color: AppColor.secondColor,
                                            ),
                                          ),
                                          // Text(
                                          //   "Tầng: " +
                                          //       propertyForRent.floor
                                          //           .toString(),
                                          //   style:
                                          //       TxtStyle.heading4.copyWith(
                                          //     color: AppColor.secondColor,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/numberofrontage.svg',
                                            // height: 250,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "Số mặt tiền: " +
                                                propertyForRent.numberOfFrontage
                                                    .toString(),
                                            style: TxtStyle.heading4.copyWith(
                                              color: AppColor.secondColor,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/frontage.svg',
                                            // height: 250,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "Mặt tiền: " +
                                                AppFormat.changeMeterVN(
                                                    propertyForRent.frontage
                                                        .toString()) +
                                                " m",
                                            style: TxtStyle.heading4.copyWith(
                                              color: AppColor.secondColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/road-width.svg',
                                            height: 24,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "Lộ giới: " +
                                                AppFormat.changeMeterVN(
                                                    propertyForRent.roadWidth
                                                        .toString()) +
                                                " m",
                                            style: TxtStyle.heading4.copyWith(
                                              color: AppColor.secondColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // const SizedBox(
                                      //   height: 8,
                                      // ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            border: Border(
                                          left: BorderSide(
                                            color: AppColor.boderColor,
                                            // width: 3.0,
                                          ),
                                        )),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/horizontal.svg',
                                                    // height: 250,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "Chiều ngang: " +
                                                        AppFormat.changeMeterVN(
                                                            propertyForRent
                                                                .vertical
                                                                .toString()) +
                                                        " m",
                                                    style: TxtStyle.heading4
                                                        .copyWith(
                                                      color:
                                                          AppColor.secondColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/vertical.svg',
                                                    // height: 250,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    "Chiều dọc: " +
                                                        AppFormat.changeMeterVN(
                                                            propertyForRent
                                                                .horizontal
                                                                .toString()) +
                                                        " m",
                                                    style: TxtStyle.heading4
                                                        .copyWith(
                                                      color:
                                                          AppColor.secondColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/floorarea.svg',
                                                    // height: 250,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "Diện tích sàn: " +
                                                        AppFormat.changeMeterVN(
                                                            propertyForRent
                                                                .floorArea
                                                                .toString()) +
                                                        " m\u00B2",
                                                    style: TxtStyle.heading4
                                                        .copyWith(
                                                      color:
                                                          AppColor.secondColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/area.svg',
                                                    // height: 250,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "Diện tích: " +
                                                        AppFormat.changeMeterVN(
                                                            propertyForRent.area
                                                                .toString()) +
                                                        " m\u00B2",
                                                    style: TxtStyle.heading4
                                                        .copyWith(
                                                      color:
                                                          AppColor.secondColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),

                            SizedBox(
                              width: AppFormat.width(context) - 32,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/floor.svg',
                                    // height: 250,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Tầng: " +
                                          propertyForRent.floor.toString(),
                                      style: TxtStyle.heading4.copyWith(
                                        color: AppColor.secondColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Giấy tờ pháp lý: " +
                                  AppFormat.getListCertificate()[int.parse(
                                      propertyForRent.certificates!
                                          .toString())],
                              style: TxtStyle.heading4.copyWith(
                                color: AppColor.secondColor,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),

                            (propertyForRent.rentalCondition != null)
                                ? Text(
                                    "Điều kiện cho thuê: " +
                                        propertyForRent.rentalCondition
                                            .toString(),
                                    style: TxtStyle.heading4.copyWith(
                                      color: AppColor.secondColor,
                                    ),
                                  )
                                : Text(
                                    "Điều kiện cho thuê: "
                                    "Không bán đồ ăn",
                                    style: TxtStyle.heading4.copyWith(
                                      color: AppColor.secondColor,
                                    ),
                                  ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Thời hạn cho thuê: " +
                                  propertyForRent.rentalTerm.toString(),
                              style: TxtStyle.heading4.copyWith(
                                color: AppColor.secondColor,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Thời hạn đặt cọc: " +
                                  propertyForRent.depositTerm.toString(),
                              style: TxtStyle.heading4.copyWith(
                                color: AppColor.secondColor,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Chính sách thanh toán: " +
                                  propertyForRent.paymentTerm.toString(),
                              style: TxtStyle.heading4.copyWith(
                                color: AppColor.secondColor,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),

                            Text(
                              'Mô tả',
                              style: TxtStyle.heading3
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            HtmlWidget(
                              propertyForRent.description.toString(),
                              textStyle: TxtStyle.heading4,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            // FloatingActionButton(onPressed: () {
                            //   Navigator.pushNamed(context, AppRouter.updateProperty,
                            //       arguments: propertyForRent);
                            // })
                            // SpaceList(space: propertyForRent.spaces!)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Positioned.fill(
                //     child: Align(
                //         alignment: Alignment.bottomLeft,
                //         child: Row(
                //           children: [
                //             // Expanded(
                //             //     child: CreateContract(
                //             //   propertyForRent: propertyForRent,
                //             // )),
                //             // Container(
                //             //   height: 52,
                //             //   width: 2,
                //             //   color: Colors.black,
                //             // ),
                //             Expanded(
                //               child: GestureDetector(
                //                 onTap: () => Navigator.of(context).push(
                //                   MaterialPageRoute<UpdatePropetyPage>(
                //                     builder: (_) => BlocProvider.value(
                //                       value: BlocProvider.of<PropertyForRentBloc>(
                //                           context),
                //                       child: UpdatePropetyPage(
                //                         property: propertyForRent,
                //                       ),
                //                     ),
                //                   ),
                //                 ),

                //                 //  Navigator.pushNamed(
                //                 //     context, AppRouter.updateProperty,
                //                 //     arguments: propertyForRent),
                //                 child: Container(
                //                   decoration: const BoxDecoration(
                //                     borderRadius: BorderRadius.only(
                //                         topRight: Radius.circular(10)),
                //                     color: AppColor.primaryColor,

                //                     // border: Border.all(
                //                     //     width: width ?? 0, color: Colors. ?? Colors.transparent)
                //                   ),
                //                   alignment: Alignment.center,
                //                   height: 52,
                //                   child: Text("Chỉnh sửa mặt bằng",
                //                       style: TxtStyle.heading3
                //                           .copyWith(color: Colors.white)),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
