import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/district.dart';
import 'package:crel_mobile/modules/mission/blocs/district/district_bloc.dart';
import 'package:crel_mobile/modules/mission/blocs/ward/ward_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoseDistrict extends StatefulWidget {
  final Function(District) callback;
  const ChoseDistrict({Key? key, required this.callback}) : super(key: key);

  @override
  State<ChoseDistrict> createState() => _ChoseDistrictState();
}

class _ChoseDistrictState extends State<ChoseDistrict> {
  final _searchController = TextEditingController();
  List<District> listDistrict = [];
  String nameDistrict = "Chọn quận";
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          flex: 2,
          child: Text(
            "Quận: ",
            style: TxtStyle.heading3.copyWith(fontWeight: FontWeight.normal),
          )),
      Expanded(
          flex: 5,
          child: BlocConsumer<DistrictBloc, DistrictState>(
            listener: (context, state) {
              if (state is DistrictError) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("DistrictError")));
              }
            },
            builder: (context, state) {
              if (state is DistrictLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is DistrictLoaded) {
                return InkWell(
                  onTap: () {
                    listDistrict = state.districts;
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
                                        listDistrict = state.districts
                                            .where((districtName) =>
                                                districtName.name!
                                                    .toLowerCase()
                                                    .contains(
                                                        value.toLowerCase()))
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
                                      itemCount: listDistrict.length,
                                      controller: scrollController,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            widget
                                                .callback(listDistrict[index]);
                                            setState(() {
                                              nameDistrict =
                                                  listDistrict[index].name!;
                                              _searchController.clear();
                                            });

                                            context.read<WardBloc>().add(
                                                GetWardByDistrictIdRequested(
                                                    listDistrict[index].id!));
                                            Navigator.pop(
                                                context, nameDistrict);
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
                                                  listDistrict[index]
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
                      child: Text(nameDistrict,
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
