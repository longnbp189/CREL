import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/models/owner.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:crel_mobile/modules/mission/widgets/choose_text_from_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChosePropertyContract extends StatefulWidget {
  final Function(Property) callback;
  final Property? property;
  const ChosePropertyContract({Key? key, required this.callback, this.property})
      : super(key: key);

  @override
  State<ChosePropertyContract> createState() => _ChosePropertyContractState();
}

class _ChosePropertyContractState extends State<ChosePropertyContract> {
  final _paymentTermController = TextEditingController();
  final _priceController = TextEditingController();
  final _propertyNameController = TextEditingController();
  final _propertyAddressController = TextEditingController();

  Owner returnOwner = Owner();
  bool isOwner = true;

  callbackOwner(returnData) {
    setState(() {
      returnOwner = returnData;
      isOwner = true;

      // returnOwner = widget.contract.owner;
    });
  }

  final _searchController = TextEditingController();
  List<Property> listProperty = [];
  // String nameBrand = "Chọn thương hiệu";
  Property? property;
  bool isData = true;

  @override
  void dispose() {
    _paymentTermController.dispose();
    _priceController.dispose();
    _propertyAddressController.dispose();
    _propertyNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _paymentTermController.text =
        widget.property != null ? widget.property!.paymentTerm! : "";
    _priceController.text = widget.property != null
        ? AppFormat.changePriceVN(widget.property!.price.toString())
        : "";
    _propertyAddressController.text =
        widget.property != null ? AppFormat.getAddress(widget.property!) : "";
    _propertyNameController.text =
        widget.property != null ? widget.property!.name! : "";
  }

  @override
  Widget build(BuildContext context) {
    if (isData) {
      property = widget.property;
      isData = false;
    }
    return BlocConsumer<PropertyForRentBloc, PropertyForRentState>(
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
        if (state is PropertyForRentIdLoaded) {
          return Column(
            children: const [
              // ChooseTextFromDrop(
              //   isDisable: true,
              //   lable: "Mặt bằng",
              //   textController: _propertyNameController,
              // ),
              // Container(
              //     decoration: BoxDecoration(
              //         color:
              //             widget.property != null ? AppColor.boderColor : null,
              //         borderRadius: BorderRadius.circular(10),
              //         border: Border.all(color: Colors.black)),
              //     child: Padding(
              //       padding:
              //           const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              //       child: Text(state.property.name.toString(),
              //           overflow: TextOverflow.ellipsis,
              //           maxLines: 1,
              //           style: TxtStyle.heading4),
              //     )),
              // SizedBox(
              //   height: 8,
              // ),
              // ChooseTextFromDrop(
              //   isDisable: true,
              //   lable: "Địa chỉ",
              //   textController: _propertyAddressController,
              // ),
            ],
          );
        }
        if (state is PropertyForRentLoaded) {
          return Column(
            children: [
              InkWell(
                  onTap: (widget.property != null && isData)
                      ? null
                      : () {
                          listProperty = state.propertyForRents;
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
                                  builder: (context, scrollController) =>
                                      Column(
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
                                              "Nhập tiêu đề mặt bằng",
                                              style: TxtStyle.heading4.copyWith(
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
                                              listProperty = state
                                                  .propertyForRents
                                                  .where((brandtName) =>
                                                      brandtName.name!
                                                          .toLowerCase()
                                                          .contains(value
                                                              .toLowerCase()))
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
                                            itemCount: listProperty.length,
                                            controller: scrollController,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  widget.callback(
                                                      listProperty[index]);
                                                  setState(() {
                                                    property =
                                                        listProperty[index];
                                                    _propertyNameController
                                                            .text =
                                                        listProperty[index]
                                                            .name!;
                                                    _searchController.clear();
                                                  });
                                                  Navigator.pop(
                                                      context, property);
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          border: Border(
                                                    top: BorderSide(
                                                      color:
                                                          AppColor.boderColor,
                                                      width: 1,
                                                    ),
                                                    bottom: BorderSide(
                                                      color:
                                                          AppColor.boderColor,
                                                      width: 1,
                                                    ),
                                                  )),
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 16,
                                                        vertical: 8,
                                                      ),
                                                      child: Text(
                                                        listProperty[index]
                                                            .name
                                                            .toString(),
                                                        style:
                                                            TxtStyle.heading4,
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
                    lable: _propertyNameController.text != ""
                        ? "Mặt bằng"
                        : "Chọn mặt bằng",
                    textController: _propertyNameController,
                  )
                  // Container(
                  //     decoration: BoxDecoration(
                  //         color: (widget.property != null && isData)
                  //             ? AppColor.boderColor
                  //             : null,
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(color: Colors.black)),
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //           vertical: 8, horizontal: 8),
                  //       child: widget.property == null
                  //           ? const Text("Chọn mặt bằng",
                  //               style: TxtStyle.heading4)
                  //           : Text(property!.name.toString(),
                  //               overflow: TextOverflow.ellipsis,
                  //               maxLines: 1,
                  //               style: TxtStyle.heading4),
                  //     ))
                  )
            ],
          );
        }

        return Text("$state");
      },
    );
  }
}
