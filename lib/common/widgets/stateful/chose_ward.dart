import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/ward.dart';
import 'package:crel_mobile/modules/mission/blocs/ward/ward_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoseWard extends StatefulWidget {
  final Function(Ward) callback;
  const ChoseWard({Key? key, required this.callback}) : super(key: key);

  @override
  State<ChoseWard> createState() => _ChoseWardState();
}

class _ChoseWardState extends State<ChoseWard> {
  final _searchController = TextEditingController();
  List<Ward> listWard = [];
  String nameWard = "Chọn phường, xã, thị trấn";
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 2,
          child: Text(
            "Phường, xã, thị trấn: ",
            style: TxtStyle.heading3.copyWith(fontWeight: FontWeight.normal),
          )),
      Expanded(
          flex: 5,
          child: BlocConsumer<WardBloc, WardState>(
            listener: (context, state) {
              if (state is WardError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("WardError")));
              }
            },
            builder: (context, state) {
              if (state is WardLoading) {
                return Container(
                  decoration: BoxDecoration(
                      color: AppColor.boderColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(nameWard,
                        overflow: TextOverflow.ellipsis,
                        style: TxtStyle.heading4),
                  ),
                );
              }
              if (state is WardLoaded) {
                return InkWell(
                  onTap: () {
                    listWard = state.ward;
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
                                        "Nhập tên quận",
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
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1,
                                          color: AppColor.boderColor)),
                                  child: TextField(
                                    onChanged: (value) {
                                      setState1(() {
                                        listWard = state.ward
                                            .where((wardName) => wardName.name!
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
                                      itemCount: listWard.length,
                                      controller: scrollController,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            widget.callback(listWard[index]);
                                            setState(() {
                                              nameWard = listWard[index].name!;
                                              _searchController.clear();
                                            });
                                            Navigator.pop(context, nameWard);
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
                                                child: Text(
                                                  listWard[index]
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
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(nameWard,
                          overflow: TextOverflow.ellipsis,
                          style: TxtStyle.heading4),
                    ),
                  ),
                );
              } else {
                return Text("$state");
              }
            },
          ))
    ]);
  }
}
