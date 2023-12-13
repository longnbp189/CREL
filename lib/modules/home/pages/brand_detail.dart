import 'package:cached_network_image/cached_network_image.dart';
import 'package:crel_mobile/config/app_color.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/app_router.dart';
import 'package:crel_mobile/config/text_style.dart';
import 'package:crel_mobile/modules/home/blocs/brand/brand_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

// class CompanyStocks {
//   final String name;
//   final double price;

//   CompanyStocks({required this.name, required this.price});
// }

// List stocksList = [
//   CompanyStocks(name: "Facebook", price: 339.1),
//   CompanyStocks(name: "A10 NETWORKS INC.", price: 10.34),
//   CompanyStocks(name: "Intel Corp", price: 56.96),
//   CompanyStocks(name: "HP Inc", price: 32.43),
//   CompanyStocks(name: "Advanced Micro Devices Inc.", price: 77.44),
//   CompanyStocks(name: "Apple Inc", price: 133.98),
//   CompanyStocks(name: "Amazon.com, Inc.", price: 3505.44),
//   CompanyStocks(name: "Microsoft Corporation", price: 265.51),
//   CompanyStocks(name: "Facebook", price: 339.1),
//   CompanyStocks(name: "A10 NETWORKS INC.", price: 10.34),
//   CompanyStocks(name: "Intel Corp", price: 56.96),
//   CompanyStocks(name: "HP Inc", price: 32.43),
//   CompanyStocks(name: "Advanced Micro Devices Inc.", price: 77.44),
//   CompanyStocks(name: "Apple Inc", price: 133.98),
//   CompanyStocks(name: "Amazon.com, Inc.", price: 3505.44),
//   CompanyStocks(name: "Microsoft Corporation", price: 265.51)
// ];

class BrandDetail extends StatelessWidget {
  final int? id;
  const BrandDetail({Key? key, this.id
      // , required this.brand
      })
      : super(key: key);
  // final Brand brand;

