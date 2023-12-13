import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/models/owner.dart';
import 'package:crel_mobile/modules/mission/widgets/choose_text_from_drop.dart';
import 'package:flutter/material.dart';

class ChoseOwnerContract extends StatefulWidget {
  final Function(Owner) callback;
  final Property? property;
  final Owner? owner;
  final bool isDiable;
  const ChoseOwnerContract(
      {Key? key,
      required this.callback,
      this.owner,
      this.property,
      required this.isDiable})
      : super(key: key);

  @override
  State<ChoseOwnerContract> createState() => _ChoseOwnerContractState();
}

class _ChoseOwnerContractState extends State<ChoseOwnerContract> {
  final _ownerNameController = TextEditingController();
  List<Owner> listOwner = [];
  // String nameOwner = "Chọn chủ sở hữu";
  Owner? owner;

  @override
  void initState() {
    // _ownerNameController.text =
    //     widget.property != null ? widget.property!.owners![0].name! : "";
    super.initState();
  }

  @override
  void dispose() {
    _ownerNameController.dispose();
    super.dispose();
  }

  bool isData = true;
  bool isInitData = true;
  Property? property1;

  @override
  Widget build(BuildContext context) {
    if (widget.property != property1) {
      property1 = widget.property;
      isData = true;
    }
    if (isData) {
      owner = widget.owner;

      // isData = false;
    }
    if (owner == null) {
      _ownerNameController.text = "---Vui lòng chọn mặt bằng---";
    } else {
      // setState(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _ownerNameController.text = owner!.name!;

        // Add Your Code here.
      });
      // });
    }
    // if (widget.owner != null) {
    //   owner = widget.owner;
    // }
    return InkWell(
      onTap: (widget.property == null && isData || widget.isDiable)
          ? null
          : () {
              listOwner = widget.property!.owners!;
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState1) => DraggableScrollableSheet(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      // _searchController.clear();
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(Icons.close)),
                                Text(
                                  "Nhập tên người cho thuê",
                                  style: TxtStyle.heading3
                                      .copyWith(fontWeight: FontWeight.bold),
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
                          Expanded(
                            child: ListView.builder(
                                // physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: listOwner.length,
                                controller: scrollController,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      // setState(() {
                                      isData = false;

                                      owner = listOwner[index];
                                      // _searchController.clear();
                                      _ownerNameController.text =
                                          listOwner[index].name!;
                                      // "Nguyễn Thúc Thùy Tiên Huỳnh Duyên";
                                      widget.callback(listOwner[index]);
                                      // }
                                      // );
                                      Navigator.pop(context, owner);
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
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                listOwner[index]
                                                    .name
                                                    .toString(),
                                                style: TxtStyle.heading4,
                                              ),
                                              Text(
                                                listOwner[index]
                                                    .phoneNumber
                                                    .toString(),
                                                style: TxtStyle.heading4,
                                              ),
                                            ],
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
        isDisable: widget.isDiable,
        lable: owner != null ? "Người cho thuê" : "Chọn người cho thuê",
        textController: _ownerNameController,
      ),
    );
  }
}
