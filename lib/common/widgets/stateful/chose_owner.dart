import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/models/owner.dart';
import 'package:flutter/material.dart';

class ChoseOwner extends StatefulWidget {
  final Function(Owner) callback;
  final Property? property;
  final Owner? owner;
  const ChoseOwner(
      {Key? key, required this.callback, this.owner, this.property})
      : super(key: key);

  @override
  State<ChoseOwner> createState() => _ChoseOwnerState();
}

class _ChoseOwnerState extends State<ChoseOwner> {
  // final _searchController = TextEditingController();
  List<Owner> listOwner = [];
  // String nameOwner = "Chọn chủ sở hữu";
  Owner? owner;

  @override
  void initState() {
    super.initState();
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
    // if (widget.owner != null) {
    //   owner = widget.owner;
    // }
    return Row(children: [
      const Expanded(
          flex: 2,
          child: Text(
            "Chủ sở hữu: ",
            style: TxtStyle.heading4,
          )),
      Expanded(
          flex: 5,
          child: InkWell(
            onTap: (widget.property == null && isData)
                ? null
                : () {
                    listOwner = widget.property!.owners!;
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
                                            // _searchController.clear();
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(Icons.close)),
                                      Text(
                                        "Nhập tên chủ sở hữu",
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
                                Expanded(
                                  child: ListView.builder(
                                      // physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: listOwner.length,
                                      controller: scrollController,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              isData = false;

                                              owner = listOwner[index];
                                              // _searchController.clear();

                                              widget.callback(listOwner[index]);
                                            });
                                            Navigator.pop(context, owner);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
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
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
            child: Container(
              decoration: BoxDecoration(
                  color: widget.property == null ? AppColor.boderColor : null,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: owner == null
                        ? [
                            const Text("---Vui lòng chọn mặt bằng---",
                                style: TxtStyle.heading4),
                          ]
                        : [
                            Text(owner!.name.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TxtStyle.heading4),
                            Text("<" + owner!.phoneNumber.toString() + ">",
                                // overflow: TextOverflow.ellipsis,
                                style: TxtStyle.heading4),
                          ]),
              ),
            ),
          ))
    ]);
  }
}