  @override
  Future<void> _launchPhone(String phone) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrlString(launchUri.toString())) {
      await launchUrlString(launchUri.toString());
    } else {
      throw "Could not lanch $launchUri";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (id == 1) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRouter.customNavBar, (route) => false,
              arguments: 0);
        } else {
          context.read<BrandBloc>().add(const GetBrandRequested(true));
          Navigator.pop(context);
        }
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColor.primaryColor,
            title: const Text(
              "Chi tiết thương hiệu",
              style: TxtStyle.textAppBar,
            ),
            leading: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                if (id == 1) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRouter.customNavBar, (route) => false,
                      arguments: 0);
                } else {
                  context.read<BrandBloc>().add(const GetBrandRequested(true));
                  Navigator.pop(context);
                }
              },
              icon: SvgPicture.asset(
                'assets/icons/arrow-left.svg',
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
              child: BlocConsumer<BrandBloc, BrandState>(
            listener: (context, state) {},
            buildWhen: (previous, current) =>
                previous != current && current is BrandIdLoaded,
            builder: (context, state) {
              if (state is BrandLoading
                  // || state is BrandLoaded
                  ) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is BrandIdLoaded) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 250,
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: AppFormat.width(context),
                                // height: 100,
                                imageUrl: state.brand.avatarLink ??
                                    "https://cdn-www.vinid.net/824ff0bb-1-kv-1920x1080-1.jpg",
                                // placeholder: (context, url) =>
                                //     const CircularProgressIndicator(),
                                // errorWidget: (context, url, error) =>
                                //     const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/sms.svg',
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      state.brand.email.toString(),
                                      style: TxtStyle.heading4.copyWith(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/call.svg',
                                    ),
                                    // const FaIcon(FontAwesomeIcons.phone),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    GestureDetector(
                                      onTap: () => _launchPhone(
                                          state.brand.phoneNumber.toString()),
                                      child: Text(
                                        AppFormat.phoneFormat(
                                            state.brand.phoneNumber.toString()),
                                        style: TxtStyle.heading4.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.secondColor),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    // const FaIcon(FontAwesomeIcons.fax),
                                    // const SizedBox(
                                    //   width: 5,
                                    // ),
                                    Text(
                                      "Mã số doanh nghiệp: " +
                                          state.brand.registrationNumber
                                              .toString(),
                                      style: TxtStyle.heading4.copyWith(
                                          color: AppColor.secondColor),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Mô tả",
                                    style: TxtStyle.heading4
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 16),
                                  child: HtmlWidget(
                                      state.brand.description.toString()),
                                ),
                                // DescriptionTextWidget(
                                //   text: brand.description.toString(),
                                //   // text: brand.description.toString(),
                                //   // style: TxtStyle.heading4.copyWith(fontWeight: FontWeight.bold),
                                // ),

                                state.brand.stores!.isEmpty
                                    ? const SizedBox()
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 70),
                                        child: Container(
                                            width: AppFormat.width(context),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        AppColor.secondColor)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Text(
                                                    "Tổng cộng " +
                                                        // brand.totalProperty
                                                        // .toString()
                                                        state.brand.stores!
                                                            .length
                                                            .toString() +
                                                        " cửa hàng:",
                                                    style: TxtStyle.heading4
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),
                                                ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: state
                                                        .brand.stores!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        state
                                                                            .brand
                                                                            .stores![index]
                                                                            .name
                                                                            .toString(),
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TxtStyle
                                                                            .heading4
                                                                            .copyWith(fontWeight: FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Địa chỉ: ",
                                                                      style: TxtStyle
                                                                          .heading4
                                                                          .copyWith(
                                                                              fontWeight: FontWeight.bold),
                                                                    ),
                                                                    Expanded(
                                                                        child:
                                                                            Text(
                                                                      // state
                                                                      //         .brand
                                                                      //         .stores![
                                                                      //             index]
                                                                      //         .location!
                                                                      //         .address
                                                                      //         .toString() +
                                                                      //     ", " +
                                                                      //     state
                                                                      //         .brand
                                                                      //         .stores![
                                                                      //             index]
                                                                      //         .location!
                                                                      //         .ward!
                                                                      //         .name
                                                                      //         .toString() +
                                                                      //     ", " +
                                                                      //     state
                                                                      //         .brand
                                                                      //         .stores![index]
                                                                      //         .location!
                                                                      //         .ward!
                                                                      //         .district!
                                                                      //         .name
                                                                      //         .toString(),

                                                                      state
                                                                          .brand
                                                                          .stores![
                                                                              index]
                                                                          .address
                                                                          .toString(),
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TxtStyle
                                                                          .heading4
                                                                          .copyWith(
                                                                              color: AppColor.secondColor),
                                                                    ))
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          // const SizedBox(
                                                          //   height: 8,
                                                          // ),
                                                          (index ==
                                                                  state
                                                                          .brand
                                                                          .stores!
                                                                          .length -
                                                                      1)
                                                              ? const SizedBox(
                                                                  height: 8,
                                                                )
                                                              : const Divider(
                                                                  color: AppColor
                                                                      .secondColor,
                                                                )
                                                        ],
                                                      );
                                                    })
                                              ],
                                            )),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Container(
                    //     color: Colors.white,
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 16, vertical: 16),
                    //       child: SizedBox(
                    //         // color: Colors.white,
                    //         width: AppFormat.width(context),
                    //         child: ElevatedButton(
                    //           style: TxtStyle.buttonBlue,
                    //           onPressed: () {
                    //             context.read<SuggestPropertyBloc>().add(
                    //                 GetListSuggestPropertyByBrand(
                    //                     state.brand.id!, true));
                    //             context.read<PropertyForRentBloc>().add(
                    //                 const GetPropertyForRentRequested(
                    //                     2, "", true));
                    //             Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                   builder: (context) => SuggestPropertyPage(
                    //                         brand: state.brand,
                    //                       )),
                    //             );
                    //           },
                    //           child: Padding(
                    //             padding:
                    //                 const EdgeInsets.symmetric(vertical: 16),
                    //             child: Text(
                    //               'Danh sách mặt bằng đề xuất',
                    //               style: TxtStyle.heading3
                    //                   .copyWith(color: Colors.white),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                );
              }
              return Text("$state");
            },
          ))),
    );
  }
}

// class DescriptionTextWidget extends StatefulWidget {
//   final String text;

//   const DescriptionTextWidget({Key? key, required this.text}) : super(key: key);

//   @override
//   _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
// }

// class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
//   String? firstHalf;
//   String? secondHalf;

//   bool flag = true;

//   @override
//   void initState() {
//     super.initState();

//     if (widget.text.length > 132) {
//       firstHalf = widget.text.substring(0, 132);
//       secondHalf = widget.text.substring(132, widget.text.length);
//     } else {
//       firstHalf = widget.text;
//       secondHalf = "";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//       child: secondHalf!.isEmpty
//           ? Text(firstHalf!)
//           : Column(
//               children: [
//                 Text(flag ? (firstHalf! + "...") : (firstHalf! + secondHalf!)),
//                 InkWell(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: <Widget>[
//                       Text(
//                         flag ? "show more" : "show less",
//                         style: const TextStyle(color: AppColor.primaryColor),
//                       ),
//                     ],
//                   ),
//                   onTap: () {
//                     setState(() {
//                       flag = !flag;
//                     });
//                   },
//                 ),
//               ],
//             ),
//     );
//   }
// }

