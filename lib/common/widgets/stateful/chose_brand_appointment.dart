import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/brand.dart';
import 'package:crel_mobile/modules/home/blocs/brand/brand_bloc.dart';
import 'package:crel_mobile/modules/mission/widgets/choose_text_from_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoseBrandAppointment extends StatefulWidget {
  final Function(Brand) callback;
  final Brand? brand;
  const ChoseBrandAppointment({Key? key, required this.callback, this.brand})
      : super(key: key);

  @override
  State<ChoseBrandAppointment> createState() => _ChoseBrandAppointmentState();
}

class _ChoseBrandAppointmentState extends State<ChoseBrandAppointment> {
  final _searchController = TextEditingController();
  final _brandNameController = TextEditingController();
  final _registrationNumberController = TextEditingController();

  List<Brand> listBrand = [];
  // String nameBrand = "Chọn thương hiệu";
  Brand? brand;
  bool isData = true;
  @override
  void dispose() {
    _brandNameController.dispose();
    _searchController.dispose();
    _registrationNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _brandNameController.text = widget.brand != null ? widget.brand!.name! : "";
    _registrationNumberController.text =
        widget.brand != null ? widget.brand!.registrationNumber.toString() : "";
  }

  @override
  Widget build(BuildContext context) {
    if (isData) {
      brand = widget.brand;
      isData = false;
    }
    return BlocConsumer<BrandBloc, BrandState>(
      listener: (context, state) {
        if (state is BrandError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("BrandError")));
        }
      },
      builder: (context, state) {
        if (state is BrandLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is BrandIdLoaded) {
          return ChooseTextFromDrop(
            isDisable: true,
            lable: _brandNameController.text != ""
                ? "Người thuê"
                : "Chọn người thuê",
            textController: _brandNameController,
          );

          // Container(
          //     decoration: BoxDecoration(
          //         color: widget.brand != null ? AppColor.boderColor : null,
          //         borderRadius: BorderRadius.circular(10),
          //         border: Border.all(color: Colors.black)),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          //       child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(brand!.name.toString(),
          //                 overflow: TextOverflow.ellipsis,
          //                 maxLines: 1,
          //                 style: TxtStyle.heading4),
          //             // Text(brand!.phoneNumber.toString(),
          //             //     // overflow: TextOverflow.ellipsis,
          //             //     style: TxtStyle.heading4),
          //           ]),
          //     ));
        }
        if (state is BrandLoaded) {
          return InkWell(
            onTap: (widget.brand != null && isData)
                ? null
                : () {
                    listBrand = state.brands;
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState1) =>
                              DraggableScrollableSheet(
                            // initialChildSize:
                            //     0.915, //set this as you want
                            // maxChildSize:
                            //     0.915, //set this as you want
                            // minChildSize:
                            //     0.915, //set this as you want
                            expand: false,
                            builder: (context, scrollController) => Column(
                              children: [
                                Container(
                                  color: AppColor.boderColor,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            _searchController.clear();
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(Icons.close)),
                                      Text(
                                        "Nhập tên Thương hiệu",
                                        style: TxtStyle.heading3.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const IconButton(
                                          onPressed: null,
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.transparent,
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      // borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1,
                                          color: AppColor.boderColor)),
                                  child: TextField(
                                    onChanged: (value) {
                                      setState1(() {
                                        listBrand = state.brands
                                            .where((brandtName) => brandtName
                                                .name!
                                                .toLowerCase()
                                                .contains(value.toLowerCase()))
                                            .toList();
                                      });
                                    },
                                    controller: _searchController,
                                    cursorColor: AppColor.secondColor,
                                    style: const TextStyle(
                                        color: AppColor.secondColor),
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: AppColor.textColor,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      // physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: listBrand.length,
                                      controller: scrollController,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            widget.callback(listBrand[index]);
                                            setState(() {
                                              brand = listBrand[index];
                                              _brandNameController.text =
                                                  brand!.name!;
                                              _searchController.clear();
                                            });
                                            Navigator.pop(context, brand);
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                border: Border(
                                              top: BorderSide(
                                                color: AppColor.boderColor,
                                                width: 1,
                                              ),
                                              bottom: BorderSide(
                                                color: AppColor.boderColor,
                                                width: 1,
                                              ),
                                            )),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 8,
                                                ),
                                                child: Text(
                                                  listBrand[index]
                                                      .name
                                                      .toString(),
                                                  style: TxtStyle.heading4,
                                                )),
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
            child: ChooseTextFromDrop(
              isDisable: false,
              lable: _brandNameController.text != ""
                  ? "Thương hiệu"
                  : "Chọn thương hiệu",
              textController: _brandNameController,
            ),

            // Container(
            //     decoration: BoxDecoration(
            //         color: (widget.brand != null && isData)
            //             ? AppColor.boderColor
            //             : null,
            //         borderRadius: BorderRadius.circular(10),
            //         border: Border.all(color: Colors.black)),
            //     child: Padding(
            //       padding:
            //           const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            //       child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: brand == null
            //               ? [
            //                   const Text("Chọn thương hiệu",
            //                       style: TxtStyle.heading4),
            //                 ]
            //               : [
            //                   Text(brand!.name.toString(),
            //                       overflow: TextOverflow.ellipsis,
            //                       maxLines: 1,
            //                       style: TxtStyle.heading4),
            //                   Text("<" + brand!.phoneNumber.toString() + ">",
            //                       // overflow: TextOverflow.ellipsis,
            //                       style: TxtStyle.heading4),
            //                 ]),
            //     )),
          );
        } else {
          return Text("$state");
        }
      },
    );
  }
}
